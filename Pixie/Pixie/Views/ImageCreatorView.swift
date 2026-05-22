//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy 
//  Created by Robert Petras
//

import SwiftUI
import ImagePlayground

struct ImageCreatorView: View {
  // MARK: - PROPERTIES
  
  @AppStorage("sound") var isSoundEnabled: Bool = true
  @FocusState private var isTextFieldFocused: Bool
  
  @State private var description: String = Prompts.presets.randomElement() ?? ""
  @State private var generatedImages = [Image]()
  @State private var imageCount: Int = 3
  @State private var selectedImageStyle: ImageStyle = .animation
  @State private var isGenerating: Bool = false
  @State private var completedCount: Int = 0
  
  // MARK: - FUNCTIONS
  
  func generateImages() async {
    isGenerating = true
    completedCount = 0
    defer { isGenerating = false }
    
    do {
      let creator = try await ImageCreator()
      let results = creator.images(for: [.text(description)], style: selectedImageStyle.imageStyle, limit: imageCount)
      
      generatedImages.removeAll()
      
      for try await result in results {
        let cgImage = result.cgImage
        let image = Image(cgImage, scale: 1, label: Text(description))
        generatedImages.append(image)
        completedCount += 1
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
  // MARK: - CONTENT
  
  var body: some View {
    NavigationStack {
      VStack {
        // MARK: - PROGRESS VIEW
        
        if isGenerating {
          ProgressView(value: Double(completedCount), total: Double(imageCount)) {
            Text("Generating \(selectedImageStyle.label.lowercased()) images")
              .bold()
              .padding(.bottom, 4)
          } currentValueLabel: {
            Text("\(completedCount) of \(imageCount)")
              .foregroundStyle(.purple)
              .padding(.top, 4)
          }
          .padding()
          .glassEffect(in: .rect(cornerRadius: 16))
          .padding(.horizontal)
          .transition(.opacity.combined(with: .move(edge: .top)))
          .animation(.easeInOut(duration: 0.5), value: isGenerating)
          .animation(.easeOut(duration: 1), value: completedCount)
        }
        
        Spacer()
        
        // MARK: - SCROLL VIEW
        
        ScrollView(.horizontal) {
          LazyHStack {
            ForEach(generatedImages.indices, id: \.self) { index in
              let image = generatedImages[index]
              
              VStack {
                image
                  .imageStyle()
                  .padding()
                
                ShareLink(item: image, preview: SharePreview(description, image: image)) {
                  Label("Share this image", systemImage: "square.and.arrow.up")
                    .font(.headline)
                }
              }
            }
          }
          .padding()
        } //: SCROLLVIEW
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.always)
        
        // MARK: - TEXTFIELD
        
        Spacer()
        
        TextField("Imagine Something", text: $description, axis: .vertical)
          .modifier(TextFieldModifier())
          .padding(.horizontal)
          .focused($isTextFieldFocused)
          .onSubmit {
            isTextFieldFocused = false
          }
        
        // MARK: - BUTTON
        
        Button {
          if isSoundEnabled {
            playSound(fileName: "chimeup", audioType: "mp3")
          }
          
          isTextFieldFocused = false
          
          Task(operation: generateImages)
        } label: {
          Text("Create Image")
            .padding()
        }
        .modifier(ButtonModifier())
        .padding([.horizontal, .bottom])
        .disabled(description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isGenerating)
      } //: VSTACK
      .tint(.purple)
      .sensoryFeedback(.selection, trigger: imageCount)
      .sensoryFeedback(.selection, trigger: selectedImageStyle)
      .sensoryFeedback(.success, trigger: completedCount == imageCount && imageCount > 0 && isGenerating == false)
      // MARK: - TOOLBAR
      .toolbar {
        // MARK: - IMAGE COUNT
        
        ToolbarItem(placement: .topBarTrailing) {
          Menu {
            Picker("Count", selection: $imageCount) {
              ForEach(1...4, id: \.self) { count in
                Label("^[\(count) image](inflect: true)", systemImage: count == 1 ? "photo" : "photo.fill.on.rectangle.fill")
                  .tag(count)
                  .tint(.purple)
              }
            }
          } label: {
            Label("\(imageCount)", systemImage: "photo.on.rectangle.angled")
          }
          .help("Select the number of images.")
        }
        
        // MARK: - IMAGE STYLES
        
        ToolbarItem(placement: .topBarTrailing) {
          Menu {
            Picker("Style", selection: $selectedImageStyle) {
              ForEach(ImageStyle.allCases) { style in
                Label(style.label, systemImage: style.symbolName)
                  .tag(style)
              }
            }
          } label: {
            Label(selectedImageStyle.label, systemImage: selectedImageStyle.symbolName)
          }
          .help("Select an image style.")
        }
        
        // MARK: - DELETE IMAGES
        
        ToolbarItem(placement: .topBarTrailing) {
          if !generatedImages.isEmpty {
            Button {
              withAnimation(.easeInOut) {
                description = ""
                generatedImages.removeAll()
                completedCount = 0
              }
            } label: {
              Label("Clear Image", systemImage: "trash")
            }
            .disabled(generatedImages.isEmpty)
            .help("Delete generated images.")
          }
        }
      }
    } //: NAVSTACK
  }
}

#Preview {
  ImageCreatorView()
}
