import Vapor

final class Vorto {
	let vorto: String
	let signifo: Signifo
	let ecoj: UInt8
	
	var radikoj: [Vorto] = []
	var idoj: [Vorto] = []

	init(_ vorto: String, signifo: Signifo, ecoj: UInt8) {
		self.vorto = vorto
		self.signifo = signifo
		self.ecoj = ecoj
	}
}