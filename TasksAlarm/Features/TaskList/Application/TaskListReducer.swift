//
//  TaskListReducer.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 11.08.2024.
//

import Foundation

func taskListReducer(_ state: inout TaskListState, action: TaskListAction) {
	switch action {
	case .addTask(let task):
		state.tasks.append(task)
	case .toggleTaskCompletion(let id):
		if let index = state.tasks.firstIndex(where: { $0.id == id }) {
			state.tasks[index].isCompleted.toggle()
		}
	case .removeTask(let id):
		state.tasks.removeAll { $0.id == id }
	case .filterTasks(let filter):
		state.filter = filter
	}
}
