//
//  ItemListView.swift
//  FoodoAssignmentSwiftUI
//
//  Created by Muhhmmd Jawed Ansari on 26/02/26.
//

import SwiftUI

struct ItemListView: View {
    @State var viewModel: ItemListViewModel

       var body: some View {
           NavigationStack {
               content
                   .navigationTitle("Items")
                   .task { viewModel.load() }
                   .refreshable { viewModel.load() }
           }
       }

       @ViewBuilder
       private var content: some View {
           switch viewModel.state {
           case .loading:
               ProgressView()

           case .empty:
               ContentUnavailableView("No Items", systemImage: "tray")

           case .error(let message):
               VStack {
                   Text(message)
                   Button("Retry") { viewModel.load() }
               }

           case .loaded(let items, let offline):
               List(items) { item in
                   NavigationLink {
                       ItemDetailView(item: item)
                   } label: {
                       VStack(alignment: .leading) {
                           Text(item.title)
                           Text(item.status.rawValue)
                               .font(.caption)
                       }
                   }
               }
               .overlay(alignment: .top) {
                   if offline {
                       Text("Offline Mode")
                           .font(.caption)
                           .padding(6)
                           .background(.yellow)
                   }
               }
           }
       }
}

//#Preview {
//    ItemListView()
//}
