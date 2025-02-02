//
//  Homework.swift
//  homework thing
//
//  Created by lucas on 30/01/25.
//

import SwiftUI

struct Homework: Identifiable, Hashable, Decodable {
	var subject: Subjects
	var category: Categories
	var date: Date
	var simpleDescription: String
	var complicatedDescription: String
	var title: String
	
	var id: UUID
	
	init(
		subject: Subjects,
		category: Categories,
		date: Date,
		simpleDescription: String,
		complicatedDescription: String,
		id: UUID = UUID()
	) {
		self.subject = subject
		self.category = category
		
		self.date = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: date)!
		
		self.simpleDescription = simpleDescription
		self.complicatedDescription = complicatedDescription
		self.id = id
		
		if category == .project {
			title = "Trabalho de \(subject.name)"
		} else {
			title = "Tarefa de \(subject.name)"
		}
	}
	
	init(from decoder: any Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		self.init(
			subject: Subjects(rawValue: try values.decode(String.self, forKey: .subject))!,
			category: Categories(rawValue: try values.decode(String.self, forKey: .category))!,
			date: try values.decode(Date.self, forKey: .date),
			simpleDescription: try values.decode(String.self, forKey: .simpleDescription),
			complicatedDescription: try values.decode(String.self, forKey: .complicatedDescription),
			id: try values.decode(UUID.self, forKey: .uuid)
		)
	}
	
	static func loadHomework(class location : String) -> (error: String?, homeworkList : [Homework]) {
		guard let url = URL(string: "https://lucuinhas.github.io/homework-thing/" + location + "/homework.json") else {
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
			let homeworkList = try decoder.decode([Homework].self, from: data)
			
			return (nil, homeworkList)
		} catch {
			return ("Failed to decode data", [])
		}
	}
	
	enum Categories: String {
		case booklet, written, project
		
		var name: String {
			get {
				switch self {
				case .booklet: return "Apostila"
				case .written: return "Caderno"
				case .project: return "Trabalho"
				}
			}
		}
		
		var color: Color {
			get {
				switch self {
				case .booklet: return .blue
				case .written: return .red
				case .project: return .yellow
				}
			}
		}
		
		var icon: String {
			get {
				switch self {
				case .booklet: return "book.closed.fill"
				case .written: return "book.pages.fill"
				case .project: return "map.fill"
				}
			}
		}
	}
	
	enum CodingKeys: String, CodingKey {
		case subject, category, date, simpleDescription, complicatedDescription, uuid
	}
}

let homeworkData = Homework.loadHomework(class: "PG211")

#Preview {
	if let error = homeworkData.error {
		Text(error)
	} else {
		ForEach(homeworkData.homeworkList) { homework in
			HomeworkBox(displayHomework: homework)
		}
	}
}
