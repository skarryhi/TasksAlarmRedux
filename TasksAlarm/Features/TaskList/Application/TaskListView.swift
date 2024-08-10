//
//  TaskListView.swift
//  TasksAlarm
//
//  Created by Валиева Анна Евгеньевна on 11.08.2024.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
	@State var store: Store<TaskListState, TaskListAction>

	@State private var showSheet = false
	@State private var newTaskTitle = ""
	@State private var newTaskSubtitle = ""

	var body: some View {
		NavigationView {
			ZStack {
				TaskList(store: store)

				AddTaskButton(showSheet: $showSheet)
			}
			.navigationTitle("Tasks")
			.sheet(isPresented: $showSheet) {
				NewTaskForm(
					showSheet: $showSheet,
					newTaskTitle: $newTaskTitle,
					newTaskSubtitle: $newTaskSubtitle,
					store: store
				)
			}
		}
	}
}

struct TaskList: View {
	var store: Store<TaskListState, TaskListAction>

	var body: some View {
		List {
			ForEach(store.state.filteredTasks) { task in
				Text(task.title)
			}
			.onDelete { indexSet in
				indexSet.map { store.state.tasks[$0].id }
					.forEach { id in
						store.dispatch(.removeTask(id))
					}
			}
		}
		.onAppear {
			store.subscribe(observer: Observer { newState in
				print("Состояние изменилось: \(newState.tasks)")
				return .alive
			})
		}
	}
}

struct AddTaskButton: View {
	@Binding var showSheet: Bool

	var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer()
				Button(action: {
					showSheet = true
				}) {
					Image(systemName: "plus")
						.foregroundColor(.white)
						.font(.system(size: 24))
						.padding()
						.background(Color.black)
						.clipShape(Circle())
						.shadow(radius: 10)
				}
				.padding()
			}
		}
	}
}

struct NewTaskForm: View {
	@Binding var showSheet: Bool
	@Binding var newTaskTitle: String
	@Binding var newTaskSubtitle: String

	var store: Store<TaskListState, TaskListAction>

	var body: some View {
		VStack {
			Text("Новая задача")
				.font(.headline)
				.padding()

			TextField("Название задачи", text: $newTaskTitle)
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding()

			TextField("Подзаголовок задачи", text: $newTaskSubtitle)
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding()

			HStack {
				Button("Отмена") {
					showSheet = false
				}
				.padding()

				Spacer()

				Button("Добавить") {
					let newTask = TaskModel(title: newTaskTitle, subtitle: newTaskSubtitle)
					store.dispatch(.addTask(newTask))
					// Очистка полей
					newTaskTitle = ""
					newTaskSubtitle = ""
					showSheet = false
				}
				.padding()
			}
			.padding()
		}
		.padding()
	}
}

#Preview {
	TaskListView(
		store:
			Store(
				initial: TaskListState(
					tasks: [TaskModel(title: "Task 1"),
							TaskModel(title: "Task 2")]
				),
				reducer: taskListReducer
			)
	)
}
