//
//  TaskListState.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 11.08.2024.
//

import Foundation

enum TaskListFilter {
	case all
	case active
	case completed
}

struct TaskListState: Equatable {
	var tasks: [TaskModel] = []
	var filter: TaskListFilter = TaskListFilter.active

	var filteredTasks: [TaskModel] {
		switch filter {
		case .all:
			return tasks
		case .active:
			return tasks.filter { !$0.isCompleted }
		case .completed:
			return tasks.filter { $0.isCompleted }
		}
	}
}
