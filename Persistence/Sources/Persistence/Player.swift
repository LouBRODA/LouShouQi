import Foundation
import Model

//Extension permettant la persistance pour la struct Player
extension Model.Player {
    public func decodePlayer(playerCodable: PlayerCodable) -> Player{
        return playerCodable.getPlayer();
    }
    
    public func encodePlayer() throws {
        let encoder = JSONEncoder()
        let mirror = Mirror(reflecting: self)
        let playerCodable = PlayerCodable(id: self.id, name: self.name, playerType: "\(mirror.subjectType)")
        try encoder.encode(playerCodable)
    }
}

public struct PlayerCodable: Codable{
    
    let id: Owner
    let name: String
    
    let playerType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case playerType
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(playerType, forKey: .playerType)
    }

    public init(id: Owner, name: String, playerType: String){
        self.id = id
        self.name = name
        self.playerType = playerType
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Owner.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let playerType = try container.decode(String.self, forKey: .playerType)
        let player = PlayerCodable(id: id, name: name, playerType: playerType)
        self = player
    }
    
    public func getPlayer() -> Player {
        switch playerType {
        case "HumanPlayer":
            return HumanPlayer(withName: name, andId: id, andInputMethod: { _ in return Move(owner: .player1, rowOrigin: 0, columnOrigin: 0, rowDestination: 1, columnDestination: 0) })!;
        case "RandomPlayer":
            return RandomPlayer(withName: name, andId: id)!;
        case "IAPlayer":
            return IAPlayer(withName: name, andId: id)!;
        default:
            fatalError("Type de joueur inconnu !");
        }
    }
}
