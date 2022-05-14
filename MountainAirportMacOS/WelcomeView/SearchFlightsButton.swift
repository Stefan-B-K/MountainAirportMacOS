
import SwiftUI

struct SearchFlightsButton: View {
  
  var body: some View {
    WelcomeButtonView(
      title: "Search Flights",
      subTitle: "Search upcoming flights",
      imageName: "magnifyingglass"
    )
  }
}

struct SearchFlightsButton_Previews: PreviewProvider {
  static var previews: some View {
    SearchFlightsButton()
  }
}
