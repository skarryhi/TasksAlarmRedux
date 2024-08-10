//
//  Middleware.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 13.08.2024.
//

import Foundation

protocol Middleware {
	associatedtype State
	associatedtype Action

	func process(action: Action,
				 state: State,
				 next: @escaping (Action) -> Void)
}

struct AnyMiddleware<State, Action>: Middleware {
	private let _process: (Action, State, @escaping (Action) -> Void) -> Void

	init<M: Middleware>(_ middleware: M) where M.State == State, M.Action == Action {
		self._process = middleware.process
	}

	func process(action: Action,
				 state: State,
				 next: @escaping (Action) -> Void) {
		_process(action, state, next)
	}
}
