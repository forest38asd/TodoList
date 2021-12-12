//
//  TodoListApp.swift
//  TodoList
//
//  Created by BogdanGross on 07/12/2021.
//

import SwiftUI

@main
struct TodoListApp: App {
    @StateObject var listViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
