def is_armstrong_number(number):
    ns = str(number)
    ns_len = len(ns)
    sum = 0
    for cs in ns:
        sum += int(cs) ** ns_len
    return sum == number

