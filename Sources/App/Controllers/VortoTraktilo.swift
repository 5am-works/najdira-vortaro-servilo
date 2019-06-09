import Vapor

final class VortoTraktilo {
  func listi(_ req: Request) throws -> Future<[Vorto]> {
    return Vorto.query(on: req).all()
  }

  func trovi(_ req: Request) throws -> Future<Vorto> {
    let id = try req.parameters.next(Int.self)
    return Vorto.find(id, on: req).unwrap(
      or: Abort(.notFound, reason: "Vorto ne trovita")
    )
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
}