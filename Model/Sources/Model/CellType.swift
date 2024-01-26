import Foundation

/// Énumération répertoriant les différents types de case du plateau.
public enum CellType {
    /// Type de case inconnu.
    case unknown
    /// Type de case représentant une jungle.
    case jungle
    /// Type de case représentant de l'eau.
    case water
    /// Type de case représentant un piège.
    case trap
    /// Type de case représentant une tanière.
    case den
}
