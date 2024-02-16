import Foundation
import Model

//Extension permettant la persistance pour la struct Game
extension Model.Game: Codable {
    enum CodingKeys: String, CodingKey {
        case rules
        case board
        case player1
        case player2
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rulesCodable = try container.decode(RulesCodable.self, forKey: .rules)
        let rules = rulesCodable.getRules()
        let board = try container.decode(Board.self, forKey: .board)
        let player1Codable = try container.decode(PlayerCodable.self, forKey: .player1)
        let player1 = player1Codable.getPlayer()
        let player2Codable = try container.decode(PlayerCodable.self, forKey: .player2)
        let player2 = player2Codable.getPlayer()
        
        self.init(withRules: rules, andPlayer1: player1, andPlayer2: player2)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let rules = RulesCodable(occurrences: rules.occurrences, historic: rules.historic, rulesType: "\(type(of: rules))")
        try container.encode(rules, forKey: .rules)
        try container.encode(board, forKey: .board)
        let player1 = PlayerCodable(id: player1.id, name: player1.name, playerType: "\(type(of: player1))")
        try container.encode(player1, forKey: .player1)
        let player2 = PlayerCodable(id: player2.id, name: player2.name, playerType: "\(type(of: player2))")
        try container.encode(player2, forKey: .player2)
    }
}
