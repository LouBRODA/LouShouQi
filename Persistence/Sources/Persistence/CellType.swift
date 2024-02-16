import Foundation
import Model

//Extension permettant la persistance pour la struct CellType
extension Model.CellType: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .unknown:
            try container.encode("unknown")
        case .jungle:
            try container.encode("jungle")
        case .water:
            try container.encode("water")
        case .trap:
            try container.encode("trap")
        case .den:
            try container.encode("den")
        }
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        switch value {
        case "unknown":
            self = .unknown
        case "jungle":
            self = .jungle
        case "water":
            self = .water
        case "trap":
            self = .trap
        case "den":
            self = .den
        default:
            throw DecodingError.dataCorruptedError(in: try decoder.singleValueContainer(), debugDescription: "Invalid cell type")
        }
    }
}
