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