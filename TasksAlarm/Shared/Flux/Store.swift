//
//  Store.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 11.08.2024.
//

import Foundation

class Store<State, Action>: ObservableObject where State: Equatable {
	@Published private(set) var state: State
	private let reducer: (inout State, Action) -> Void
	private var observers: Set<Observer<State>> = []
	private var middleware: [AnyMiddleware<State, Action>]

	init(
		initial state: State,
		reducer: @escaping (inout State, Action) -> Void,
		middleware: [AnyMiddleware<State, Action>] = []
	) {
		self.reducer = reducer
		self.state = state
		self.middleware = middleware
	}

	func dispatch(_ action: Action) {
		// Создаем цепочку middleware
		let middlewareChain = middleware.reversed().reduce({ action in
			self.reducer(&self.state, action)
			self.notifyObservers()
		}) { next, mw in
			return { action in
				mw.process(action: action, state: self.state, next: next)
			}
		}
		middlewareChain(action)
	}

	func subscribe(observer: Observer<State>) {
		self.observers.insert(observer)
		self.notify(observer)
	}

	private func notifyObservers() {
		for observer in observers {
			notify(observer)
		}
	}

	private func notify(_ observer: Observer<State>) {
		if observer.observe(state) == .dead {
			observers.remove(observer)
		}
	}
}
