//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy 
//  Created by Robert Petras
//

import SwiftUI
import ImagePlayground

struct ImagePlaygroundBasicView: View {
  // MARK: - PROPERTIES
  
  @Environment(\.supportsImagePlayground) private var supportsImagePlayground
  
  @State private var isShowingImagePlayground: Bool = false
  @State private var description: String = "An adorable astronaut panda with a heart balloon is hovering in purple space."
  @State private var imageURL: URL?
  
  init(useDemoImageinPreview: Bool = false) {
    if useDemoImageinPreview {
      _imageURL = State(initialValue: URL(string: "https://credo.academy/resources/pixie-app-image.jpg"))
    }
  }
  
  var body: some View {
    if supportsImagePlayground {
      VStack {
        Spacer()
        
        // MARK: - IMAGE
        
        AsyncImage(url: imageURL) { image in
          image
            .imageStyle()
        } placeholder: {
          ImagePlaceholderView()
        }
        
        Spacer()
        
        // MARK: - TEXTFIELD
        
        TextField("Imagine Something", text: $description, axis: .vertical)
          .modifier(TextFieldModifier())
        
        // MARK: - BUTTON
        
        Button {
          isShowingImagePlayground = true
        } label: {
          Text("Create Image")
            .padding(8)
        }
        .modifier(ButtonModifier())
        
      } //: VSTACK
      .padding()
      .tint(.purple)
      .imagePlaygroundSheet(isPresented: $isShowingImagePlayground, concept: description) { url in
        imageURL = url
      }
      .imagePlaygroundPersonalizationPolicy(.disabled)
    } else {
      ContentUnavailableView("Not Available", systemImage: "apple.image.playground", description: Text("Image generation with Apple Intelligence is not supported on this device."))
    }
  }
}

#Preview {
  ImagePlaygroundBasicView(useDemoImageinPreview: true)
}
