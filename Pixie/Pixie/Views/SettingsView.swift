//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy 
//  Created by Robert Petras
//

import SwiftUI
import WebKit

struct SettingsView: View {
  @AppStorage("sound") var isSoundEnabled: Bool = true
  
  private let currentYear = Calendar.current.component(.year, from: Date())
  private let credoWebsite = URL(string: "https://credo.academy")!
  
  @State private var isShowingSheet: Bool = false
  
  var body: some View {
    Form {
      // MARK: - HEADER
      
      VStack(alignment: .center, spacing: 12) {
        Image(.launchScreenIcon)
          .resizable()
          .scaledToFit()
          .frame(width: 80)
          .padding(.top)
          .shadow(color: .purple.opacity(0.35), radius: 16)
        
        Text("Pixie AI")
          .font(.largeTitle)
          .fontWeight(.heavy)
          .foregroundStyle(.purple.gradient)
          .frame(maxWidth: .infinity, alignment: .center)
          .listRowSeparator(.hidden)
        
        Text("Pixie is a portfolio app that showcases Apple's on-device intelligence by generating images in various styles and offering additional features.")
          .multilineTextAlignment(.leading)
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .padding(.bottom)
      }
      
      // MARK: - FEATURE
      
      Section(header: Text("Settings")) {
        Toggle("Enable Sound", isOn: $isSoundEnabled)
          .padding(.top, 8)
          .tint(.purple)
        
        Text("This setting allows you to turn ON of OFF the sound effects used in the app.")
          .listRowSeparator(.hidden)
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .padding(.bottom, 8)
      }
      
      // MARK: - ABOUT 
      
      Section(
        header: Text("About"),
        footer: HStack {
          Spacer()
          Text("Copyright © \(String(currentYear)) Pixie AI • All rights reserved.")
          Spacer()
        }
      ) {
        ListRowView(rowLabel: "Application", rowIcon: "apps.iphone", rowDetail: "Pixie")
          .padding(.top, 8)
        ListRowView(rowLabel: "AI Usage", rowIcon: "apple.intelligence", rowDetail: "Apple Intelligence")
        ListRowView(rowLabel: "Compatibility", rowIcon: "info.circle", rowDetail: "iPhone • iPad • Mac")
        ListRowView(rowLabel: "Technology", rowIcon: "swift", rowDetail: "Swift • SwiftUI • AI")
        ListRowView(rowLabel: "Version", rowIcon: "gear", rowDetail: "1.0.0")
        ListRowView(rowLabel: "Developer", rowIcon: "ellipsis.curlybraces", rowDetail: "Josh Doe")
        ListRowView(rowLabel: "Designer", rowIcon: "paintbrush", rowDetail: "Robert Petras")
        
        LabeledContent {
          Button {
            isShowingSheet = true
          } label: {
            Text("Credo Academy")
              .foregroundStyle(.purple)
              .fontWeight(.heavy)
          }
          .sheet(isPresented: $isShowingSheet) {
            WebView(url: credoWebsite)
              .presentationDetents([.medium, .large])
              .ignoresSafeArea()
          }
        } label: {
          HStack {
            ZStack {
              RoundedRectangle(cornerRadius: 8)
                .frame(width: 30, height: 30)
                .foregroundStyle(.purple)
                .glassEffect(in: RoundedRectangle(cornerRadius: 8))
              Image(systemName: "globe")
                .foregroundStyle(.white)
            }
            Text("Learn More")
              .foregroundStyle(.secondary)
          }
        }
        .padding(.bottom, 8)
      }
    } //: FORM
  }
}

#Preview {
  SettingsView()
}
