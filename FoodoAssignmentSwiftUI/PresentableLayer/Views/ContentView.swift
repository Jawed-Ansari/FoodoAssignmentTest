//
//  ContentView.swift
//  FoodoAssignmentSwiftUI
//
//  Created by Muhhmmd Jawed Ansari on 26/02/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ItemListView(
               viewModel: ItemListViewModel(
                   repository: ItemRepository(
                       api: MockAPIClient(),
                       cache: FileCache()
                   )
               )
           )
    }
}

#Preview {
    ContentView()
}
