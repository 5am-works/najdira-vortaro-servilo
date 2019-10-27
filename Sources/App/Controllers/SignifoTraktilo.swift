import Vapor

final class SignifoTraktilo {
  func vortoj(_ req: Request) throws -> Future<[String]> {
    let id = try req.parameters.next(Int.self)
    let v = try req.make(VortaroServico.self).ŝarĝi(per: req)
    return v.map { vortaro in
      let signifo = vortaro.signifoj[id]
      return vortaro.vortoj.filter { $0.signifo === signifo }.map { $0.vorto }
    }
  }
}