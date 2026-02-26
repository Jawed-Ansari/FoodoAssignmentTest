//
//  ItemDataModel.swift
//  FoodoAssignmentSwiftUI
//
//  Created by Muhhmmd Jawed Ansari on 26/02/26.
//

import Foundation
enum ItemStatus: String, Codable {
    case new, in_progress, done, cancelled
}

struct Item: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let status: ItemStatus
    let detail: String
    let updatedAt: Date
}
