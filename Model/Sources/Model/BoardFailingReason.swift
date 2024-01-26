import Foundation

/// Énumération définissant les raisons d'échec possibles lors des opérations sur le plateau de jeu.
public enum BoardFailingReason {
    /// Raison inconnue.
    case unknown
    /// La position est en dehors des limites du plateau.
    case outOfBounds
    /// La cellule n'est pas vide lors d'une tentative d'insertion de pièce.
    case cellNotEmpty
    /// La cellule est vide lors d'une tentative de suppression de pièce.
    case cellEmpty
}
