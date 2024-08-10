//
//  Observer.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 11.08.2024.
//

import Foundation

enum ObserverStatus {
	case alive
	case dead
}

final class Observer<State> {
	private let observeBlock: (State) -> ObserverStatus

	init(observe: @escaping (State) -> ObserverStatus) {
		self.observeBlock = observe
	}

	func observe(_ state: State) -> ObserverStatus {
		return observeBlock(state)
	}
}

// Позволяет использовать Observer в Set, что необходимо
// для хранения наблюдателей в Store
extension Observer: Hashable {
	static func == (lhs: Observer<State>, rhs: Observer<State>) -> Bool {
		return lhs === rhs
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(ObjectIdentifier(self))
	}
}
