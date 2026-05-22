//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import SwiftUI

extension Image {
  func imageStyle(width: CGFloat = 280) -> some View {
    self
      .resizable()
      .scaledToFit()
      .frame(width: width)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(color: .purple.opacity(0.35), radius: 8, x: 0, y: 2)
  }
}
