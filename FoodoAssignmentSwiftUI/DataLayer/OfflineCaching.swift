//
//  OfflineCaching.swift
//  FoodoAssignmentSwiftUI
//
//  Created by Muhhmmd Jawed Ansari on 26/02/26.
//

import Foundation

protocol CacheProtocol {
    func save(_ items: [Item])
    func load() -> [Item]
}


final class FileCache: CacheProtocol {

    private let url: URL = {
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask)[0]
            .appendingPathComponent("items.json")
    }()

    func save(_ items: [Item]) {
        let data = try? JSONEncoder().encode(items)
        try? data?.write(to: url)
    }

    func load() -> [Item] {
        guard let data = try? Data(contentsOf: url),
              let items = try? JSONDecoder().decode([Item].self, from: data)
        else { return [] }
        return items
    }
}
