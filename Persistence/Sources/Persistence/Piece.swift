import Foundation
import Model

//Extension permettant la persistance pour la struct Piece
extension Model.Piece: Codable {
    enum CodingKeys: String, CodingKey {
        case owner
        case animal
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let owner = try container.decode(Owner.self, forKey: .owner)
        let animal = try container.decode(Animal.self, forKey: .animal)
        self.init(owner: owner, animal: animal)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(owner, forKey: .owner)
        try container.encode(animal, forKey: .animal)
    }
}
