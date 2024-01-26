import Foundation
import Model

/// Extension de la classe CellType du package Model permettant l'affichage de la valeur avec un emoji.
public extension Model.CellType {
    /// Propriété calculée qui retourne l'emoji associé à chaque cas de l'enum CellType.
    var symbol: String {
        switch self {
        case .unknown:
            return " "
        case .jungle:
            return "🌿"
        case .water:
            return "💧"
        case .trap:
            return "🪤"
        case .den:
            return "🪹"
        }
    }
}
