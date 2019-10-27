import Vapor

final class VortoTraktilo {
  func listi(_ req: Request) throws -> Future<[String]> {
    let v = try req.make(VortaroServico.self).ŝarĝi(per: req)
    return v.map { vortaro in
      return vortaro.vortoj.map { $0.vorto }
    }
  }

  func listiKunSignifoj(_ req: Request) throws -> Future<[VortoKajSignifo]> {
    let v = try req.make(VortaroServico.self).ŝarĝi(per: req)
    return v.map { (vortaro: Vortaro) -> [VortoKajSignifo] in
      return vortaro.vortoj.map { vorto in
        return VortoKajSignifo(
          vorto: vorto.vorto,
          ecoj: vorto.signifo.ecoj,
          signifo: vorto.signifo.signifo
        )
      }
    }
  }

  func trovi(_ req: Request) throws -> Future<VortoInformo> {
    let v = try req.make(VortaroServico.self).ŝarĝi(per: req)
    let t = try req.parameters.next(String.self)
    return v.map { vortaro in
      let trovita = vortaro.vortoj.first { $0.vorto == t }
      guard let vorto = trovita else {
        throw Abort(.notFound, reason: "Vorto ne trovita")
      }
      return VortoInformo(
        vorto: vorto.vorto,
        ecoj: vorto.signifo.ecoj,
        signifo: vorto.signifo.signifo,
        egalvortoj: [],
        radikoj: vorto.radikoj.map { $0.vorto },
        idoj: vorto.idoj.map { $0.vorto }
      )
    }
  }

  func ŝerĉi(_ req: Request) throws -> Future<Rezulto> {
    let v = try req.make(VortaroServico.self).ŝarĝi(per: req)
    let t = try req.parameters.next(String.self)
    return v.map { vortaro in
      return Rezulto(
        signifoj: Array(
          vortaro.signifoj.lazy.filter { $0.signifo.contains(t) }
            .map { $0.signifo }.prefix(5)
        ),
        vortoj: Array(
          vortaro.vortoj.lazy.filter { $0.vorto.contains(t) }
            .map { $0.vorto }.prefix(5)
        )
      )
    }
  }
}