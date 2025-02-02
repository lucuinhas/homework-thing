//
//  Test.swift
//  homework thing
//
//  Created by lucas on 31/01/25.
//

import SwiftUI

struct Test: Identifiable, Hashable, Decodable {
	var subject : Subjects
	var date : Date
	var title : String
	var simpleDescription : String
	var complicatedDescription : String
	
	var id : UUID
	
	init(
		subject: Subjects,
		date: Date,
		simpleDescription: String,
		complicatedDescription: String,
		id: UUID = UUID()
	) {
		self.subject = subject
		
		self.date = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: date)!
		
		self.simpleDescription = simpleDescription
		self.complicatedDescription = complicatedDescription
		self.id = id
		
		title = "Prova de \(subject.name)"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		self.init(
			subject: Subjects(rawValue: try values.decode(String.self, forKey: .subject))!,
			date: try values.decode(Date.self, forKey: .date),
			simpleDescription: try values.decode(String.self, forKey: .simpleDescription),
			complicatedDescription: try values.decode(String.self, forKey: .complicatedDescription),
			id: try values.decode(UUID.self, forKey: .uuid)
		)
	}
	
	static func loadTests(class location: String) -> (error: String?, testList: [Test]) {
		guard let url = URL(string: "https://lucuinhas.github.io/homework-thing/" + location + "/tests.json") else {
			return ("Invalid Location", [])
		}
		
		let semaphore = DispatchSemaphore(value: 0)
		var data: Data?
		
		Task {
			data = try await URLSession.shared.data(from: url).0
			
			semaphore.signal()
		}
					
		semaphore.wait()
		
		guard let data else {
			return ("Failed to download data", [])
		}
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(dateFormatter)
		
		do {
			let testList = try decoder.decode([Test].self, from: data)
			
			return (nil, testList)
		} catch {
			return ("Failed to decode data", [])
		}
	}
	
	enum CodingKeys : String, CodingKey {
		case subject
		case date
		case simpleDescription
		case complicatedDescription
		case uuid
	}
}

let testData = Test.loadTests(class: "PG211")

#Preview {
	if let error = testData.error {
		Text(error)
	} else {
		ForEach(testData.testList) { test in
			TestBox(displayTest: test)
		}
	}
}
