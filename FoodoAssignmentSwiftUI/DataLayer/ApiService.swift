//
//  ApiService.swift
//  FoodoAssignmentSwiftUI
//
//  Created by Muhhmmd Jawed Ansari on 26/02/26.
//

import Foundation
protocol APIClientProtocol {
    func fetchItems() async throws -> [Item]
}

final class MockAPIClient: APIClientProtocol {

    func fetchItems() async throws -> [Item] {
        try await Task.sleep(nanoseconds: 500_000_000)

        return [
            Item(id: "A1", title: "First", status: .new,
                 detail: "Detail A1", updatedAt: .now),
            Item(id: "A2", title: "Second", status: .in_progress,
                 detail: "Detail A2", updatedAt: .now)
        ]
    }
}
