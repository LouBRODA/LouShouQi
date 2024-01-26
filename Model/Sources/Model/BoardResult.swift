import Foundation

/// Énumération définissant les résultats des opérations sur le plateau de jeu.
public enum BoardResult: Equatable {
    /// Résultat inconnu.
    case unknown
    /// Opération réussie.
    case ok
    /// Échec de l'opération avec une raison spécifiée.
    case failed(reason: BoardFailingReason)
    
    /// Égalité pour le protocole Equatable.
    ///
    /// - Parameters:
    ///   - left: Le premier résultat à comparer.
    ///   - right: Le deuxième résultat à comparer.
    /// - Returns: `true` si les résultats sont égaux, sinon `false`.
    public static func == (left: BoardResult, right: BoardResult) -> Bool {
        switch (left, right) {
        case (.unknown, .unknown):
            return true
        case (.ok, .ok):
            return true
        case (.failed(_), .failed(_)):
            return true
        default:
            return false
        }
    }
}
