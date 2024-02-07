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
        for move in availableMoves {
            // Vérifier si la destination du mouvement est une tanière
            if case board.grid[move.rowDestination][move.columnDestination].cellType = .den {
                return move
            }
        }
        
        //regarder si l'on peut atteindre une pièce de force inférieure ou égale
        for move in availableMoves {
            if let opponentPiece = board.grid[move.rowDestination][move.columnDestination].piece, let piece = board.grid[move.rowOrigin][move.columnOrigin].piece {
                if !(piece.animal.rawValue == 8 && opponentPiece.animal.rawValue == 1) && piece.animal.rawValue >= opponentPiece.animal.rawValue {
                    return move
                }
            }
        }

        //déplacer une pièce menacée par une pièce adverse adjacente de force supérieure ou égale
        for move in availableMoves {
            // Coordonnées des cellules adjacentes
            let adjacentCells = [(move.rowDestination - 1, move.columnDestination),
                                 (move.rowDestination + 1, move.columnDestination),
                                 (move.rowDestination, move.columnDestination - 1),
                                 (move.rowDestination, move.columnDestination + 1)]
            
            // Vérifier chaque cellule adjacente
            for (row, column) in adjacentCells {
                // Vérifier si la cellule est dans les limites du plateau
                guard row >= 0 && row < board.nbRows && column >= 0 && column < board.nbColumns else {
                    continue
                }
                
                let adjacentCell = board.grid[row][column]
                
                // Vérifier si la cellule adjacente contient une pièce adverse
                if let opponentPiece = adjacentCell.piece, let piece = board.grid[move.rowOrigin][move.columnOrigin].piece, opponentPiece.owner != self.id {
                    if !(piece.animal.rawValue == 8 && opponentPiece.animal.rawValue == 1) && piece.animal.rawValue >= opponentPiece.animal.rawValue {
                        return move
                    }
                }
            }
        }
        
        //éviter de se placer à côté d'une pièce de force supérieure ou égale

        return availableMoves.randomElement()
    }
}
