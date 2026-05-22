//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .textFieldStyle(.roundedBorder)
      .font(.title)
      .fontWeight(.light)
      .padding(.vertical)
      .lineLimit(3)
      .submitLabel(.done)
  }
}

#Preview {
  @Previewable @State var text: String = "An adorable astronaut panda."
  
  return VStack {
    TextField("Imagine Something", text: .constant(text))
      .modifier(TextFieldModifier())
      .padding()
  }
}
