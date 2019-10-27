import Vapor

struct PostgreSQLVersion: Codable {
    let version: String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    let signifoT = SignifoTraktilo()
    router.get("signifoj", Int.parameter, "vortoj", use: signifoT.vortoj)

    let vortoT = VortoTraktilo()
    router.get("vortoj", use: vortoT.listi)
    router.get("informi", String.parameter, use: vortoT.trovi)
    router.get("indekso", use: vortoT.listiKunSignifoj)
    router.get("trovi", String.parameter, use: vortoT.ŝerĉi)
}
