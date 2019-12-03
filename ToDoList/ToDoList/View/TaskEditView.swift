//
//  TaskEditView.swift
//  ToDoList
//
//  Created by Tharmika Thiyagarajah on 11/22/19.
//  Copyright © 2019 Axel Ancona Esselmann. All rights reserved.
//

import SwiftUI

struct TaskEditView: View {
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @EnvironmentObject var userData: UserData
    private let task: Task
    private var draftTitle: State<String>
    
    @State private var isEditing = false
    
    init(task: Task) {
        self.task = task
        self.draftTitle = .init(initialValue: task.title)
    }
    
    var body: some View {
        let inset = EdgeInsets(top: -8, leading: -10, bottom: -7, trailing: -10)
        return VStack(alignment: .leading, spacing: 0, content: {
            TextView(text: self.draftTitle.projectedValue, isEditing: $isEditing,
                     onEditing: {
                        self.updateTask()
            })
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.clear)
                    .border(Color(red: 0.7, green: 0.7, blue: 0.7), width: 1 / UIScreen.main.scale)
                .cornerRadius(5)
                .padding(inset)
            )
            .padding(
                EdgeInsets(
                    top: 15 - inset.top,
                    leading: 20 - inset.leading,
                    bottom: 15 - inset.bottom,
                    trailing: 20 - inset.trailing
                )
            )
            Spacer(minLength: kGuardian.offset)
            .navigationBarTitle(Text("Edit Task"))
        })
    }
    
    private func updateTask() {
        guard let index = self.userData.tasks.firstIndex(where: { $0.id == task.id }) else { return }
        self.userData.tasks[index].title = self.draftTitle.wrappedValue
    }
    
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(task: Task(title: "Preview", isDone: false)).environmentObject(UserData())
    }
}
