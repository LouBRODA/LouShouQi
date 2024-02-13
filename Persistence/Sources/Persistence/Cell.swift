import Foundation
import Model

//Extension permettant la persistance pour la struct Cell
extension Model.Cell: Codable {
    enum CodingKeys: String, CodingKey {
        case cellType
        case initialOwner
        case piece
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let cellType = try container.decode(CellType.self, forKey: .cellType)
        let initialOwner = try container.decode(Owner.self, forKey: .initialOwner)
        let piece = try container.decodeIfPresent(Piece.self, forKey: .piece)
        
        self.init(cellType: cellType, initialOwner: initialOwner, piece: piece)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cellType, forKey: .cellType)
        try container.encode(initialOwner, forKey: .initialOwner)
        try container.encodeIfPresent(piece, forKey: .piece)
    }
}
