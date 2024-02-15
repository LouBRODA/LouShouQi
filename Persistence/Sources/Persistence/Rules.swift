import Foundation
import Model

//Extension permettant la persistance pour la struct Rules
extension Model.Rules {
    public func decodeRules(rulesCodable: RulesCodable) -> any Rules{
        return rulesCodable.getRules();
    }
    
    public func encodeRules() throws {
        let encoder = JSONEncoder()
        let mirror = Mirror(reflecting: self)
        let rulesCodable = RulesCodable(occurrences: self.occurrences, historic: self.historic, rulesType: "\(mirror.subjectType)")
        try encoder.encode(rulesCodable)
    }
}

public struct RulesCodable: Codable{
    
    let occurrences: [Board: Int]
    let historic: [Move]
    
    let rulesType: String
    
    enum CodingKeys: String, CodingKey {
        case occurrences
        case historic
        case rulesType
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(occurrences, forKey: .occurrences)
        try container.encode(historic, forKey: .historic)
        try container.encode(rulesType, forKey: .rulesType)
    }

    public init(occurrences: [Board: Int], historic: [Move], rulesType: String){
        self.occurrences = occurrences
        self.historic = historic
        self.rulesType = rulesType
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let occurences = try container.decode([Board: Int].self, forKey: .occurrences)
        let historic = try container.decode([Move].self, forKey: .historic)
        let rulesType = try container.decode(String.self, forKey: .rulesType)
        let rules = RulesCodable(occurrences: occurences, historic: historic, rulesType: rulesType)
        self = rules
    }
    
    public func getRules() -> any Rules {
        switch rulesType {
        case "VerySimpleRules":
            return VerySimpleRules();
        case "ClassicRules":
            return ClassicRules();
        default:
            fatalError("Type de règles inconnu !");
        }
    }
}
