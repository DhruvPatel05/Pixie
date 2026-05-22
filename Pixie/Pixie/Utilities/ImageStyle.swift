//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import Foundation
import ImagePlayground

enum ImageStyle: String, CaseIterable, Identifiable {
  case animation
  case illustration
  case sketch
  
  var id: String { rawValue }
  
  var label: String {
    switch self {
    case .animation: return "Animation"
    case .illustration: return "Illustration"
    case .sketch: return "Sketch"
    }
  }
  
  var symbolName: String {
    switch self {
    case .animation: return "sparkles"
    case .illustration: return "paintbrush.pointed.fill"
    case .sketch: return "pencil.and.outline"
    }
  }
  
  var imageStyle: ImagePlaygroundStyle {
    switch self {
    case .animation: return .animation
    case .illustration: return .illustration
    case .sketch: return .sketch
    }
  }
}
