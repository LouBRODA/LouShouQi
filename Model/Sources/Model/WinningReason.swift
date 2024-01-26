import Foundation

/// Énumération décrivant les raisons possibles pour lesquelles un joueur peut gagner la partie.
public enum WinningReason {
    /// Le joueur a atteint la tanière de l'adversaire.
    case denReached
    
    /// Le joueur a mangé toutes les pièces de l'adversaire.
    case noMorePieces
    
    /// L'adversaire ne peut pas faire de mouvement.
    case noMovesLeft
    
    /// Trop d'occurrences du même état de plateau.
    case tooManyOccurrences
}
