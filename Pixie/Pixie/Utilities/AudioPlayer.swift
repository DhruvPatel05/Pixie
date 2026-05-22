//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(fileName: String, audioType: String) {
  guard let url = Bundle.main.url(forResource: fileName, withExtension: audioType) else {
    print("Sound file not found.")
    return
  }
  
  do {
    audioPlayer = try AVAudioPlayer(contentsOf: url)
    audioPlayer?.play()
  } catch {
    print("Error playing sound: \(error.localizedDescription)")
  }
}
