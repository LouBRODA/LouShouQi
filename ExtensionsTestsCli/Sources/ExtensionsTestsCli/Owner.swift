import Foundation
import Model

/// Extension de la classe Owner du package Model permettant l'affichage de la valeur avec un emoji.
public extension Model.Owner {
    /// Propriété calculée qui retourne l'emoji associé à chaque cas de l'enum Owner.
    var symbol: String {
        switch self {
        case .noOne:
            return " "
        case .player1:
            return "🟡"
        case .player2:
            return "🔴"
        }
    }
}
