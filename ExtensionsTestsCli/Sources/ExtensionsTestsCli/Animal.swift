import Foundation
import Model

/// Extension de la classe Animal du package Model permettant l'affichage de la valeur avec un emoji.
public extension Model.Animal {
    /// Propriété calculée qui retourne l'emoji associé à chaque cas de l'enum Animal.
    var symbol: String {
        switch self {
        case .rat:
            return "🐭"
        case .cat:
            return "🐱"
        case .dog:
            return "🐶"
        case .wolf:
            return "🐺"
        case .leopard:
            return "🐆"
        case .tiger:
            return "🐯"
        case .lion:
            return "🦁"
        case .elephant:
            return "🐘"
        }
    }
}
