//
//  HomeworkViews.swift
//  homework thing
//
//  Created by lucas on 30/01/25.
//

import SwiftUI

struct HomeworkBox: View {
	let displayHomework: Homework
	
	let dateColor: Color
	
	init(displayHomework: Homework) {
		self.displayHomework = displayHomework
		
		if displayHomework.date.timeIntervalSinceNow < 86400 {
			dateColor = .red
		} else if displayHomework.date.timeIntervalSinceNow > 604800 {
			dateColor = .green
		} else {
			dateColor = .primary
		}
	}
	
	var body: some View {
		NavigationLink {
			HomeworkDetail(displayHomework: displayHomework)
		} label: {
			GroupBox {
				HStack {
					Label(displayHomework.title, systemImage: displayHomework.subject.icon)
						.font(.system(size: 25, weight: .bold))
						.foregroundStyle(displayHomework.subject.color)
					Spacer()
				}
				.padding(.bottom, 1)
				
				HStack {
					Label(displayHomework.category.name, systemImage: displayHomework.category.icon)
						.foregroundStyle(displayHomework.category.color)
					
					Spacer()
					
					Text(dateFormatter.string(from: displayHomework.date))
						.foregroundStyle(dateColor)
				}
				.padding(.bottom , 1)
				
				HStack {
					Text(displayHomework.simpleDescription)
						.foregroundStyle(.primary)
					
					Spacer()
				}
			}
			.padding([.leading, .trailing])
		}
		.foregroundStyle(.primary)
	}
}

struct HomeworkDetail: View {
	var displayHomework: Homework
	
	var body: some View {
		VStack {
			Label(displayHomework.title, systemImage: displayHomework.subject.icon)
				.font(.system(size: 25, weight: .bold))
				.foregroundStyle(displayHomework.subject.color)
			
			GroupBox {
				ScrollView {
					HStack {
						Text(displayHomework.complicatedDescription)
						
						Spacer()
					}
				}
			}
			.padding()
			
			Spacer()
		}
	}
}

#Preview {
	NavigationStack {
		HomeworkBox(displayHomework: Homework(subject: .art, category: .booklet, date: Date(), simpleDescription: "Lorem ipsum", complicatedDescription: "Lorem ipsum dolor sit amet"))
	}
}
