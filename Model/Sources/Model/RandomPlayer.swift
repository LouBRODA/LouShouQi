import Foundation

public class RandomPlayer : Player {
    
    /// Initialiseur de la cellule.
    ///
    /// - Parameters:
    ///   - name: Nom du joueur.
    ///   - id: Identifiant du joueur.
    public override init?(withName name: String, andId id: Owner) {
        super.init(withName: name, andId: id)
    }
    
    /// Permet de rendre un coup pour un plateau particulier et des règles particulières.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - rules: Les règles choisies pour la partie en cours.
    /// - Returns: Le coup choisi.
    public override func chooseMove(in board: Board, with rules: any Rules) -> Move? {
        //obtenir la liste des différents coups possibles pour un board, des règles et un joueur donné
        let availableMoves: [Move] = rules.getMoves(for: board, of: id)
        
        //vérifier qu'il y a des coups possibles
        guard !availableMoves.isEmpty else {
            return nil
        }
        
        //choisir un coup aléatoire parmi les coups possibles
        return availableMoves.randomElement()
    }
}
