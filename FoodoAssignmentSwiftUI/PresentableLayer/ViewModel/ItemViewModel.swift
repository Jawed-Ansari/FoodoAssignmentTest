//
//  ItemViewModel.swift
//  FoodoAssignmentSwiftUI
//
//  Created by Muhhmmd Jawed Ansari on 26/02/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class ItemListViewModel {

    enum State {
        case loading
        case loaded([Item], offline: Bool)
        case empty
        case error(String)
    }

    private(set) var state: State = .loading
    private let repository: ItemRepositoryProtocol

    init(repository: ItemRepositoryProtocol) {
        self.repository = repository
    }

    func load() {
        state = .loading
        Task {
            do {
                let items = try await repository.load()
                state = items.isEmpty ? .empty : .loaded(items, offline: false)
                observeUpdates()
            } catch {
                state = .error("Failed to load data")
            }
        }
    }

    private func observeUpdates() {
        Task {
            for await items in repository.updates {
                state = .loaded(items, offline: false)
            }
        }
    }
}
