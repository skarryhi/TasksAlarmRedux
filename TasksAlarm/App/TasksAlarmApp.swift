//
//  TasksAlarmApp.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 11.08.2024.
//

import SwiftUI
import SwiftData

@main
struct TasksAlarmApp: App {

	var body: some Scene {
		WindowGroup {
			TaskListView(
				store: Store(
					initial: TaskListState(tasks: [
						TaskModel(title: "Task 1"),
						TaskModel(title: "Task 2")
					]),
					reducer: taskListReducer,
					middleware: [
						AnyMiddleware(TaskListValidation()),
						AnyMiddleware(TaskListEnhancement())
					]
				)
			)
		}
	}
}
