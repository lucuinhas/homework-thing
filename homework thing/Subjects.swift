//
//  Subjects.swift
//  homework thing
//
//  Created by lucas on 30/01/25.
//

import SwiftUI

enum Subjects: String {
	case chemistry, biology, physics
	case math
	case history, geography
	case portuguese, literature, essay
	case if1, if2
	case art
	case english
	case philosophy, sociology
	case pe
	
	var name: String {
		get {
			switch self {
			case .chemistry: return "Química"
			case .biology: return "Biologia"
			case .physics: return "Física"
			case .math: return "Matemática"
			case .history: return "História"
			case .geography: return "Geografia"
			case .portuguese: return "Português"
			case .literature: return "Literatura"
			case .essay: return "Redação"
			case .if1: return "Itinerário F. 1"
			case .if2: return "Itinerário F. 2"
			case .art: return "Artes"
			case .english: return "Inglês"
			case .philosophy: return "Filosofia"
			case .sociology: return "Sociologia"
			case .pe: return "Educação Física"
			}
		}
	}
	
	var color: Color {
		get {
			switch self {
			case .chemistry: return .green
			case .biology: return .green
			case .physics: return .blue
			case .math: return .blue
			case .history: return .purple
			case .geography: return .orange
			case .portuguese: return .red
			case .literature: return .red
			case .essay: return .red
			case .if1: return .yellow
			case .if2: return .yellow
			case .art: return .red
			case .english: return .red
			case .philosophy: return .purple
			case .sociology: return .purple
			case .pe: return .yellow
			}
		}
	}
	
	var icon: String {
		get {
			switch self {
			case .chemistry: return "atom"
			case .biology: return "leaf.fill"
			case .physics: return "lightbulb.fill"
			case .math: return "squareroot"
			case .history: return "clock.fill"
			case .geography: return "globe.americas.fill"
			case .portuguese: return "character.book.closed.fill"
			case .literature: return "book.fill"
			case .essay: return "pencil.line"
			case .if1: return "arrow.trianglehead.2.clockwise.rotate.90"
			case .if2: return "arrow.trianglehead.2.clockwise.rotate.90"
			case .art: return "paintbrush.pointed.fill"
			case .english: return "flag.fill"
			case .philosophy: return "brain.fill"
			case .sociology: return "person.3.fill"
			case .pe: return "basketball.fill"
			}
		}
	}
}
