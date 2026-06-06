class Obj:
    number = int
    name = str
    def __init__(self, n: int, na: str) -> None:
        self.number = n
        self.name = na

a = Obj(12, "m")
a.name = "munna"
print(a.name)

def steps(number : int) -> int:
    if number <= 0: raise ValueError("Only positive integers are allowed")
    ans = 0
    while number != 1:
        ans += 1
        if number % 2 == 0: number //= 2
        else: number = (3 * number) +1
    return ans
