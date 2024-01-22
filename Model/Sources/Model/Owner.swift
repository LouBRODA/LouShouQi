import Foundation

///Enumeration répertoriant les différents joueurs d'une partie ainsi que le 'non-joueur'
public enum Owner : CustomStringConvertible{
    public var description: String {
        switch self{
        case .noOne:
            return "x"
        case .player1:
            return "1"
        case .player2:
            return "2"
        }
    }
    
    case noOne
    case player1
    case player2
}
