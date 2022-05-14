
import SwiftUI

struct FlightStatusButton: View {
  
  var body: some View {
    WelcomeButtonView(
      title: "Flight Status",
      subTitle: "Departure and arrival information",
      imageName: "airplane",
      imageAngle: -45.0
    )
    
  }
}

struct FlightStatusButton_Previews: PreviewProvider {
  static var previews: some View {
    FlightStatusButton()
  }
}
