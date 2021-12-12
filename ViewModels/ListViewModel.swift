//
//  ListViewModel.swift
//  TodoList
//
//  Created by BogdanGross on 07/12/2021.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            withAnimation {
                sortItemsIfNecessery()
            }
            saveItems()
        }
    }
    
    var isItemsSorting: Bool = true
    
    let itemsKey = "item_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        if let data = UserDefaults.standard.data(forKey: itemsKey), let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) {
            items = savedItems
        } else {
            loadDefaultItems()
        }
    }
    
    func loadDefaultItems() {
        let defaultItems = [
            ItemModel(title: "This is the first title!", isCompleted: false),
            ItemModel(title: "This is the second!", isCompleted: true),
            ItemModel(title: "Third!", isCompleted: false)
        ]
        items.append(contentsOf: defaultItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }

    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        items.append(ItemModel(title: title, isCompleted: false))
        sortItemsIfNecessery()
    }
    
    func updateCompletion(_ item: ItemModel) {
        // delay after sorting if now item is complete
        if !item.isCompleted {
            isItemsSorting = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isItemsSorting = true
                withAnimation {
                    self.sortItemsIfNecessery()
                }
            }
        }
        
        //        items.indices.filter({ items[$0].id == item.id }).forEach({ items[$0].updateCompletion() })
        if let indexOfCheckedItem = items.firstIndex(of: item) { items[indexOfCheckedItem].updateCompletion() }
    }
    
    func sortItemsIfNecessery() {
        guard isItemsSorting else { return }
        let sortedListOfItems = items.sorted(by: { !$0.isCompleted && $1.isCompleted })
        if items != sortedListOfItems {
            items = sortedListOfItems
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
