import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    var databases = DatabasesConfig()

    guard let host = Environment.get("DB_HOST"), let pw = Environment.get("DB_PW"),
        let user = Environment.get("DB_USER"), let db = Environment.get("DB_DB"),
        let port = Environment.get("DB_PORT") else {
        throw Abort(.internalServerError, reason: "Ne eblas konekti al la datumejo")
    }
    databases.add(database: PostgreSQLDatabase(
        config: PostgreSQLDatabaseConfig(
            hostname: host,
            port: Int(port) ?? 5432,
            username: user,
            database: db,
            password: pw,
            transport: .unverifiedTLS
        )
    ), as: .psql)
    services.register(databases)

    // Modeloj
    Signifo.defaultDatabase = .psql
    Vorto.defaultDatabase = .psql
}
