import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(pizza) -> 1 + pizza_price(pizza)
    ExtraToppings(pizza) -> 2 + pizza_price(pizza)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let pizzas_price =
    list.fold(order, 0, fn(acc, pizza) { acc + pizza_price(pizza) })

  case order {
    [_] -> pizzas_price + 3
    [_, _] -> pizzas_price + 2
    _ -> pizzas_price
  }
}
