//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import SwiftUI

struct ImagePlaceholderView: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 16)
      .frame(width: 280, height: 280)
      .foregroundStyle(.quinary)
      .transition(.opacity)
      .overlay {
        Image(systemName: "apple.intelligence")
          .resizable()
          .scaledToFit()
          .frame(width: 96)
          .foregroundStyle(.background)
      }
  }
}

#Preview("Placeholder • Light") {
  ImagePlaceholderView()
}

#Preview("Placeholder • Dark") {
  ImagePlaceholderView()
    .preferredColorScheme(.dark)
}
