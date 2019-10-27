import Vapor

class VortaroServico: Service {
	static let fonto =
		"https://raw.githubusercontent.com/Najdira/Najdira-redaktilo/master/vortaro"
	var vortaro: Vortaro? = nil

	func ŝarĝi(per container: Container, reŝarĝi: Bool = false) throws -> Future<Vortaro> {
		let logger = try container.make(Logger.self)
		if vortaro == nil || reŝarĝi {
			let petilo = try container.client()
			let peto = petilo.get(VortaroServico.fonto)
			return peto.map { respondo in
				logger.info("Respondo ricevis: \(respondo.http.status)")
				let korpo = respondo.http.body
				let partoj = String(bytes: korpo.data!,
					encoding: String.Encoding.utf8)!.components(separatedBy: "\n\n")
				logger.info("Longeco de la partoj: \(partoj.count)")
				let signifoj = partoj[0].components(separatedBy: "\n").map {
					Signifo($0)
				}
				let vortĉenoj = partoj[1].components(separatedBy: "\n").filter {
					$0.length > 0
				}

				let vortoj = vortĉenoj.map { (ĉ: String) -> Vorto in
					let p = ĉ.components(separatedBy: " ")
					return Vorto(
						p[0],
						signifo: signifoj[Int(p[2])!],
						ecoj: UInt8(p[1])!
					)
				}
				for (i, ĉeno) in vortĉenoj.enumerated() {
					let vorto = vortoj[i]
					let p = ĉeno.components(separatedBy: " ").filter { $0.length > 0 }
					if (p.count > 3) {
						for r in p[3...] {
							let radiko = vortoj[Int(r)!]
							radiko.idoj.append(vorto)
							vorto.radikoj.append(radiko)
						}
					}
				}
				logger.info("Finita")
				self.vortaro = Vortaro(vortoj: vortoj, signifoj: signifoj)
				return self.vortaro!
			}
		} else {
			let promiso = container.eventLoop.newPromise(Vortaro.self)
			promiso.succeed(result: vortaro!)
			return promiso.futureResult
		}
	}
}