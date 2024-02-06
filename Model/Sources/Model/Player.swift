import Foundation

/// Classe définissant un joueur.
public class Player: CustomStringConvertible {
    // Description textuelle de l'objet Player.
    public var description: String {
        switch self.id {
        case .noOne:
            return "x"
        case .player1:
            return "player1"
        case .player2:
            return "player2"
        }
    }
    
    // Identifiant du joueur de type Owner.
    public let id: Owner
    
    // Nom du joueur.
    public let name: String
    
    /// Initialiseur du Player.
    ///
    /// - Parameters:
    ///   - name: Nom du joueur.
    ///   - id: Identifiant du joueur.
    public init?(withName name: String, andId id: Owner) {
        //on vérifie que l'identifiant du joueur n'est pas .noOne
        guard (id == .player1 || id == .player2) else {
            return nil
        }
        self.name = name
        self.id = id
    }
    
    /// Permet de rendre un coup pour un plateau particulier et des règles particulières.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - rules: Les règles choisies pour la partie en cours.
    /// - Returns: Le coup choisi.
    public func chooseMove(in board: Board, with rules: any Rules) -> Move? {
        //on retourne nil car rien d'intéressant pour cette classe
        nil
    }
}
