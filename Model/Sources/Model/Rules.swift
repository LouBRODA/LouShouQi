import Foundation

/// Protocole définissant les règles du jeu.
public protocol Rules: Hashable {
    /// Dictionnaire enregistrant le nombre d'occurrences de chaque état du plateau.
    var occurrences: [Board: Int] { get }
    
    /// Liste des mouvements historiques effectués dans le jeu.
    var historic: [Move] { get }
    
    /// Crée un nouveau plateau de jeu initial.
    ///
    /// - Returns: Un nouveau plateau de jeu.
    static func createBoard() -> Board
    
    /// Vérifie si le plateau de jeu est valide.
    ///
    /// - Parameter board: Le plateau de jeu à vérifier.
    /// - Returns: Une erreur d'invalidité du plateau s'il y en a une, sinon `.noError`.
    static func checkBoard(_ board: Board) -> InvalidBoardError
    
    /// Obtient le joueur suivant dans la séquence du tour de jeu.
    ///
    /// - Returns: Le propriétaire du joueur suivant.
    func getNextPlayer() -> Owner
    
    /// Obtient la liste des mouvements possibles pour un joueur sur le plateau donné.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - player: Le propriétaire du joueur pour lequel obtenir les mouvements.
    /// - Returns: Une liste de mouvements possibles.
    func getMoves(for board: Board, of player: Owner) -> [Move]
    
    /// Obtient la liste des mouvements possibles pour un joueur à partir d'une position spécifique sur le plateau.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - player: Le propriétaire du joueur pour lequel obtenir les mouvements.
    ///   - row: La ligne de départ du mouvement.
    ///   - column: La colonne de départ du mouvement.
    /// - Returns: Une liste de mouvements possibles.
    func getMoves(for board: Board, of player: Owner, fromRow row: Int, fromColumn column: Int) -> [Move]
    
    /// Vérifie si un mouvement spécifique est valide sur le plateau donné.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - originRow: La ligne de départ du mouvement.
    ///   - originColumn: La colonne de départ du mouvement.
    ///   - destinationRow: La ligne de destination du mouvement.
    ///   - destinationColumn: La colonne de destination du mouvement.
    /// - Returns: `true` si le mouvement est valide, sinon `false`.
    func isMoveValid(on board: Board, fromRow originRow: Int, fromColumn originColumn: Int, toRow destinationRow: Int, toColumn destinationColumn: Int) -> Bool
    
    /// Vérifie si un mouvement spécifique est valide sur le plateau donné.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - move: Le mouvement à vérifier.
    /// - Returns: `true` si le mouvement est valide, sinon `false`.
    func isMoveValid(on board: Board, move: Move) -> Bool
    
    /// Vérifie si la partie est terminée sur le plateau donné après un certain mouvement.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - lastMoveRow: La ligne du dernier mouvement.
    ///   - lastMoveColumn: La colonne du dernier mouvement.
    /// - Returns: Un tuple indiquant si la partie est terminée et le résultat de la partie.
    func isGameOver(on board: Board, lastMoveRow: Int, lastMoveColumn: Int) -> (Bool, Result)
    
    /// Met à jour l'état du plateau après un mouvement effectué.
    ///
    /// - Parameters:
    ///   - move: Le mouvement joué.
    ///   - currentBoard: Le plateau de jeu avant le mouvement.
    ///   - resultingBoard: Le plateau de jeu après le mouvement.
    mutating func playedMove(_ move: Move, on currentBoard: Board, resultingBoard: Board)
}
