//
//  TestViews.swift
//  homework thing
//
//  Created by lucas on 31/01/25.
//

import SwiftUI

struct TestBox: View {
	let displayTest: Test
	
	let dateColor: Color
	
	init(displayTest: Test) {
		self.displayTest = displayTest
		
		if displayTest.date.timeIntervalSinceNow < 86400 {
			dateColor = .red
		} else if displayTest.date.timeIntervalSinceNow > 604800 {
			dateColor = .green
		} else {
			dateColor = .primary
		}
	}
	
	var body: some View {
		NavigationLink {
			TestDetail(displayTest: displayTest)
		} label: {
			GroupBox {
				HStack {
					Label(displayTest.title, systemImage: displayTest.subject.icon)
						.font(.system(size: 25, weight: .bold))
						.foregroundStyle(displayTest.subject.color)
					
					Spacer()
				}
				.padding(.bottom, 1)
				
				HStack {
					Text(displayTest.simpleDescription)
					
					Spacer()
					
					Text(dateFormatter.string(from: displayTest.date))
						.foregroundStyle(dateColor)
				}
			}
			.padding([.leading, .trailing])
		}
		.foregroundStyle(.primary)
	}
}

struct TestDetail: View {
	let displayTest: Test
	
	var body: some View {
		Label(displayTest.title, systemImage: displayTest.subject.icon)
			.font(.system(size: 25, weight: .bold))
			.foregroundStyle(displayTest.subject.color)
		
		GroupBox {
			ScrollView {
				HStack {
					Text(displayTest.complicatedDescription)
					
					Spacer()
				}
			}
		}
		.padding()
	}
}


#Preview {
	NavigationStack {
		TestBox(displayTest: Test(subject: .chemistry, date: .now, simpleDescription: "Lorem ipsum", complicatedDescription: "Lorem ipsum dolor sit amet"))
	}
}
