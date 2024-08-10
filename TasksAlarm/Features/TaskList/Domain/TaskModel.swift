//
//  TaskModel.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 11.08.2024.
//

import Foundation

struct TaskModel: Equatable, Identifiable {
	var id = UUID()
	var title: String
	var subtitle: String?
	var isCompleted = false
}
