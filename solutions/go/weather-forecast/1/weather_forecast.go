// Package weather has utility functions that provides weather information.
package weather

// CurrentCondition describes current weather condition.
var CurrentCondition string

// CurrentLocation is the location of user.
var CurrentLocation string

// Forecast returns a string describing the current weather condition.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
