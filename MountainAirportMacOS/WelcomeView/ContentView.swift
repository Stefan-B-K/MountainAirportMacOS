
import SwiftUI

struct ContentView: View {
  @SceneStorage("displayState") var displayState: DisplayState = .none
  @SceneStorage("lastViewedFlightID") var lastViewedFlightID: Int?
  @SceneStorage("selectedFlightID") var selectedFlightID: Int?
  var flightInfo: FlightData
  
  var selectedFlight: FlightInformation? {
    if let id = selectedFlightID {
      return flightInfo.getFlightById(id)
    }
    return nil
  }
  
  var lastViewedFlight: FlightInformation? {
    if let id = lastViewedFlightID {
      return flightInfo.getFlightById(id)
    }
    return nil
  }
  
  var body: some View {
    switch displayState {
    case .none:
      EmptyView()
    case .flightBoard:
      HStack {
        FlightStatusBoard(flights: flightInfo.getDaysFlights(Date()))
          .frame(minWidth: 250)
        FlightDetails(flight: selectedFlight)
      }
    case .searchFlights:
      SearchFlights(flightData: flightInfo.flights)
    case .awards:
      AwardsView()
    case .timeline:
      FlightTimelineView(
        flights: flightInfo.flights
          .filter {
            Calendar.current.isDate($0.localTime, inSameDayAs: Date())
          })
    case .lastFlight:
      FlightDetails(flight: lastViewedFlight)
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(flightInfo: FlightData())
  }
}
