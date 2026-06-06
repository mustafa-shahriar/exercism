import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Forth {
  Forth(stack: List(Int), op: Dict(String, List(String)))
}

pub type ForthError {
  DivisionByZero
  StackUnderflow
  InvalidWord
  UnknownWord
}

pub fn new() -> Forth {
  let dict =
    dict.from_list([
      #("+", ["+"]),
      #("-", ["-"]),
      #("*", ["*"]),
      #("/", ["/"]),
      #("dup", ["dup"]),
      #("drop", ["drop"]),
      #("over", ["over"]),
      #("swap", ["swap"]),
    ])
  Forth([], dict)
}

pub fn format_stack(f: Forth) -> String {
  f.stack
  |> list.reverse()
  |> list.map(int.to_string)
  |> string.join(with: " ")
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  case prog {
    ": " <> rest ->
      handle_command(f, string.lowercase(rest) |> string.replace(" ;", ""))
    _ -> exec(f, prog |> string.lowercase() |> string.split(" "))
  }
}

fn exec(f: Forth, prog: List(String)) -> Result(Forth, ForthError) {
  case prog {
    [] -> f |> Ok()
    [a, ..rest] ->
      case int.parse(a) {
        Ok(_) ->
          case exec_cmd(f, [a]) {
            Ok(f) -> exec(f, rest)
            Error(err) -> Error(err)
          }
        _ ->
          case dict.get(f.op, a) {
            Ok(op) ->
              case exec_cmd(f, op) {
                Ok(f) -> exec(f, rest)
                Error(err) -> Error(err)
              }
            Error(_) -> Error(UnknownWord)
          }
      }
  }
}

fn exec_cmd(f: Forth, cmds: List(String)) -> Result(Forth, ForthError) {
  case cmds {
    [] -> f |> Ok()
    [cmd, ..rest] -> {
      case int.parse(cmd) {
        Ok(n) -> Forth(..f, stack: [n, ..f.stack]) |> exec_cmd(rest)
        _ -> {
          case cmd {
            "+" ->
              case arity_two_op(f, int.add) {
                Ok(f) -> exec_cmd(f, rest)
                Error(err) -> Error(err)
              }

            "-" ->
              case arity_two_op(f, int.subtract) {
                Ok(f) -> exec_cmd(f, rest)
                Error(err) -> Error(err)
              }
            "*" ->
              case arity_two_op(f, int.multiply) {
                Ok(f) -> exec_cmd(f, rest)
                Error(err) -> Error(err)
              }
            "/" ->
              case f.stack {
                [a, b, ..rest_cmd] ->
                  case int.divide(b, a) {
                    Error(_) -> Error(DivisionByZero)
                    Ok(n) -> {
                      let forth = Forth(..f, stack: [n, ..rest_cmd])
                      exec_cmd(forth, rest)
                    }
                  }
                _ -> Error(StackUnderflow)
              }
            "dup" ->
              case dup(f) {
                Ok(f) -> exec_cmd(f, rest)
                Error(err) -> Error(err)
              }
            "drop" ->
              case drop(f) {
                Ok(f) -> exec_cmd(f, rest)
                Error(err) -> Error(err)
              }
            "swap" ->
              case swap(f) {
                Ok(f) -> exec_cmd(f, rest)
                Error(err) -> Error(err)
              }
            "over" ->
              case over(f) {
                Ok(f) -> exec_cmd(f, rest)
                Error(err) -> Error(err)
              }
            _ -> Error(UnknownWord)
          }
        }
      }
    }
  }
}

fn arity_two_op(f: Forth, func) -> Result(Forth, ForthError) {
  case f.stack {
    [a, b, ..rest] -> Forth(..f, stack: [func(b, a), ..rest]) |> Ok()
    _ -> Error(StackUnderflow)
  }
}

fn dup(f: Forth) -> Result(Forth, ForthError) {
  case f.stack {
    [a, ..rest] -> Forth(..f, stack: [a, a, ..rest]) |> Ok()
    _ -> Error(StackUnderflow)
  }
}

fn drop(f: Forth) -> Result(Forth, ForthError) {
  case f.stack {
    [_, ..rest] -> Forth(..f, stack: rest) |> Ok()
    _ -> Error(StackUnderflow)
  }
}

fn swap(f: Forth) -> Result(Forth, ForthError) {
  case f.stack {
    [a, b, ..rest] -> Forth(..f, stack: [b, a, ..rest]) |> Ok()
    _ -> Error(StackUnderflow)
  }
}

fn over(f: Forth) -> Result(Forth, ForthError) {
  case f.stack {
    [a, b, ..rest] -> Forth(..f, stack: [b, a, b, ..rest]) |> Ok()
    _ -> Error(StackUnderflow)
  }
}

fn handle_command(f: Forth, cmds: String) -> Result(Forth, ForthError) {
  let assert [command, ..args] = string.split(cmds, " ")
  case int.parse(command) {
    Ok(_) -> Error(InvalidWord)
    _ -> {
      case
        list.any(args, fn(arg) {
          case int.parse(arg) {
            Ok(_) -> False
            _ -> !dict.has_key(f.op, arg)
          }
        })
      {
        True -> Error(UnknownWord)
        False -> {
          let op =
            dict.insert(
              f.op,
              command,
              list.flat_map(args, fn(arg) {
                case int.parse(arg) {
                  Ok(_) -> [arg]
                  _ -> dict.get(f.op, arg) |> result.unwrap([])
                }
              }),
            )
          Ok(Forth(..f, op: op))
        }
      }
    }
  }
}
