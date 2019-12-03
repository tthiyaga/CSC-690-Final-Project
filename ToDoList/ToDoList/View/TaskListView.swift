//
//  TaskListView.swift
//  ToDoList
//
//  Created by Tharmika Thiyagarajah on 11/22/19.
//  Copyright © 2019 Axel Ancona Esselmann. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var userData: UserData
    @State private var draftTitle: String = ""
    @State private var isEditing: Bool = false
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        List {
            TextField("Create a New Task...", text: $draftTitle, onCommit: self.createTask)
            ForEach(self.userData.tasks) {
                TaskItemView(task: $0, isEditing: self.$isEditing)
            }
        }
        .navigationBarTitle(Text("Tasks"))
        .navigationBarItems(trailing: Button(action: {
            self.isEditing.toggle()
        }, label: {
            if self.isEditing {
                Text("Done")
                    .bold()
            } else {
                Text("Edit")
            }
        }))
    }
    
    private func createTask() {
        let newTask = Task(title: self.draftTitle, isDone: false)
        self.userData.tasks.insert(newTask, at: 0)
        self.draftTitle = ""
    }
    
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environmentObject(UserData())
    }
}
