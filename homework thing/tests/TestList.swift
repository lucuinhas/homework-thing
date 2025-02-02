//
//  TestList.swift
//  homework thing
//
//  Created by lucas on 31/01/25.
//

import SwiftUI

struct TestList: View {
	@State var testData : (error: String?, testList: [Test])
	var testClass: String
	
	init(class testClass: String) {
		self.testClass = testClass
		
		testData = Test.loadTests(class: testClass)
	}
	
	var body: some View {
		NavigationStack {
			ScrollView {
				if let error = testData.error {
					Text(error)
				} else {
					ForEach(testData.testList) { test in
						TestBox(displayTest: test)
					}
				}
			}
			.refreshable {
				testData = Test.loadTests(class: testClass)
			}
		}
	}
}

#Preview {
	TestList(class: "PG211")
}
