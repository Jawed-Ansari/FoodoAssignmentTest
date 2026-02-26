//
//  ItemDetailView.swift
//  FoodoAssignmentSwiftUI
//
//  Created by Muhhmmd Jawed Ansari on 26/02/26.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item

    var body: some View {
        VStack(spacing: 12) {
            Text(item.title).font(.title)
            Text(item.detail)
            Text(item.status.rawValue)
            Text(item.updatedAt.formatted())
                .font(.caption)
        }
        .padding()
    }
}

//#Preview {
//    ItemDetailView()
//}
