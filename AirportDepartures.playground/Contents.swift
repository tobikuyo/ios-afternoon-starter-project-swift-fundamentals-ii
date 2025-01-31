import UIKit
//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus: String {
    case enRoute = "En Route"
    case scheduled = "Scheduled"
    case cancelled = "Cancelled"
    case delayed = "Delayed"
    case landed = "Landed"
    case boarding = "Boarding"
}

struct Airport {
    var destination: String
}

struct Flight {
    var departureTime: Date?
    var terminal: String?
    var flightStatus: FlightStatus
}

class DepartureBoard {
    var flight: [Flight]
    var airport: Airport
    
    init(flight: [Flight], airport: Airport) {
        self.flight = flight
        self.airport = airport
    }
    
    func alertPassengers() {
        for flight in flight {
            switch flight.flightStatus {
            case .cancelled:
                print("We're sorry your flight to \(airport.destination) was canceled, here is a $500 voucher")
            case .scheduled:
                print("Your flight to \(airport.destination) is scheduled to depart at \(String(describing: flight.departureTime) ?? "TBD") from terminal: \(flight.terminal ?? "TBD")")
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
            case .delayed:
                print("Sorry, your flight has been cancelled.")
            default:
                print("Your flight is either on route or has landed.")
            }
            
            if flight.terminal == nil {
                print("See the nearest information desk for more details")
            }
        }
    }
}


let firstFlight = Flight(departureTime: Date(), terminal: "1A", flightStatus: .enRoute)
let secondFlight = Flight(departureTime: nil, terminal: nil , flightStatus: .cancelled)
let thirdFlight = Flight(departureTime: Date(), terminal: "2B" , flightStatus: .delayed)

let departureBoard = DepartureBoard(flight: [], airport: Airport(destination: "Madrid"))

departureBoard.flight.append(firstFlight)
departureBoard.flight.append(secondFlight)
departureBoard.flight.append(thirdFlight)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for flight in departureBoard.flight {
        if flight.flightStatus == .cancelled {
            print("Sorry your flight has been cancelled")
        } else {
            print("Your flight at terminal \(String(describing: flight.terminal)), is \(flight.flightStatus). It departs at \(String(describing: flight.departureTime))")
        }
    }
}

printDepartures(departureBoard: departureBoard)
//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
func printDepartures2(departuBoard: DepartureBoard) {
    for flight in departuBoard.flight {
        if let terminal = flight.terminal,
            let departureTime = flight.departureTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            
            let timeString = dateFormatter.string(from: departureTime)
            print("Your flight at terminal \(terminal), is \(flight.flightStatus.rawValue). It departs at \(timeString)")
        }
    }
}

printDepartures2(departuBoard: departureBoard)
//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
departureBoard.alertPassengers()
//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> String {
    let bagCost = 25
    let totalBagsCost = bagCost * checkedBags
    let mileCost = 0.10
    let distanceCost = mileCost * Double(distance)
    let ticketPrice = 150
    let totalCost = Double((ticketPrice * travelers)) + Double(totalBagsCost) + distanceCost
    
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    let totalCostString = numberFormatter.string(for: totalCost)!
    
    return totalCostString
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
