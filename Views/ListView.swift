//
//  ListView.swift
//  TodoList
//
//  Created by BogdanGross on 07/12/2021.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var isCompletedHidden: Bool = false
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(.opacity.animation(.easeInOut))
            } else {
                VStack {
                    ItemsList
                    ShowOrHideCompletedButton
                    Spacer()
                }
            }
        }
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
        )
    }
    
    var ItemsList: some View {
        List {
            ForEach(listViewModel.items) { item in
                if !isCompletedHidden || !item.isCompleted {
                    ListRowView(item: item)
                        .opacity(item.isCompleted ? 0.5 : 1)
                        .onTapGesture {
                            withAnimation {
                                listViewModel.updateCompletion(item)
                            }
                        }
                        .transition(.opacity.animation(.easeInOut(duration: 3.0)))
                }
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
        }
    }
    
    var ShowOrHideCompletedButton: some View {
        Button("\(isCompletedHidden ? "Show" : "Hide") completed items") {
            withAnimation(.easeInOut) {
                isCompletedHidden.toggle()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
