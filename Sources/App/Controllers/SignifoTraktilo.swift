import Vapor

final class SignifoTraktilo {
  func listi(_ req: Request) throws -> Future<[Signifo]> {
    return Signifo.query(on: req).all()
  }

  func vortoj(_ req: Request) throws -> Future<[Vorto]> {
    let id = try req.parameters.next(Int.self)
    let signifo = Signifo.find(id, on: req)
    return signifo.flatMap { signifo in
      return try signifo!.vortoj.query(on: req).all()
    }
  }
}