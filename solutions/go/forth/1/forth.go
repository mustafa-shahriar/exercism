package forth

import (
	"errors"
	"strconv"
	"strings"
)

func Forth(inputs []string) ([]int, error) {
	op := make(map[string][]string)
	stack := make([]int, 0, 10)

	defaultOp := [8]string{"+", "-", "*", "/", "dup", "swap", "over", "drop"}
	for _, key := range defaultOp {
		op[key] = make([]string, 0, 1)
		op[key] = append(op[key], key)
	}

	for _, input := range inputs {
		input = strings.ToLower(input)
		if strings.HasPrefix(input, ": ") {
			err := handle_command(&op, input)
			if err != nil {
				return nil, err
			}
		} else {
			err := exec(strings.Split(input, " "), &stack, &op)
			if err != nil {
				return nil, err
			}
		}
	}

	return stack, nil
}

func exec(args []string, stack *[]int, op *map[string][]string) error {
	for _, arg := range args {
		n, err := strconv.Atoi(arg)
		value := (*op)[arg]
		if err == nil {
			*stack = append(*stack, n)
		} else if len(value) != 0 {
			err := do_op(value, stack)
			if err != nil {
				return err
			}
		} else {
			return errors.New("InvalidWord")
		}
	}
	return nil
}

func do_op(ops []string, stack *[]int) error {
	for _, op := range ops {
		switch op {
		case "+":
			err := add(stack)
			if err != nil {
				return err
			}
		case "-":
			err := sub(stack)
			if err != nil {
				return err
			}
		case "*":
			err := mul(stack)
			if err != nil {
				return err
			}
		case "/":
			err := div(stack)
			if err != nil {
				return err
			}
		case "dup":
			err := dup(stack)
			if err != nil {
				return err
			}
		case "drop":
			err := drop(stack)
			if err != nil {
				return err
			}
		case "swap":
			err := swap(stack)
			if err != nil {
				return err
			}
		case "over":
			err := over(stack)
			if err != nil {
				return err
			}
		default:
			n, _ := strconv.Atoi(op)
			*stack = append(*stack, n)
		}
	}

	return nil
}

func drop(stack *[]int) error {
	stackLen := len(*stack)
	if stackLen < 1 {
		return errors.New("StackUnderFlow")
	}
	(*stack) = (*stack)[:stackLen-1]

	return nil
}

func dup(stack *[]int) error {
	stackLen := len(*stack)
	if stackLen < 1 {
		return errors.New("StackUnderFlow")
	}
	(*stack) = append((*stack), (*stack)[stackLen-1])

	return nil
}

func swap(stack *[]int) error {
	stackLen := len(*stack)
	if stackLen < 2 {
		return errors.New("StackUnderFlow")
	}
	temp := (*stack)[stackLen-2]
	(*stack)[stackLen-2] = (*stack)[stackLen-1]
	(*stack)[stackLen-1] = temp
	return nil
}

func over(stack *[]int) error {
	stackLen := len(*stack)
	if stackLen < 2 {
		return errors.New("StackUnderFlow")
	}
	(*stack) = append((*stack), (*stack)[stackLen-2])
	return nil
}

func add(stack *[]int) error {
	stackLen := len(*stack)
	if stackLen < 2 {
		return errors.New("StackUnderFlow")
	}
	(*stack)[stackLen-2] = (*stack)[stackLen-2] + (*stack)[stackLen-1]
	(*stack) = (*stack)[:stackLen-1]
	return nil
}

func sub(stack *[]int) error {
	stackLen := len(*stack)
	if stackLen < 2 {
		return errors.New("StackUnderFlow")
	}
	(*stack)[stackLen-2] = (*stack)[stackLen-2] - (*stack)[stackLen-1]
	(*stack) = (*stack)[:stackLen-1]
	return nil
}

func mul(stack *[]int) error {
	stackLen := len(*stack)
	if stackLen < 2 {
		return errors.New("StackUnderFlow")
	}
	(*stack)[stackLen-2] = (*stack)[stackLen-2] * (*stack)[stackLen-1]
	(*stack) = (*stack)[:stackLen-1]
	return nil
}

func div(stack *[]int) error {
	stackLen := len(*stack)
	if stackLen < 2 {
		return errors.New("StackUnderFlow")
	}
	if (*stack)[stackLen-1] == 0 {
		return errors.New("can't divide by zero")
	}

	(*stack)[stackLen-2] = (*stack)[stackLen-2] / (*stack)[stackLen-1]
	(*stack) = (*stack)[:stackLen-1]
	return nil
}

func handle_command(op *map[string][]string, cmds string) error {
	cmds = strings.Replace(cmds, ": ", "", 2)
	cmds = strings.Replace(cmds, " ;", "", 2)
	args := strings.Split(cmds, " ")
	argsLen := len(args)

	if _, err := strconv.Atoi(args[0]); err == nil {
		return errors.New("InvalidWord")
	}

	newOps := make([]string, 0, 1)
	for i := 1; i < argsLen; i++ {
		_, err := strconv.Atoi(args[i])
		value := (*op)[args[i]]
		if err == nil {
			newOps = append(newOps, args[i])
		} else if len(value) != 0 {
			newOps = append(newOps, value...)
		} else {
			return errors.New("InvalidWord")
		}
	}
	(*op)[args[0]] = newOps

	return nil
}
