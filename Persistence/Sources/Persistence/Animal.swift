import Foundation
import Model

//Extension permettant la persistance pour la struct Animal
extension Model.Animal: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(Int.self)
        guard let animal = Animal(rawValue: value) else {
            throw DecodingError.dataCorruptedError(in: try decoder.singleValueContainer(), debugDescription: "Invalid animal value")
        }
        self = animal
    }
}
