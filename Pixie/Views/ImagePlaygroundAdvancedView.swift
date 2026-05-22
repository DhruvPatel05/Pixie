//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy 
//  Created by Robert Petras
//

import SwiftUI
import ImagePlayground

struct ImagePlaygroundAdvancedView: View {
  // MARK: - PROPERTIES
  
  @Environment(\.supportsImagePlayground) private var supportsImagePlayground
  @FocusState private var isTextFieldFocused: Bool
  @AppStorage("lastImagePath") private var lastImagePath: String = ""
  @AppStorage("sound") var isSoundEnabled: Bool = true
  
  @State private var isShowingImagePlayground: Bool = false
  @State private var description: String = Prompts.presets.randomElement() ?? ""
  @State private var imageURL: URL?
  
  init(useDemoImageinPreview: Bool = false) {
    if useDemoImageinPreview {
      _imageURL = State(initialValue: URL(string: "https://credo.academy/resources/pixie-app-image.jpg"))
    }
  }
  
  private var isPad: Bool {
    UIDevice.current.userInterfaceIdiom == .pad
  }
  
  private var imageSize: CGFloat {
    isPad ? 560 : 280
  }
  
  var body: some View {
    NavigationStack {
      if supportsImagePlayground {
        VStack {
          Spacer()
          
          // MARK: - IMAGE
          
          AsyncImage(url: imageURL) { image in
            image
              .imageStyle(width: imageSize)
          } placeholder: {
            ImagePlaceholderView()
          }
          
          Spacer()
          
          if let imageURL = imageURL {
            // MARK: - SHARE LINK
            
            ShareImageButtonView(url: imageURL)
          } else {
            // MARK: - TEXTFIELD
            
            TextField("Imagine Something", text: $description, axis: .vertical)
              .modifier(TextFieldModifier())
              .focused($isTextFieldFocused)
              .onSubmit {
                isTextFieldFocused = false
              }
            
            // MARK: - BUTTON
            
            Button {
              if isSoundEnabled {
                playSound(fileName: "chimeup", audioType: "mp3")
              }
              
              isShowingImagePlayground = true
            } label: {
              Text("Create Image")
                .padding(8)
            }
            .modifier(ButtonModifier())
          }
        } //: VSTACK
        .padding()
        .tint(.purple)
        // MARK: - SHEET
        .imagePlaygroundSheet(isPresented: $isShowingImagePlayground, concept: description) { url in
          if let imageURL {
            try? FileManager.default.removeItem(at: imageURL)
          }
          let newImageURL = URL.documentsDirectory.appending(path: "genImage-\(UUID().uuidString).png")
          try? FileManager.default.moveItem(at: url, to: newImageURL)
          withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            imageURL = newImageURL
          }
        }
        .imagePlaygroundPersonalizationPolicy(.disabled)
        // MARK: - TOOLBAR
        .toolbar {
          if imageURL == nil {
            // Generate a Random Prompt
            ToolbarItem(placement: .topBarTrailing) {
              Button {
                if let randomPrompt = Prompts.presets.randomElement() {
                  withAnimation(.snappy) {
                    description = randomPrompt
                  }
                }
              } label: {
                Label("Random Prompt", systemImage: "shuffle")
              }
              .disabled(Prompts.presets.isEmpty)
              .help("Insert a random prompt.")
            }
            
            // Clear the TextField
            ToolbarItem(placement: .topBarTrailing) {
              Button {
                withAnimation(.easeOut) {
                  description = ""
                }
              } label: {
                Label("Clear the textfield", systemImage: "xmark.circle")
              }
              .disabled(description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
              .help("Clear the textfield.")
            }
          } else {
            // Delete the generated image
            ToolbarItem(placement: .topBarTrailing) {
              Button {
                withAnimation(.easeInOut) {
                  imageURL = nil
                  description = ""
                  isTextFieldFocused = false
                }
              } label: {
                Label("Delete Image", systemImage: "trash")
              }
              .disabled(imageURL == nil)
              .help("Delete the generated image.")
            }
          }
        } //: TOOLBAR
        .onChange(of: imageURL) { oldValue, newValue in
          lastImagePath = newValue?.path ?? ""
        }
        .onAppear {
          if !lastImagePath.isEmpty {
            imageURL = URL(fileURLWithPath: lastImagePath)
          }
        }
      } else {
        ContentUnavailableView("Not Available", systemImage: "apple.image.playground", description: Text("Image generation with Apple Intelligence is not supported on this device."))
      }
    } //: NAVSTACK
  }
}

#Preview {
  ImagePlaygroundAdvancedView(useDemoImageinPreview: true)
}
