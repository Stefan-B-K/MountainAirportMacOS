
import SwiftUI

struct FlightDetails: View {
  var flight: FlightInformation?
  @SceneStorage("lastViewedFlightID") var lastViewedFlightID: Int?
  
  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      if let flight = flight {
        VStack(alignment: .leading) {
          FlightDetailHeader(flight: flight)
          FlightInfoPanel(flight: flight)
            .padding()
            .background(RoundedRectangle(cornerRadius: 20.0)
              .opacity(0.3))
          Spacer()
        }
        .foregroundColor(.white)
        .padding()
        .navigationTitle("\(flight.airline) Flight \(flight.number)")
        .onAppear { lastViewedFlightID = flight.id }
      }
    }
    .frame(minWidth: 350, minHeight: 350)
  }
}

struct FlightDetails_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FlightDetails(
        flight: FlightData.generateTestFlight(date: Date())
      )
      .environmentObject(AppEnvironment())
    }
  }
}
