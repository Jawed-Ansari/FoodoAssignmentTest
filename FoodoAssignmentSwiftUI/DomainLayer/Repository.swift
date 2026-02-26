//
//  Repository.swift
//  FoodoAssignmentSwiftUI
//
//  Created by Muhhmmd Jawed Ansari on 26/02/26.
//

import Foundation
protocol ItemRepositoryProtocol {
    func load() async throws -> [Item]
    var updates: AsyncStream<[Item]> { get }
}

final class ItemRepository: ItemRepositoryProtocol {

    private let api: APIClientProtocol
    private let cache: CacheProtocol
    private var items: [Item] = []

    init(api: APIClientProtocol, cache: CacheProtocol) {
        self.api = api
        self.cache = cache
    }

    func load() async throws -> [Item] {
        do {
            let remote = try await api.fetchItems()
            items = merge(old: cache.load(), new: remote)
            cache.save(items)
            return items
        } catch {
            let cached = cache.load()
            if cached.isEmpty { throw error }
            items = cached
            return cached
        }
    }

    // Merge by id + updatedAt
    private func merge(old: [Item], new: [Item]) -> [Item] {
        var dict = Dictionary(uniqueKeysWithValues: old.map { ($0.id, $0) })

        for item in new {
            if let existing = dict[item.id],
               existing.updatedAt >= item.updatedAt {
                continue
            }
            dict[item.id] = item
        }
        return Array(dict.values).sorted { $0.id < $1.id }
    }

    //  Polling with deltas
    var updates: AsyncStream<[Item]> {
        AsyncStream { continuation in
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                guard !self.items.isEmpty else { return }

                var updated = self.items
                updated[0] = Item(
                    id: updated[0].id,
                    title: updated[0].title + " ✓",
                    status: .done,
                    detail: updated[0].detail,
                    updatedAt: .now
                )

                self.items = updated
                self.cache.save(updated)
                continuation.yield(updated)
            }
        }
    }
}
