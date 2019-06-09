import FluentPostgreSQL
import Vapor

final class Vorto: PostgreSQLModel {
    static let name = "vorto"
    static let entity = "vortoj"

    var id: Int?
    var vorto: String
    var ecoj: UInt8
    var signifoID: Int

    var signifo: Parent<Vorto, Signifo> {
        return parent(\.signifoID)
    }

    var radikoj: Siblings<Vorto, Vorto, Radiko> {
        return siblings(Radiko.rightIDKey, Radiko.leftIDKey)
    }

    var idoj: Siblings<Vorto, Vorto, Radiko> {
        return siblings(Radiko.leftIDKey, Radiko.rightIDKey)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case vorto
        case ecoj
        case signifoID = "signifo_id"
    }
}

extension Vorto: Content {
    
}