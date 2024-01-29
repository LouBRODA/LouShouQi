import Foundation

/// Classe définissant un joueur.
public class Player {
    
    // Identifiant du joueur de type Owner.
    public let id: Owner
    
    // Nom du joueur.
    public let name: String
    
    /// Initialiseur de la cellule.
    ///
    /// - Parameters:
    ///   - name: Nom du joueur.
    ///   - id: Identifiant du joueur.
    public init?(withName name: String, andId id: Owner) {
        self.name = name
        self.id = id
    }
    
    /// Permet de rendre un coup pour un plateau particulier et des règles particulières.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - rules: Les règles choisies pour la partie en cours.
    /// - Returns: Le coup choisi.
    public func chooseMove(in board: Board, with rules: any Rules) throws -> Move? {
        nil
    }
}
