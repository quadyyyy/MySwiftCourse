//
//  TaskListView.swift
//  TaskManager
//
//  Created by Karin Prater on 21.08.2023.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    
    let title: String
    @FetchRequest(fetchRequest: CDTask.fetch()) var tasks
    @Environment(\.managedObjectContext) var context
    @State private var selectedTask: CDTask? = nil
    
    @State private var inspectorIsShown: Bool = false
    
    let group: CDTaskGroup?
    
    init(title: String, selection: TaskSection?, searchTerm: String) {
        self.title = title
        
        var request = CDTask.fetch()
        if searchTerm.isEmpty {
            
            switch selection {
            case .all:
                request.predicate = nil
            case .done:
                request.predicate = NSPredicate(format: "isCompleted == true")
            case .upcoming:
                request.predicate = NSPredicate(format: "isCompleted == false")
            case .list(let group):
                // TODO
                request.predicate = NSPredicate(format: "group == %@",
                                                group as CVarArg)
            case nil:
                request.predicate = .none
            }
        } else {
            request.predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "title_", searchTerm as CVarArg)
        }
        
        switch selection {
        case .all, .done, .upcoming:
            group = nil
        case .list(let group):
            self.group = group
        case nil:
            group = nil
        }
        
        self._tasks = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        List(tasks) { task in
            TaskRow(task: task, selectedTask: $selectedTask, inspectorIsShown: $inspectorIsShown)
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItemGroup {
                Button {
                    let task = CDTask(title: "New Task", dueDate: Date(), context: context)
                    task.group = group
                    PersistenceController.shared.save()
                } label: {
                    Label("Add New Task", systemImage: "plus")
                }
                
                Button {
                    inspectorIsShown.toggle()
                } label: {
                    Label("Show inspector", systemImage: "sidebar.right")
                }
            }
           
        }
        .inspector(isPresented: $inspectorIsShown, content: {
            if let selectedTask {
                TaskDetailView(task: selectedTask)
            } else {
                ContentUnavailableView("Please select a task",
                                       systemImage: "circle.inset.filled")
            }
        })
    }
}

#Preview {
    TaskListView(title: "All", selection: .all, searchTerm: "")
        .environment(\.managedObjectContext,
                      PersistenceController.preview.container.viewContext)
}
