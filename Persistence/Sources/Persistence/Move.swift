import Foundation
import Model

//Extension permettant la persistance pour la struct Move
extension Model.Move: Codable {
    enum CodingKeys: String, CodingKey {
        case owner
        case rowOrigin
        case columnOrigin
        case rowDestination
        case columnDestination
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let owner = try container.decode(Owner.self, forKey: .owner)
        let rowOrigin = try container.decode(Int.self, forKey: .rowOrigin)
        let columnOrigin = try container.decode(Int.self, forKey: .columnOrigin)
        let rowDestination = try container.decode(Int.self, forKey: .rowDestination)
        let columnDestination = try container.decode(Int.self, forKey: .columnDestination)
        
        self.init(owner: owner, rowOrigin: rowOrigin, columnOrigin: columnOrigin, rowDestination: rowDestination, columnDestination: columnDestination)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(owner, forKey: .owner)
        try container.encode(rowOrigin, forKey: .rowOrigin)
        try container.encode(columnOrigin, forKey: .columnOrigin)
        try container.encode(rowDestination, forKey: .rowDestination)
        try container.encode(columnDestination, forKey: .columnDestination)
    }
}
