//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import SwiftUI

struct ListRowView: View {
  let rowLabel: String
  let rowIcon: String
  let rowDetail: String
  
  init(rowLabel: String = "", rowIcon: String = "", rowDetail: String = "") {
    self.rowLabel = rowLabel
    self.rowIcon = rowIcon
    self.rowDetail = rowDetail
  }
  
  var body: some View {
    LabeledContent {
      Text(rowDetail)
    } label: {
      HStack {
        ZStack {
          RoundedRectangle(cornerRadius: 8)
            .frame(width: 30, height: 30)
            .glassEffect(in: RoundedRectangle(cornerRadius: 8))
          Image(systemName: rowIcon)
            .foregroundStyle(.white)
        }
        Text(rowLabel)
      }
      .foregroundStyle(.secondary)
    }
  }
}

#Preview {
  List {
    ListRowView(
      rowLabel: "AI Usage",
      rowIcon: "apple.intelligence",
      rowDetail: "Apple Intelligence"
    )
  }
}
