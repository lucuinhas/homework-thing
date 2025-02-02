//
//  App.swift
//  homework thing
//
//  Created by lucas on 30/01/25.
//

import SwiftUI

var dateFormatter = DateFormatter()

@main
struct HomeworkThing: App {
    var body: some Scene {
		WindowGroup {
			MainView()
		}
    }
	
	init() {
		dateFormatter.dateFormat = "dd/MM/yy"
	}
}

#Preview {
	MainView()
}
