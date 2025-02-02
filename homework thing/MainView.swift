//
//  MainView.swift
//  homework thing
//
//  Created by lucas on 30/01/25.
//

import SwiftUI

func loadClasses() -> (error: String?, classes: [String : String]) {
	guard let url = URL(string: "https://lucuinhas.github.io/homework-thing/classes.json") else {
		return ("Invalid URL", [:])
	}
	
	let semaphore = DispatchSemaphore(value: 0);
	var data: Data?
	
	Task {
		data = try await URLSession.shared.data(from: url).0
		
		semaphore.signal()
	}
	
	semaphore.wait()
	
	guard let data else {
		return("Couldn't load class data", [:])
	}
	
	let decoder = JSONDecoder()
	
	do {
		let classes = try decoder.decode([String : String].self, from: data)
		
		return (nil, classes);
	} catch {
		return("Couldn't decode class data", [:])
	}
}

var classData = loadClasses()

struct MainView: View {
	@State var classes = classData.classes
	@State var currentClass: String = "PG211"
	
	var body: some View {
		if let error = classData.error {
			Text(error)
		} else {
			NavigationStack {
				TabView {
					Tab {
						HStack {
							Label("Tarefas", systemImage: "house")
								.font(.title.bold())
								.padding()
							
							Spacer()
							
							Picker("Turma", selection: $currentClass) {
								ForEach(classes.keys.sorted(), id: \.self) { key in
									Text(classes[key]!).tag(key)
								}
							}
							.padding()
						}
						
						ForEach(classes.keys.sorted(), id: \.self) { key in
							if currentClass == key {
								HomeworkList(class: currentClass)
							}
						}
					} label: {
						Label("Tarefas", systemImage: "house")
					}
					Tab {
						HStack {
							Label("Provas", systemImage: "book.pages.fill")
								.font(.title.bold())
								.padding()
							
							Spacer()
							
							Picker("Turma", selection: $currentClass) {
								ForEach(classes.keys.sorted(), id: \.self) { key in
									Text(classes[key]!).tag(key)
								}
							}
							.padding()
						}
						
						ForEach(classes.keys.sorted(), id: \.self) { key in
							if currentClass == key {
								TestList(class: currentClass)
							}
						}
					} label: {
						Label("Provas", systemImage: "book.pages.fill")
					}
				}
			}
		}
	}
}

#Preview {
	MainView()
}
