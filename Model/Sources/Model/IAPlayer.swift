import Foundation

/// Classe définissant une intelligence artificielle héritant de la classe Player.
public class IAPlayer : Player {
    
    /// Initialiseur de l'iAPlayer.
    ///
    /// - Parameters:
    ///   - name: Nom du joueur.
    ///   - id: Identifiant du joueur.
    public override init?(withName name: String, andId id: Owner) {
        //on utilise l'init de la classe mère
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
        
        //regarder si l'on peut atteindre la tanière adversaire
        
        
        //regarder si l'on peut atteindre une pièce de force inférieure ou égale
        

        //déplacer une pièce menacée par une pièce adverse adjacente de force supérieure ou égale
        
        
        //éviter de se placer à côté d'une pièce de force supérieure ou égale

        
        return nil
    }
}
