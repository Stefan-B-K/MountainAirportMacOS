
import SwiftUI

struct MainView: View {
  @StateObject var flightInfo = FlightData()
  
  var body: some View {
    NavigationView {
      SideBarView(flightInfo: flightInfo)
      ContentView(flightInfo: flightInfo)
    }
    .navigationTitle("Mountain Airport")
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
