import Foundation

/// Structure définissant le plateau de jeu en lui-même.
public struct Board: Hashable {
    /// Propriétés du plateau.
    public let nbRows: Int
    public let nbColumns: Int
    public private(set) var grid: [[Cell]]
    
    /// Initialiseur.
    ///
    /// - Parameter grid: La grille de cellules du plateau.
    public init?(withGrid grid: [[Cell]]) {
        // Vérifie si le nombre de cellules de la première ligne est différent de nul mais aussi égal au nombre de cellules des autres lignes.
        guard let checkRowSize = grid.first?.count, grid.allSatisfy({ $0.count == checkRowSize }) else {
            return nil
        }
        
        self.nbRows = grid.count
        self.nbColumns = checkRowSize
        self.grid = grid
    }
    
    // Méthode d'égalité pour le protocole Hashable.
    public static func == (left: Board, right: Board) -> Bool {
        return left.grid == right.grid
    }
    
    // Méthode de hachage pour le protocole Hashable.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(grid)
    }
    
    /// Méthode pour compter le nombre de pièces d'un joueur.
    ///
    /// - Parameter player: Le joueur dont on veut compter les pièces.
    /// - Returns: Le nombre de pièces du joueur.
    public func countOnePlayerPieces(of player: Owner) -> Int {
        // On utilise flatMap pour transformer la grille bidimensionnelle en un tableau de cellules.
        // Avec filter, on ne garde que les cellules contenant une pièce appartenant au joueur souhaité.
        // Enfin, on compte le nombre d'éléments, soit le nombre de pièces du joueur.
        return grid.flatMap { $0 }.filter { $0.piece?.owner == player }.count
    }
    
    /// Méthode pour compter le nombre de pièces des deux joueurs.
    ///
    /// - Returns: Un tuple contenant le nombre de pièces pour le joueur 1 et le joueur 2.
    public func countTwoPlayersPieces() -> (player1Pieces: Int, player2Pieces: Int) {
        // On compte le nombre de pièces des deux joueurs, puis on retourne le résultat au sein d'un tuple.
        let player1Pieces = countOnePlayerPieces(of: .player1)
        let player2Pieces = countOnePlayerPieces(of: .player2)
        return (player1Pieces, player2Pieces)
    }
    
    /// Méthode pour insérer une pièce sur une cellule donnée.
    ///
    /// - Parameters:
    ///   - piece: La pièce à insérer.
    ///   - row: La ligne de la cellule où insérer la pièce.
    ///   - column: La colonne de la cellule où insérer la pièce.
    /// - Returns: Un résultat indiquant le succès ou l'échec de l'opération.
    public mutating func insertPiece(piece: Piece, atRow row: Int, andColumn column: Int) -> BoardResult {
        // On vérifie si la ligne et la colonne sont bien valides (supérieures à 0 et inférieures à la taille du plateau).
        guard row >= 0 && row < nbRows && column >= 0 && column < nbColumns else {
            return .failed(reason: .outOfBounds)
        }
        
        // On vérifie si la cellule aux coordonnées fournies ne contient pas déjà une pièce.
        guard grid[row][column].piece == nil else {
            return .failed(reason: .cellNotEmpty)
        }
        
        // On ajoute la pièce à l'emplacement visé.
        grid[row][column].piece = piece
        return .ok
    }
    
    /// Méthode pour supprimer une pièce sur une cellule donnée.
    ///
    /// - Parameters:
    ///   - row: La ligne de la cellule où supprimer la pièce.
    ///   - column: La colonne de la cellule où supprimer la pièce.
    /// - Returns: Un résultat indiquant le succès ou l'échec de l'opération.
    public mutating func removePiece(atRow row: Int, andColumn column: Int) -> BoardResult {
        // On vérifie si la ligne et la colonne sont bien valides (supérieures à 0 et inférieures à la taille du plateau).
        guard row >= 0 && row < nbRows && column >= 0 && column < nbColumns else {
            return .failed(reason: .outOfBounds)
        }
        
        // On vérifie si la cellule aux coordonnées fournies contient une pièce.
        guard grid[row][column].piece != nil else {
            return .failed(reason: .cellEmpty)
        }
        
        // On supprime la pièce à l'emplacement visé.
        grid[row][column].piece = nil
        return .ok
    }
}
