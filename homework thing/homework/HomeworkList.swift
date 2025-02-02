//
//  HomeworkList.swift
//  homework thing
//
//  Created by lucas on 30/01/25.
//

import SwiftUI

struct HomeworkList: View {
	@State var homeworkData : (error: String?, homeworkList : [Homework])
	var homeworkClass: String
	
	init(class homeworkClass: String) {
		self.homeworkClass = homeworkClass
		
		homeworkData = Homework.loadHomework(class: homeworkClass)
	}
	
	var body: some View {
		NavigationStack {
			ScrollView {
				if let error = homeworkData.error {
					Text(error)
				} else {
					ForEach(homeworkData.homeworkList) { homework in
						HomeworkBox(displayHomework: homework)
					}
				}
			}
			.refreshable {
				homeworkData = Homework.loadHomework(class: homeworkClass)
			}
		}
	}
}

#Preview {
	HomeworkList(class: "PG211")
}
