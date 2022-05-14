
import SwiftUI

@main
struct MountainAirportMacOSApp: App {
  var body: some Scene {
    WindowGroup {
      MainView()
    }
    .commands {
      SidebarCommands()
    }
  }
}
