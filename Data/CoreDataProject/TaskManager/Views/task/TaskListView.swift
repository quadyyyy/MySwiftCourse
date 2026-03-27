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
    
    init(title: String, selection: TaskSection?) {
        self.title = title
        
        var request = CDTask.fetch()
        
        switch selection {
        case .all:
            request.predicate = nil
        case .done:
            request.predicate = NSPredicate(format: "isCompleted == true")
        case .upcoming:
            request.predicate = NSPredicate(format: "isCompleted == false")
        case .list(let group):
            // TODO
            request.predicate = nil
        case nil:
            request.predicate = .none
        }
        
        self._tasks = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        List(tasks) { task in
            TaskRow(task: task)
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItemGroup {
                Button {
                    _ = CDTask(title: "New Task", dueDate: Date(), context: context)
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
        .inspector(isPresented: $inspectorIsShown) {
            Group {
                if let selectedTask {
                    Text(selectedTask.title).font(.title)
                } else {
                    Text("nothing selected")
                }
            }
            .frame(minWidth: 100, maxWidth: .infinity)
        }
    }
}

#Preview {
    TaskListView(title: "All", selection: .all)
        .environment(\.managedObjectContext,
                      PersistenceController.preview.container.viewContext)
}
