//
//  TaskListEnhancement.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 14.08.2024.
//

import Foundation

struct TaskListEnhancement: Middleware {
	func process(action: TaskListAction, state: TaskListState, next: @escaping (TaskListAction) -> Void) {
		switch action {
		case .addTask(var task):
			// Если подзаголовок не указан, добавляем стандартный подзаголовок
			if task.subtitle == nil || task.subtitle?.isEmpty == true {
				task.subtitle = "No description provided"
			}
			let enhancedAction = TaskListAction.addTask(task)
			next(enhancedAction) // Передаем измененное действие дальше
		default:
			next(action) // Для других действий просто передаем действие дальше
		}
	}
}
