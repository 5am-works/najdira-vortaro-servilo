import Vapor

final class Vorto {
	let vorto: String
	let signifo: Signifo
	
	var radikoj: [Vorto] = []
	var idoj: [Vorto] = []

	init(_ vorto: String, signifo: Signifo) {
		self.vorto = vorto
		self.signifo = signifo
	}
}