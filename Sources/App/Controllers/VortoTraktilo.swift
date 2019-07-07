import Vapor
import FluentPostgreSQL

final class VortoTraktilo {
  func listi(_ req: Request) throws -> Future<[Vorto]> {
    return Vorto.query(on: req).all()
  }

  func listiKunSignifoj(_ req: Request) throws -> Future<[VortoKajSignifo]> {
    return Vorto.query(on: req)
      .join(\Signifo.id, to: \Vorto.signifoID)
      .alsoDecode(Signifo.self).all()
      .map { rezultoj in
        return rezultoj.map { vs in
          return VortoKajSignifo(
            vorto: vs.0.vorto,
            ecoj: vs.0.ecoj,
            signifo: vs.1.signifo
          )
        }
      }
  }

  func trovi(_ req: Request) throws -> Future<Vorto> {
    let id = try req.parameters.next(Int.self)
    return Vorto.find(id, on: req).unwrap(
      or: Abort(.notFound, reason: "Vorto ne trovita")
    )
  }

  func informo(_ req: Request) throws -> Future<VortoInformo> {
    let v = try req.parameters.next(String.self)
    let vorto = Vorto.query(on: req).filter(\.vorto == v).first().unwrap(
      or: Abort(.notFound, reason: "Vorto ne trovita")
    )
    return vorto.flatMap { vorto in
      let signifo = vorto.signifo.get(on: req)
      let radikoj = try vorto.radikoj.query(on: req).all()
      let idoj = try vorto.idoj.query(on: req).all()
      return signifo.flatMap { signifo in
        let egalvortoj = try signifo.vortoj.query(on: req).all()
        return radikoj.and(idoj).and(egalvortoj).map { ri, egalvortoj in
          return VortoInformo(
            vorto: vorto.vorto,
            ecoj: vorto.ecoj,
            signifo: signifo.signifo,
            egalvortoj: egalvortoj.map { $0.vorto },
            radikoj: ri.0.map { $0.vorto },
            idoj: ri.1.map { $0.vorto }
          )
        }
      }
    }
  }

  func radikoj(_ req: Request) throws -> Future<[Vorto]> {
    let id = try req.parameters.next(Int.self)
    let vorto = Vorto.find(id, on: req).unwrap(
      or: Abort(.notFound, reason: "Vorto ne trovita")
    )
    return vorto.flatMap { vorto in
      return try vorto.radikoj.query(on: req).all()
    }
  }

  func idoj(_ req: Request) throws -> Future<[Vorto]> {
    let id = try req.parameters.next(Int.self)
    let vorto = Vorto.find(id, on: req).unwrap(
      or: Abort(.notFound, reason: "Vorto ne trovita")
    )
    return vorto.flatMap { vorto in
      return try vorto.idoj.query(on: req).all()
    }
  }

  func ŝerĉi(_ req: Request) throws -> Future<Rezulto> {
    let ŝerĉo = try req.parameters.next(String.self)
    let vortoj = Vorto.query(on: req).range(..<5).filter(
      \.vorto,
      .like,
      "%\(ŝerĉo)%"
    ).all()
    let signifoj = Signifo.query(on: req).range(..<5).filter(
      \.signifo,
      .like,
      "%\(ŝerĉo)%"
    ).all()
    return vortoj.and(signifoj).map { vortoj, signifoj in
      return Rezulto(
        signifoj: signifoj,
        vortoj: vortoj
      )
    }
  }
}