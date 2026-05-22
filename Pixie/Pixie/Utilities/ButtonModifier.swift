//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import SwiftUI

struct ButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .buttonStyle(.borderedProminent)
      .buttonSizing(.flexible)
      .glassEffect()
      .font(.title)
      .fontWeight(.light)
  }
}

#Preview {
  VStack {
    Button("Create Image") {}
      .modifier(ButtonModifier())
  }
  .padding()
  .tint(.purple)
}
