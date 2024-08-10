//
//  TaskListAction.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 11.08.2024.
//

import Foundation

enum TaskListAction {
	case addTask(TaskModel)
	case toggleTaskCompletion(UUID)
	case removeTask(UUID)
	case filterTasks(TaskListFilter)
}
