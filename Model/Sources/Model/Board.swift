import Foundation

///Structure définissant le plateau de jeu en lui-même
public struct Board{
    
    ///Properties
    public let nbRows: Int
    public let nbColumns: Int
    public private(set) var grid: [[Cell]]
    
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
    
    ///Méthode pour compter le nombre de pièces d'un joueur
    public func countOnePlayerPieces(of player: Owner) -> Int{
        return grid.flatMap { $0 }.filter { $0.piece?.owner == player }.count
    }
    
    ///Méthode pour compter le nombre de pièces des deux joueurs
    public func countTwoPlayersPieces() -> (player1Pieces: Int, player2Pieces: Int){
        let player1Pieces = countOnePlayerPieces(of: .player1)
        let player2Pieces = countOnePlayerPieces(of: .player2)
        return(player1Pieces, player2Pieces)
    }
    
    ///Méthode pour insérer une pièce sur une cellule donnée
    public mutating func insertPiece(piece: Piece, atRow row: Int, andColumn column: Int) -> BoardResult{
        guard row >= 0 && row < nbRows && column >= 0 && column < nbColumns else {
            return .failed(reason: .outOfBounds)
        }
        
        guard grid[row][column].piece == nil else {
            return .failed(reason: .cellNotEmpty)
        }
        
        grid[row][column].piece = piece
        return .ok
    }
    
    ///Méthode pour supprimer une pièce sur une cellule donnée
    public mutating func removePiece(atRow row: Int, andColumn column: Int) -> BoardResult{
        guard row >= 0 && row < nbRows && column >= 0 && column < nbColumns else {
            return .failed(reason: .outOfBounds)
        }
        
        guard grid[row][column].piece != nil else {
            return .failed(reason: .cellEmpty)
        }
        
        grid[row][column].piece = nil
        return .ok
    }
}
