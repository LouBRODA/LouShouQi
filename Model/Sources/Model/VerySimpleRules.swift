import Foundation

public struct VerySimpleRules: Rules {
    public var occurrences: [Board:Int] = [:]
    public var historic: [Move] = []
    public static let expectedRows = 5
    public static let expectedColumns = 5
    
    /// Initialiseur des règles simplifiées.
    public init() { }
    
    /// Crée un nouveau plateau de jeu initial.
    ///
    /// - Returns: Un nouveau plateau de jeu.
    public static func createBoard() -> Board {
        let jungleEmptyCell: Cell = Cell(cellType: .jungle)
        let denEmptyCellJ1: Cell = Cell(cellType: .den, initialOwner: .player1)
        let denEmptyCellJ2: Cell = Cell(cellType: .den, initialOwner: .player2)

        let ratJ1: Piece = Piece(owner: .player1, animal: .rat)
        let ratJ2: Piece = Piece(owner: .player2, animal: .rat)
        let catJ1: Piece = Piece(owner: .player1, animal: .cat)
        let catJ2: Piece = Piece(owner: .player2, animal: .cat)
        let tigerJ1: Piece = Piece(owner: .player1, animal: .tiger)
        let tigerJ2: Piece = Piece(owner: .player2, animal: .tiger)
        let lionJ1: Piece = Piece(owner: .player1, animal: .lion)
        let lionJ2: Piece = Piece(owner: .player2, animal: .lion)
        let elephantJ1: Piece = Piece(owner: .player1, animal: .elephant)
        let elephantJ2: Piece = Piece(owner: .player2, animal: .elephant)
        
        let ratJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: ratJ1.owner, piece: ratJ1)
        let ratJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: ratJ2.owner, piece: ratJ2)
        let catJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: catJ1.owner, piece: catJ1)
        let catJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: catJ1.owner, piece: catJ2)
        let tigerJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: tigerJ1.owner, piece: tigerJ1)
        let tigerJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: tigerJ2.owner, piece: tigerJ2)
        let lionJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: lionJ1.owner, piece: lionJ1)
        let lionJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: lionJ2.owner, piece: lionJ2)
        let elephantJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: elephantJ1.owner, piece: elephantJ1)
        let elephantJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: elephantJ2.owner, piece: elephantJ2)
        
        let initialBoard: Board = Board(withGrid: [
        [jungleEmptyCell, lionJ1StartingCell, denEmptyCellJ1, tigerJ1StartingCell, jungleEmptyCell],
        [ratJ1StartingCell, jungleEmptyCell, catJ1StartingCell, jungleEmptyCell, elephantJ1StartingCell],
        [jungleEmptyCell, jungleEmptyCell, jungleEmptyCell, jungleEmptyCell, jungleEmptyCell],
        [elephantJ2StartingCell, jungleEmptyCell, catJ2StartingCell, jungleEmptyCell, ratJ2StartingCell],
        [jungleEmptyCell, tigerJ2StartingCell, denEmptyCellJ2, lionJ2StartingCell, jungleEmptyCell],
        ])!;
        return initialBoard;
    }
    
    /// Vérifie si le plateau de jeu est valide.
    ///
    /// - Parameter board: Le plateau de jeu à vérifier.
    /// - Returns: Une erreur d'invalidité du plateau s'il y en a une, sinon `.noError`.
    public static func checkBoard(_ board: Board) throws -> Bool {
        //vérifier le nombre de lignes et de colonnes
        guard board.nbRows == expectedRows && board.nbColumns == expectedColumns else {
            throw InvalidBoardError.badDimensions(row: board.nbRows, column: board.nbColumns)
        }
        
        //vérifier l'emplacement de la niche du joueur 1 sur le board
        guard board.grid[0][2].cellType == CellType.den else {
            throw InvalidBoardError.badCellType(cellType: .den, row: 0, column: 2)
        }
        
        //vérifier l'emplacement de la niche du joueur 2 sur le board
        guard board.grid[4][2].cellType == CellType.den else {
            throw InvalidBoardError.badCellType(cellType: .den, row: 4, column: 2)
        }
        
        //vérifier le nombre de pièces de chaque joueur
        guard board.countOnePlayerPieces(of: .player1) < 6 &&
                board.countOnePlayerPieces(of: .player2) < 6 else {
            throw InvalidBoardError.numberOfPiece(piecesPlayer1: board.countOnePlayerPieces(of: .player1), piecesPlayer2: board.countOnePlayerPieces(of: .player2))
        }
        
        //vérifier que les types d'animaux (wolf et leopard) ne sont pas présents sur le board
        guard !board.grid.flatMap({ $0 }).contains(where: { $0.piece?.animal == .wolf || $0.piece?.animal == .leopard || $0.piece?.animal == .dog }) else {
            throw InvalidBoardError.animalNotAuthorized
        }
        
        //vérifier qu'il n'y a pas de cases de type eau sur le plateau
        guard !board.grid.flatMap({ $0 }).contains(where: { $0.cellType == .water }) else {
            throw InvalidBoardError.animalNotAuthorized
        }
        
        //vérifier qu'il n'y a au maximum qu'une occurence de chaque pièce
        let flatPieces = board.grid.flatMap { $0 }.compactMap { $0.piece }
        guard Set(flatPieces).count == flatPieces.count else {
            throw InvalidBoardError.multipleOccurrencesOfSamePiece(piece: flatPieces.first!)
        }
                
        //vérifier que toutes les pièces ont bien un propriétaire
        if !board.grid.flatMap({ $0 }).allSatisfy({ $0.piece?.owner != nil }) {
            //trouver la première pièce sans propriétaire
            if let pieceWithoutOwner = board.grid.flatMap({ $0 }).first(where: { $0.piece?.owner == nil })?.piece {
                throw InvalidBoardError.pieceWithNoOwner(piece: pieceWithoutOwner)
            }
        }
        
        return true
    }
    
    /// Obtient le joueur suivant dans la séquence du tour de jeu.
    ///
    /// - Returns: Le propriétaire du joueur suivant.
    public func getNextPlayer() -> Owner {
        return (historic.count % 2 == 0) ? .player1 : .player2
    }
    
    /// Obtient la liste des mouvements possibles pour un joueur sur le plateau donné.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - player: Le propriétaire du joueur pour lequel obtenir les mouvements.
    /// - Returns: Une liste de mouvements possibles.
    public func getMoves(for board: Board, of player: Owner) -> [Move] {
        var availableMoves: [Move] = []

        for originRow in 0..<board.nbRows {
            for originColumn in 0..<board.nbColumns {
                let possibleMoves = getMoves(for: board, of: player, fromRow: originRow, fromColumn: originColumn)
                availableMoves.append(contentsOf: possibleMoves)
            }
        }

        return availableMoves
    }
    
    /// Obtient la liste des mouvements possibles pour un joueur à partir d'une position spécifique sur le plateau.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - player: Le propriétaire du joueur pour lequel obtenir les mouvements.
    ///   - row: La ligne de départ du mouvement.
    ///   - column: La colonne de départ du mouvement.
    /// - Returns: Une liste de mouvements possibles.
    public func getMoves(for board: Board, of player: Owner, fromRow row: Int, fromColumn column: Int) -> [Move] {
        var availableMoves: [Move] = []

        //vérifier la validité des coordonnées données
        guard row >= 0 && row < board.nbRows && column >= 0 && column < board.nbColumns else {
            return availableMoves
        }

        //vérifier les cases adjacentes
        for i in -1...1 {
            for j in -1...1 {
                if i == 0 || j == 0 {
                    let destinationRow = row + i
                    let destinationColumn = column + j
                    
                    //vérifier si la cellule d'origine contient une pièce du joueur actuel
                    if let piece = board.grid[row][column].piece, piece.owner == player {
                        
                        let move = Move(owner: player, rowOrigin: row, columnOrigin: column, rowDestination: destinationRow, columnDestination: destinationColumn)
                        
                        do {
                            // Vérifier si le coup est valide
                            if try isMoveValid(on: board, move: move) {
                                availableMoves.append(move)
                            }
                        } catch { }
                    }
                }
            }
        }

        return availableMoves
    }
    
    /// Vérifie si un mouvement spécifique est valide sur le plateau donné.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - originRow: La ligne de départ du mouvement.
    ///   - originColumn: La colonne de départ du mouvement.
    ///   - destinationRow: La ligne de destination du mouvement.
    ///   - destinationColumn: La colonne de destination du mouvement.
    /// - Returns: `true` si le mouvement est valide, sinon `false`.
    public func isMoveValid(on board: Board, fromRow originRow: Int, fromColumn originColumn: Int, toRow destinationRow: Int, toColumn destinationColumn: Int) throws -> Bool {
        //vérifier la validité des coordonnées données
        guard originRow >= 0 && originRow < board.nbRows && originColumn >= 0 && originColumn < board.nbColumns &&
              destinationRow >= 0 && destinationRow < board.nbRows && destinationColumn >= 0 && destinationColumn < board.nbColumns else {
            throw GameError.invalidMove
        }

        //récupérer les cellules d'origine et de destination en fonction des coordonnées données
        let originCell = board.grid[originRow][originColumn]
        let destinationCell = board.grid[destinationRow][destinationColumn]
        
        //vérifier si la cellule de destination contient déjà une pièce du joueur actuel
        guard originCell.piece?.owner != destinationCell.piece?.owner else {
            throw GameError.invalidMove
        }
        
        //vérifier si la pièce de l'adversaire présente sur la cellule de destination possède une force inférieure à la pièce du joueur actuel
        if let opponentPiece = destinationCell.piece, let piece = originCell.piece {
            guard !(piece.animal.rawValue == 8 && opponentPiece.animal.rawValue == 1) && piece.animal.rawValue >= opponentPiece.animal.rawValue else {
                throw GameError.invalidMove
            }
        }
        
        //vérifier si la cellule de destination ne correspond pas à la tanière du joueur actuel
        if destinationCell.cellType == .den {
            if destinationCell.initialOwner != getNextPlayer(){
                throw GameError.invalidMove
            }
        }
        
        //vérifier si le déplacement n'est pas supérieur à une case
        if abs(originRow - destinationRow) <= 0 && abs(originRow - destinationRow) >= 1 &&
           abs(originColumn - destinationColumn) <= 0 && abs(originColumn - destinationColumn) >= 1 &&
            abs(originRow - destinationRow) + abs(originColumn - destinationColumn) != 0 &&
            abs(originRow - destinationRow) + abs(originColumn - destinationColumn) != 2 {
            throw GameError.invalidMove
        }
        
        return true
    }
    
    /// Vérifie si un mouvement spécifique est valide sur le plateau donné.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - move: Le mouvement à vérifier.
    /// - Returns: `true` si le mouvement est valide, sinon `false`.
    public func isMoveValid(on board: Board, move: Move) throws -> Bool {
        //on utilise la méthode précédente avec les coordonées du Move
        return try isMoveValid(on: board, fromRow: move.rowOrigin, fromColumn: move.columnOrigin, toRow: move.rowDestination, toColumn: move.columnDestination)
    }
    
    /// Vérifie si la partie est terminée sur le plateau donné après un certain mouvement.
    ///
    /// - Parameters:
    ///   - board: Le plateau de jeu actuel.
    ///   - lastMoveRow: La ligne du dernier mouvement.
    ///   - lastMoveColumn: La colonne du dernier mouvement.
    /// - Returns: Un tuple indiquant si la partie est terminée et le résultat de la partie.
    public func isGameOver(on board: Board, lastMoveRow: Int, lastMoveColumn: Int) throws -> (Bool, Result) {
        //vérifier si un joueur a atteint la tannière de l'adversaire
        let lastMoveCell = board.grid[lastMoveRow][lastMoveColumn]
        if lastMoveCell.cellType == .den {
            let currentPlayer = getNextPlayer()
            let opponent = (currentPlayer == .player1) ? Owner.player2 : Owner.player1
            guard lastMoveCell.piece?.owner != opponent else {
                return (true, .winner(owner: opponent, .denReached))
            }
        }
        
        //vérifier si un joueur a mangé toutes les pièces de l'adversaire
        let (player1Pieces, player2Pieces) = board.countTwoPlayersPieces()
        guard player1Pieces != 0 || player2Pieces != 0 else {
            return (true, .winner(owner: (player1Pieces == 0) ? .player2 : .player1, .noMorePieces))
        }

        //vérifier si l'adversaire ne peut pas faire le moindre mouvement
        let opponent = (getNextPlayer() == .player1) ? Owner.player2 : Owner.player1
        let availableMoves = getMoves(for: board, of: opponent)
        return availableMoves.isEmpty ? (true, .winner(owner: opponent, .noMovesLeft)) : (false, .notFinished)
    }
    
    /// Met à jour l'état du plateau après un mouvement effectué.
    ///
    /// - Parameters:
    ///   - move: Le mouvement joué.
    ///   - currentBoard: Le plateau de jeu avant le mouvement.
    ///   - resultingBoard: Le plateau de jeu après le mouvement.
    public mutating func playedMove(_ move: Move, on currentBoard: Board, resultingBoard: Board) {
        //Ajouter le dernier coup joué dans l'historique
        historic.append(move)

        //Mettre à jour le nombre d'occurrences pour le nouveau plateau
        if let count = occurrences[resultingBoard] {
            occurrences[resultingBoard] = count + 1
        } else {
            occurrences[resultingBoard] = 1
        }
    }
}
