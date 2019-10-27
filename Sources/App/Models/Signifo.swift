import Vapor

final class Signifo {
	let signifo: String
	let tipo: Int
	let ecoj: UInt8

	init(_ signifo: String, _ tipo: Int, _ ecoj: UInt8) {
		self.signifo = signifo
		self.tipo = tipo
		self.ecoj = ecoj
	}
}