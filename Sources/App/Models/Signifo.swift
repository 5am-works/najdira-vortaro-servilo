import FluentPostgreSQL
import Vapor

final class Signifo: PostgreSQLModel {
    static let name = "signifo"
    static let entity = "signifoj"

    var id: Int?
    var signifo: String

    var vortoj: Children<Signifo, Vorto> {
        return children(\.signifoID)
    }
}

extension Signifo: Content {
  
}