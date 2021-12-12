//
//  ListRowView.swift
//  TodoList
//
//  Created by BogdanGross on 07/12/2021.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
                .strikethrough(item.isCompleted ? true : false)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListRowView(item: ItemModel(title: "Preview Item - Not Complete :(", isCompleted: false))
            ListRowView(item: ItemModel(title: "Preview Item - Complete!", isCompleted: true))
        }
        .previewLayout(.sizeThatFits)
    }
}
