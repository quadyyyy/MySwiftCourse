//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by Куприянов Тимофей on 28.03.2026.
//

import SwiftUI

struct TaskDetailView: View {
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var task: CDTask
    
    var body: some View {
        List {
            Text(task.title)
            
            Toggle(task.isCompleted ? "Completed" : "Open", isOn: $task.isCompleted)
            
            DatePicker("Due Date", selection: $task.dueDate)
            
            Section("Sub Tasks") {
                ForEach(task.subTasks.sorted()) { subTask in
                    TaskRow(task: subTask,
                            selectedTask: .constant(nil),
                            inspectorIsShown: .constant(false),
                            showMoreButton: false
                    )
                    .listRowInsets(.init(top: 10, leading: 20, bottom: 5, trailing: 10))
                }
                Button {
                    let subTask = CDTask(title: "", dueDate: Date(), context: context)
                    subTask.parentTask = task
                } label: {
                    Label("New Sub Task", systemImage: "plus.circle")
                }
                .buttonStyle(.borderless)
                .foregroundStyle(.highlight)
                .listRowInsets(.init(top: 15, leading: 20, bottom: 5, trailing: 10))

            }
        }
        .listStyle(.sidebar)
    }
}

#Preview {
    TaskDetailView(task: CDTask.example)
}
