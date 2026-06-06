let leap_year n =
  if n mod 100 = 0 then (n mod 400 = 0)
  else n mod 4 = 0
