class Vortaro {
	let vortoj: [Vorto]
	let signifoj: [Signifo]

	let vortoIndekso: [String : Int]

	init(vortoj: [Vorto], signifoj: [Signifo]) {
		self.vortoj = vortoj
		self.signifoj = signifoj

		var indekso = [String : Int]()
		for (i, vorto) in vortoj.enumerated() {
			indekso[vorto.vorto] = i
		}
		self.vortoIndekso = indekso
	}
}