//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import SwiftUI

struct ShareImageButtonView: View {
  let url: URL
  let title: String = "Share Image"
  let systemImage: String = "square.and.arrow.up"
  
  var body: some View {
    ShareLink(item: url) {
      Label(title, systemImage: systemImage)
        .bold()
        .imageScale(.large)
        .font(.title3)
        .padding(8)
    }
    .tint(.purple)
    .buttonStyle(.bordered)
    .buttonSizing(.flexible)
    .glassEffect()
  }
}

#Preview {
  ShareImageButtonView(url: URL(string: "https://credo.academy/resources/pixie-app-image.jpg")!)
    .padding()
}
