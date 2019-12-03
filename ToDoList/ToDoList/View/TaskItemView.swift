//
//  TaskItemView.swift
//  ToDoList
//
//  Created by Tharmika Thiyagarajah on 11/22/19.
//  Copyright © 2019 Axel Ancona Esselmann. All rights reserved.
//

import SwiftUI

struct TaskItemView: View {
    @EnvironmentObject var userData: UserData
    
    let task: Task
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            if self.isEditing {
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
                    .onTapGesture(count: 1) {
                        self.delete()
                }
                NavigationLink(destination: TaskEditView(task: task).environmentObject(self.userData)) {
                    Text(task.title)
                }
            } else {
                Button(action: {
                    self.done()
                }) {
                    Text(self.task.title)
                }
                Spacer()
                if task.isDone {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                }
            }
        }
    }
    
    private func done() {
        guard !self.isEditing else { return }
        guard let index = self.userData.tasks.firstIndex(where: { $0.id == self.task.id }) else { return }
        self.userData.tasks[index].isDone.toggle()
    }
    
    private func delete() {
        self.userData.tasks.removeAll(where: { $0.id == self.task.id })
        if self.userData.tasks.isEmpty {
          self.isEditing = false
        }
    }
    
}

//struct TaskItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        let value = false
//        return TaskItemView(task: Task(title: "Preview", isDone: false), isEditing: $value).environmentObject(UserData())
//    }
//}
