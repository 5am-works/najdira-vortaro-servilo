import Vapor

struct Rezulto: Content {
  let signifoj: [Signifo]
  let vortoj: [Vorto]
}

struct VortoKajSignifo: Content {
  let vorto: String
  let ecoj: UInt8
  let signifo: String
}

struct VortoInformo: Content {
  let vorto: String
  let ecoj: UInt8
  let signifo: String
  let egalvortoj: [String]
  let radikoj: [String]
  let idoj: [String]
}