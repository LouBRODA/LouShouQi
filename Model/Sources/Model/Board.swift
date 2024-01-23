import Foundation

///Structure définissant le plateau de jeu en lui-même
public struct Board : Hashable{
    ///Properties
    public let nbRows: Int
    public let nbColumns: Int
    public private (set) var grid: [[Cell]]
    
    ///Initializer
    public init?(withGrid grid: [[Cell]]) {
        ///vérifie si le nombre de Cell de la première ligne est différente de nul mais aussi égal au nombre de Cell des autres lignes.
        guard let checkRowSize = grid.first?.count, grid.allSatisfy({ $0.count == checkRowSize }) else {
            return nil
        }
        
        self.nbRows = grid.count
        self.nbColumns = checkRowSize
        self.grid = grid
    }
    
    public static func == (left: Board, right: Board) -> Bool {
        return left.nbRows == right.nbRows &&
        left.nbColumns == right.nbColumns &&
        left.grid == right.grid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(nbRows)
        hasher.combine(nbColumns)
        hasher.combine(grid)
    }
    
    ///Méthode pour compter le nombre de pièces d'un joueur
    public func countOnePlayerPieces(of player: Owner) -> Int{
        ///on utilise flatMap pour transformer la grille bidimensionnelle en un tableau de cell
        ///avec filter on ne garde que les cell contenant une pièce appartenant au joueur souhaité
        ///enfin on compte le nombre d'éléments soit le nombre de pièces du joueur
        return grid.flatMap { $0 }.filter { $0.piece?.owner == player }.count
    }
    
    ///Méthode pour compter le nombre de pièces des deux joueurs
    public func countTwoPlayersPieces() -> (player1Pieces: Int, player2Pieces: Int){
        ///on compte le nombre de pièces des deux joueurs puis on retourne le résultat au sein d'un tuple
        let player1Pieces = countOnePlayerPieces(of: .player1)
        let player2Pieces = countOnePlayerPieces(of: .player2)
        return(player1Pieces, player2Pieces)
    }
    
    ///Méthode pour insérer une pièce sur une cellule donnée
    public mutating func insertPiece(piece: Piece, atRow row: Int, andColumn column: Int) -> BoardResult{
        ///on vérifie si la row et la column sont bien valides (supérieures à 0 et inférieures à la taille du board)
        guard row >= 0 && row < nbRows && column >= 0 && column < nbColumns else {
            return .failed(reason: .outOfBounds)
        }
        
        ///on vérifie si la cellule aux coordonnées fournies ne contient pas déjà une pièce
        guard grid[row][column].piece == nil else {
            return .failed(reason: .cellNotEmpty)
        }
        
        ///on ajoute la pièce à l'emplacement visé
        grid[row][column].piece = piece
        return .ok
    }
    
    ///Méthode pour supprimer une pièce sur une cellule donnée
    public mutating func removePiece(atRow row: Int, andColumn column: Int) -> BoardResult{
        ///on vérifie si la row et la column sont bien valides (supérieures à 0 et inférieures à la taille du board)
        guard row >= 0 && row < nbRows && column >= 0 && column < nbColumns else {
            return .failed(reason: .outOfBounds)
        }
        
        ///on vérifie si la cellule aux coordonnées fournies contient une pièce
        guard grid[row][column].piece != nil else {
            return .failed(reason: .cellEmpty)
        }
        
        ///on supprime la pièce à l'emplacement visé
        grid[row][column].piece = nil
        return .ok
    }
}
