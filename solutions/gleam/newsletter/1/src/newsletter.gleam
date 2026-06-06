import gleam/list
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case simplifile.read(path) {
    Ok(emails) ->
      emails
      |> string.trim()
      |> string.split("\n")
      |> Ok()
    Error(_) -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  case simplifile.create_file(path) {
    Ok(Nil) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  case simplifile.append(path, email <> "\n") {
    Ok(Nil) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  case create_log_file(log_path) {
    Ok(Nil) -> {
      case read_emails(emails_path) {
        Ok(emails) -> {
          emails
          |> list.each(fn(email) {
            case send_email(email) {
              Ok(Nil) -> log_sent_email(log_path, email)
              Error(Nil) -> Error(Nil)
            }
          })
          Ok(Nil)
        }
        Error(_) -> Error(Nil)
      }
    }
    _ -> Error(Nil)
  }
}
