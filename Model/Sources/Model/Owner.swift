import Foundation

/// Énumération répertoriant les différents joueurs d'une partie ainsi que le 'non-joueur'.
public enum Owner: CustomStringConvertible {
    // Description textuelle de l'objet Owner.
    public var description: String {
        switch self {
        case .noOne:
            return "x"
        case .player1:
            return "1"
        case .player2:
            return "2"
        }
    }
    
    /// Cas représentant l'absence de joueur.
    case noOne
    
    /// Cas représentant le joueur 1.
    case player1
    
    /// Cas représentant le joueur 2.
    case player2
}
