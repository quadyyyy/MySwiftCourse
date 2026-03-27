//
//  TaskRow.swift
//  TaskManager
//
//  Created by Куприянов Тимофей on 27.03.2026.
//

import SwiftUI

struct TaskRow: View {
    
    @ObservedObject var task: CDTask
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "largecircle.fill.circle" : "circle")
                .onTapGesture {
                    task.isCompleted.toggle()
                }
            
            TextField("New Task", text: $task.title)
                .textFieldStyle(.plain)
            
            Button(action: {
                
            }, label: {
                Text("More")
            })
        }
    }
}

#Preview {
    TaskRow(task: CDTask.example)
        .padding()
}
