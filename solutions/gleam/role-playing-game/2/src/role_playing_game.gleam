import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(name) -> name
    None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health, player.level {
    0, level if level >= 10 ->
      Player(..player, health: 100, mana: Some(100))
      |> Some()
    0, _ -> Player(..player, health: 100) |> Some()
    _, _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana, cost {
    None, _ -> #(
      Player(..player, health: updated_health(player.health - cost)),
      0,
    )
    Some(mana), cost if cost >= mana -> #(player, 0)
    Some(mana), cost -> #(Player(..player, mana: Some(mana - cost)), cost * 2)
  }
}

fn updated_health(health: Int) -> Int {
  case health {
    health if health < 0 -> 0
    _ -> health
  }
}
