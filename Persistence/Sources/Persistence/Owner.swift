import Foundation
import Model

//Extension permettant la persistance pour la struct Owner
extension Model.Owner: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .noOne:
            try container.encode("noOne")
        case .player1:
            try container.encode("player1")
        case .player2:
            try container.encode("player2")
        }
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        switch value {
        case "noOne":
            self = .noOne
        case "player1":
            self = .player1
        case "player2":
            self = .player2
        default:
            throw DecodingError.dataCorruptedError(in: try decoder.singleValueContainer(), debugDescription: "Invalid owner value")
        }
    }
}
