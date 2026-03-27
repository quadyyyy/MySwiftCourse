//
//  TaskGroupRow.swift
//  TaskManager
//
//  Created by Куприянов Тимофей on 27.03.2026.
//

import SwiftUI

struct TaskGroupRow: View {
    @ObservedObject var taskGroup: CDTaskGroup
    
    var body: some View {
        HStack {
            Image(systemName: "folder")
            TextField("New Group", text: $taskGroup.title)
        }
    }
}

#Preview {
    TaskGroupRow(taskGroup: CDTaskGroup.example)
}
