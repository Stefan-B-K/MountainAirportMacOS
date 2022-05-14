
import SwiftUI

struct TimelineButton: View {
  
  var body: some View {
    WelcomeButtonView(
      title: "Flight Timeline",
      subTitle: "Flight Timeline",
      imageName: "timelapse")
  }
}

struct TimelineButton_Previews: PreviewProvider {
  static var previews: some View {
    TimelineButton()
  }
}

