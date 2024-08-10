//
//  TaskListValidation.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 14.08.2024.
//

import Foundation

struct TaskListValidation: Middleware {
	func process(action: TaskListAction, state: TaskListState, next: @escaping (TaskListAction) -> Void) {
		switch action {
		case .addTask(let task):
			guard !task.title.trimmingCharacters(in: .whitespaces).isEmpty else {
				print("TaskListValidation - Попытка добавить задачу с пустым названием отклонена")
				return // Отклоняем действие
			}
			next(action) // Если валидация пройдена, передаем действие дальше
		default:
			next(action) // Для других действий просто передаем действие дальше
		}
	}
}
