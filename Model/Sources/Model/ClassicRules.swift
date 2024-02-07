import Foundation

public struct ClassicRules: Rules {
    public var occurrences: [Board:Int] = [:]
    public var historic: [Move] = []
    public static let expectedRows = 10
    public static let expectedColumns = 7
    
    /// Initialiseur des règles simplifiées.
    public init() { }
    
    public static func createBoard() -> Board {
        let jungleEmptyCell: Cell = Cell(cellType: .jungle)
        let waterEmptyCell: Cell = Cell(cellType: .water)
        let denEmptyCellJ1: Cell = Cell(cellType: .den, initialOwner: .player1)
        let denEmptyCellJ2: Cell = Cell(cellType: .den, initialOwner: .player2)
        let trapEmptyCellJ1: Cell = Cell(cellType: .trap, initialOwner: .player1)
        let trapEmptyCellJ2: Cell = Cell(cellType: .trap, initialOwner: .player2)

        let ratJ1: Piece = Piece(owner: .player1, animal: .rat)
        let ratJ2: Piece = Piece(owner: .player2, animal: .rat)
        let catJ1: Piece = Piece(owner: .player1, animal: .cat)
        let catJ2: Piece = Piece(owner: .player2, animal: .cat)
        let dogJ1: Piece = Piece(owner: .player1, animal: .dog)
        let dogJ2: Piece = Piece(owner: .player2, animal: .dog)
        let wolfJ1: Piece = Piece(owner: .player1, animal: .wolf)
        let wolfJ2: Piece = Piece(owner: .player2, animal: .wolf)
        let leopardJ1: Piece = Piece(owner: .player1, animal: .leopard)
        let leopardJ2: Piece = Piece(owner: .player2, animal: .leopard)
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
        let dogJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: dogJ1.owner, piece: dogJ1)
        let dogJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: dogJ2.owner, piece: dogJ2)
        let wolfJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: wolfJ1.owner, piece: wolfJ1)
        let wolfJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: wolfJ2.owner, piece: wolfJ2)
        let leopardJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: leopardJ1.owner, piece: leopardJ1)
        let leopardJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: leopardJ2.owner, piece: leopardJ2)
        let tigerJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: tigerJ1.owner, piece: tigerJ1)
        let tigerJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: tigerJ2.owner, piece: tigerJ2)
        let lionJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: lionJ1.owner, piece: lionJ1)
        let lionJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: lionJ2.owner, piece: lionJ2)
        let elephantJ1StartingCell : Cell = Cell(cellType: .jungle, initialOwner: elephantJ1.owner, piece: elephantJ1)
        let elephantJ2StartingCell : Cell = Cell(cellType: .jungle, initialOwner: elephantJ2.owner, piece: elephantJ2)
        
        let initialBoard: Board = Board(withGrid: [
            [lionJ1StartingCell, jungleEmptyCell, trapEmptyCellJ1, denEmptyCellJ1, trapEmptyCellJ1, jungleEmptyCell, tigerJ1StartingCell],
            [jungleEmptyCell, dogJ1StartingCell, jungleEmptyCell, trapEmptyCellJ1, jungleEmptyCell, catJ1StartingCell, jungleEmptyCell],
            [ratJ1StartingCell, jungleEmptyCell, leopardJ1StartingCell, jungleEmptyCell, wolfJ1StartingCell, jungleEmptyCell, elephantJ1StartingCell],
            [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
            [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
            [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
            [jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell, waterEmptyCell, waterEmptyCell, jungleEmptyCell],
            [elephantJ2StartingCell, jungleEmptyCell, wolfJ2StartingCell, jungleEmptyCell, leopardJ2StartingCell, jungleEmptyCell, ratJ2StartingCell],
            [jungleEmptyCell, catJ2StartingCell, jungleEmptyCell, trapEmptyCellJ2, jungleEmptyCell, dogJ2StartingCell, jungleEmptyCell],
            [tigerJ2StartingCell, jungleEmptyCell, trapEmptyCellJ2, denEmptyCellJ2, trapEmptyCellJ2, jungleEmptyCell, lionJ2StartingCell]
        ])!        
        return initialBoard;
    }
    
    public static func checkBoard(_ board: Board) throws -> Bool {
        //vérifier le nombre de lignes et de colonnes
        guard board.nbRows == expectedRows && board.nbColumns == expectedColumns else {
            throw InvalidBoardError.badDimensions(row: board.nbRows, column: board.nbColumns)
        }
        
        //vérifier l'emplacement de la niche du joueur 1 sur le board
        guard board.grid[0][3].cellType == CellType.den else {
            throw InvalidBoardError.badCellType(cellType: .den, row: 0, column: 3)
        }
        
        //vérifier l'emplacement de la niche du joueur 2 sur le board
        guard board.grid[9][3].cellType == CellType.den else {
            throw InvalidBoardError.badCellType(cellType: .den, row: 9, column: 3)
        }
        
        //vérifier le nombre de pièces de chaque joueur
        guard board.countOnePlayerPieces(of: .player1) < 9 &&
                board.countOnePlayerPieces(of: .player2) < 9 else {
            throw InvalidBoardError.numberOfPiece(piecesPlayer1: board.countOnePlayerPieces(of: .player1), piecesPlayer2: board.countOnePlayerPieces(of: .player2))
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
    
    public func getNextPlayer() -> Owner {
        return (historic.count % 2 == 0) ? .player1 : .player2
    }
    
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
    
    public func getMoves(for board: Board, of player: Owner, fromRow row: Int, fromColumn column: Int) -> [Move] {
        //TO REPLACE
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
    
    public func isMoveValid(on board: Board, fromRow originRow: Int, fromColumn originColumn: Int, toRow destinationRow: Int, toColumn destinationColumn: Int) throws -> Bool {
        //TO REPLACE
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
            if destinationCell.initialOwner == originCell.piece?.owner{
                throw GameError.invalidMove
            }
        }
        
        //vérifier si le déplacement n'est pas supérieur à une case
        if abs(originRow - destinationRow) <= 1 && abs(originColumn - destinationColumn) <= 1 &&
            (abs(originRow - destinationRow) + abs(originColumn - destinationColumn) == 1) {
        } else {
            throw GameError.invalidMove
        }
        
        return true
    }
    
    public func isMoveValid(on board: Board, move: Move) throws -> Bool {
        //on utilise la méthode précédente avec les coordonées du Move
        return try isMoveValid(on: board, fromRow: move.rowOrigin, fromColumn: move.columnOrigin, toRow: move.rowDestination, toColumn: move.columnDestination)
    }
    
    public func isGameOver(on board: Board, lastMoveRow: Int, lastMoveColumn: Int) throws -> (Bool, Result) {
        //vérifier si un joueur a atteint la tannière de l'adversaire
        let currentPlayer = getNextPlayer()
        let opponent = (currentPlayer == .player1) ? Owner.player2 : Owner.player1
        if board.grid[lastMoveRow][lastMoveColumn].cellType == .den && board.grid[lastMoveRow][lastMoveColumn].piece?.owner == opponent {
            return (true, .winner(owner: currentPlayer, .denReached))
        }
        
        //vérifier si un joueur a mangé toutes les pièces de l'adversaire
        let (player1Pieces, player2Pieces) = board.countTwoPlayersPieces()
        guard player1Pieces != 0 || player2Pieces != 0 else {
            return (true, .winner(owner: (player1Pieces == 0) ? .player2 : .player1, .noMorePieces))
        }

        //vérifier si l'adversaire ne peut pas faire le moindre mouvement
        let availableMoves = getMoves(for: board, of: opponent)
        return availableMoves.isEmpty ? (true, .winner(owner: opponent, .noMovesLeft)) : (false, .notFinished)
    }
    
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
