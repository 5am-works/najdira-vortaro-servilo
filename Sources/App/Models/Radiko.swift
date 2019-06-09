import FluentPostgreSQL

struct Radiko: PostgreSQLPivot {
  static let name = "radiko"
  static let entity = "radikoj"

  typealias Left = Vorto
  typealias Right = Vorto

  static var leftIDKey: LeftIDKey = \.radikoID
  static var rightIDKey: RightIDKey = \.vortoID

  var id: Int?
  var radikoID: Int
  var vortoID: Int

  enum CodingKeys: String, CodingKey {
    case id
    case radikoID = "radiko_id"
    case vortoID = "vorto_id"
  }
}