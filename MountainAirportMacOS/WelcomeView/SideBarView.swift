
import SwiftUI

enum DisplayState: Int {
  case flightBoard
  case searchFlights
  case awards
  case timeline
  case lastFlight
  case none
}

struct SideBarView: View {
  @StateObject private var appEnvironment = AppEnvironment()
  @State private var showNextFlight = false
  @SceneStorage("displayState") var displayState: DisplayState = .none
  @SceneStorage("lastViewedFlightID") var lastViewedFlightID: Int?
  var flightInfo: FlightData
  
  var lastViewedFlight: FlightInformation? {
    if let id = lastViewedFlightID {
      return flightInfo.getFlightById(id)
    }
    return nil
  }
  
  
  var body: some View {
    VStack {
      WelcomeAnimation()
        .foregroundColor(.white)
        .frame(height: 40)
        .padding([.top, .bottom])
      VStack {
        Button { displayState = .flightBoard } label: {
          FlightStatusButton() }.buttonStyle(.plain)
        Button { displayState = .searchFlights } label: {
          SearchFlightsButton() }.buttonStyle(.plain)
        Button { displayState = .awards } label: {
          AwardsButton() }.buttonStyle(.plain)
        Button { displayState = .timeline } label: {
          TimelineButton() }.buttonStyle(.plain)
        if let lastFlight = lastViewedFlight {
          Button {
            displayState = .lastFlight
            showNextFlight = true
          } label: {
            LastViewedButton(lastFlight: lastFlight)
          }.buttonStyle(.plain)
        }
      }
      .padding()
      Spacer()
    }
    .frame(minWidth: 190, idealWidth: 190, maxWidth: .infinity,
           minHeight: 800, idealHeight: 800, maxHeight: .infinity)
    .background(Image("welcome-background")
      .resizable()
      .aspectRatio(contentMode: .fill)
    )
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    SideBarView(flightInfo: FlightData())
      .previewLayout(.fixed(width: 190, height: 800))
  }
}
