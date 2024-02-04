import Foundation

/// Énumération définissant les erreurs possibles dans le jeu.
public enum GameError: Error {
    // Erreur de mouvement invalide.
    case invalidMove
    
    // Erreur d'id de joueur incorrect.
    case badPlayerId(id: String)
}
