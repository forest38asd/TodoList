//
//  ItemModel.swift
//  TodoList
//
//  Created by BogdanGross on 07/12/2021.
//

import Foundation

struct ItemModel: Identifiable, Equatable, Codable {
    var id: String = UUID().uuidString
    let title: String
    var isCompleted: Bool
    
    mutating func updateCompletion() {
        isCompleted.toggle()
    }
}
