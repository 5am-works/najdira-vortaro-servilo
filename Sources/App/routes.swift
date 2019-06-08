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
    router.get("signifoj", use: signifoT.listi)
    router.get("signifoj", Int.parameter, "vortoj", use: signifoT.vortoj)

    // Pravadoj
    router.get("sql") { req in
        return req.withPooledConnection(to: .psql) { conn in
            return conn.raw("select version()")
                .all(decoding: PostgreSQLVersion.self)
        }.map { rows in
            return rows[0].version
        }
    }
}
