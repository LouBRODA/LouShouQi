import Foundation

/// Énumération définissant les résultats possibles d'une partie.
public enum Result: Hashable {
    /// La partie n'est pas encore terminée.
    case notFinished
    
    /// La partie est un match nul.
    case even
    
    /// Un joueur a remporté la partie avec la raison de la victoire spécifiée.
    case winner(owner: Owner, WinningReason)
}
