package blackjack

// CardValues is a map where key is the card name and card's value is the value
var CardValues = map[string]int{
	"ace": 11, "three": 3,
	"two": 2, "four": 4, "five": 5,
	"six": 6, "seven": 7, "eight": 8,
	"nine": 9, "ten": 10, "jack": 10,
	"queen": 10, "king": 10}

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	return CardValues[card]
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	sum := ParseCard(card1) + ParseCard(card2)
	dealerCardValue := ParseCard(dealerCard)

	if sum == 22 {
		return "P"
	}

	if sum == 21 {
		if dealerCardValue == 10 || dealerCardValue == 11 {
			return "S"
		}
		return "W"
	}

	if sum >= 17 && sum <= 20 {
		return "S"
	}

	if sum >= 12 && sum <= 16 {
		if dealerCardValue >= 7 {
			return "H"
		}
		return "S"
	}

	return "H"
}
