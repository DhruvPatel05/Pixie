//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Tab("Playground", systemImage: "apple.image.playground.fill") {
        ImagePlaygroundBasicView()
      }
      Tab("Advanced", systemImage: "spatial.capture") {
        ImagePlaygroundAdvancedView()
      }
      Tab("Image Creator", systemImage: "photo.on.rectangle.angled") {
        ImageCreatorView()
      }
      Tab("Settings", systemImage: "info.circle.fill") {
        SettingsView()
      }
    }
    .tabViewStyle(.sidebarAdaptable)
    .tint(.purple)
  }
}

#Preview {
  ContentView()
}
