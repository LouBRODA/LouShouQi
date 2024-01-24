import Foundation

public struct VerySimpleRules: Rules {
    public var occurrences: [Board:Int] = [:]
    public var historic: [Move] = []
    public static let expectedRows = 5
    public static let expectedColumns = 5
    
    //à enlever car useless
    public init(occurrences: [Board:Int], historic: [Move]) {
        self.occurrences = occurrences
        self.historic = historic
    }
    
    ///Méthode permettant de créer une Board selon les règles simplifiées
    public static func createBoard() -> Board {
        let jungleEmptyCell: Cell = Cell(cellType: .jungle)
        let denEmptyCell: Cell = Cell(cellType: .den)
            
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
        [jungleEmptyCell, lionJ1StartingCell, denEmptyCell, tigerJ1StartingCell, jungleEmptyCell],
        [ratJ1StartingCell, jungleEmptyCell, catJ1StartingCell, jungleEmptyCell, elephantJ1StartingCell],
        [jungleEmptyCell, jungleEmptyCell, jungleEmptyCell, jungleEmptyCell, jungleEmptyCell],
        [elephantJ2StartingCell, jungleEmptyCell, catJ2StartingCell, jungleEmptyCell, ratJ2StartingCell],
        [jungleEmptyCell, tigerJ2StartingCell, denEmptyCell, lionJ2StartingCell, jungleEmptyCell],
        ])!;
        return initialBoard;
    }
    
    ///Méthode permettant de vérifier la bonne forme du Board selon les règles simplifiées
    public static func checkBoard(_ board: Board) -> InvalidBoardError {
        ///vérifier le nombre de lignes et de colonnes
        guard board.nbRows == expectedRows && board.nbColumns == expectedColumns else {
            return .badDimensions(row: board.nbRows, column: board.nbColumns)
        }
        
        ///vérifier l'emplacement de la niche du joueur 1 sur le board
        guard board.grid[0][2].cellType == CellType.den else {
            return .badCellType(cellType: .den, row: 0, column: 2)
        }
        
        ///vérifier l'emplacement de la niche du joueur 2 sur le board
        guard board.grid[4][2].cellType == CellType.den else {
            return .badCellType(cellType: .den, row: 4, column: 2)
        }
        
        ///vérifier le nombre de pièces de chaque joueur
        guard board.countOnePlayerPieces(of: .player1) < 6 &&
                board.countOnePlayerPieces(of: .player2) < 6 else {
            return .numberOfPiece(piecesPlayer1: board.countOnePlayerPieces(of: .player1), piecesPlayer2: board.countOnePlayerPieces(of: .player2))
        }
        
        ///vérifier que les types d'animaux (wolf et leopard) ne sont pas présents sur le board
        guard !board.grid.flatMap({ $0 }).contains(where: { $0.piece?.animal == .wolf || $0.piece?.animal == .leopard || $0.piece?.animal == .dog }) else {
            return .animalNotAuthorized
        }
        
        ///vérifier qu'il n'y a pas de cases de type eau sur le plateau
        guard !board.grid.flatMap({ $0 }).contains(where: { $0.cellType == .water }) else {
            return .animalNotAuthorized
        }
        
        ///vérifier qu'il n'y a au maximum qu'une occurence de chaque pièce
        let flatPieces = board.grid.flatMap { $0 }.compactMap { $0.piece }
        guard Set(flatPieces).count == flatPieces.count else {
            return .multipleOccurrencesOfSamePiece(piece: flatPieces.first!)
        }
                
        return .noError
    }
    
    ///Méthode permettant de connaître le prochain joueur
    public func getNextPlayer() -> Owner {
        return (historic.count % 2 == 0) ? .player1 : .player2
    }
    
    ///Méthode permettant de connaître les prochains coups d'un joueur en fonction d'un plateau
    public func getMoves(for board: Board, of player: Owner) -> [Move] {
        var availableMoves: [Move] = []

        for originRow in 0..<board.nbRows {
            for originColumn in 0..<board.nbColumns {
                ///Les quatres seuls déplacements possibles
                let possibleMoves = [
                    Move(owner: player, rowOrigin: originRow, columnOrigin: originColumn, rowDestination: originRow - 1, columnDestination: originColumn),
                    Move(owner: player, rowOrigin: originRow, columnOrigin: originColumn, rowDestination: originRow + 1, columnDestination: originColumn),
                    Move(owner: player, rowOrigin: originRow, columnOrigin: originColumn, rowDestination: originRow, columnDestination: originColumn - 1),
                    Move(owner: player, rowOrigin: originRow, columnOrigin: originColumn, rowDestination: originRow, columnDestination: originColumn + 1)
                ]

                ///on regarde quels coups sont valides parmi les coups possibles
                for move in possibleMoves {
                    if isMoveValid(on: board, move: move) {
                        availableMoves.append(move)
                    }
                }
            }
        }

        return availableMoves
    }
    
    ///Méthode permettant de connaître les prochains coups d'un joueur en fonction d'un plateau et des coordonnées d'une pièce
    public func getMoves(for board: Board, of player: Owner, fromRow row: Int, fromColumn column: Int) -> [Move] {
        var availableMoves: [Move] = []

        ///vérifier la validité des coordonnées données
        guard row >= 0 && row < board.nbRows && column >= 0 && column < board.nbColumns else {
            return availableMoves
        }

        ///vérifier les cases adjacentes
        for i in -1...1 {
            for j in -1...1 {
                let destinationRow = row + i
                let destinationColumn = column + j

                let move = Move(owner: player, rowOrigin: row, columnOrigin: column, rowDestination: destinationRow, columnDestination: destinationColumn)

                ///vérifier si le coup est valide
                if isMoveValid(on: board, move: move) {
                    availableMoves.append(move)
                }
            }
        }

        return availableMoves
    }
    
    ///Méthode permettant de savoir si un coup est valide à partir d'un Board et des coordonnées d'origine et de destination
    public func isMoveValid(on board: Board, fromRow originRow: Int, fromColumn originColumn: Int, toRow destinationRow: Int, toColumn destinationColumn: Int) -> Bool {
        ///vérifier la validité des coordonnées données
        guard originRow >= 0 && originRow < board.nbRows && originColumn >= 0 && originColumn < board.nbColumns &&
              destinationRow >= 0 && destinationRow < board.nbRows && destinationColumn >= 0 && destinationColumn < board.nbColumns else {
            return false
        }

        ///récupérer les cellules d'origine et de destination en fonction des coordonnées données
        let originCell = board.grid[originRow][originColumn]
        let destinationCell = board.grid[destinationRow][destinationColumn]

        ///vérifier si la cellule d'origine contient une pièce du joueur actuel
        guard let piece = originCell.piece, piece.owner == getNextPlayer() else {
            return false
        }
        
        ///vérifier si la cellule de destination contient déjà une pièce du joueur actuel
        guard originCell.piece?.owner != destinationCell.piece?.owner else {
            return false
        }
        
        //vérifier si la pièce de l'adversaire présente sur la cellule de destination possède une force inférieure à la pièce du joueur actuel
        if let opponentPiece = destinationCell.piece {
            guard piece.animal.rawValue >= opponentPiece.animal.rawValue else {
                return false
            }
        }
        
        //vérifier si la cellule de destination ne correspond pas à la tanière du joueur actuel
//        if destinationCell {
//            guard opponentCell.cellType == .den && opponentCell.initialOwner == getNextPlayer() else {
//                return false
//            }
//        }
        
        return true
    }
    
    ///Méthode permettant de savoir si un coup est valide à partir d'un Board et d'un coup
    public func isMoveValid(on board: Board, move: Move) -> Bool {
        ///on utilise la méthode précédente avec les coordonées du Move
        return isMoveValid(on: board, fromRow: move.rowOrigin, fromColumn: move.columnOrigin, toRow: move.rowDestination, toColumn: move.columnDestination)
    }
    
    ///Méthode permettant de savoir si une partie est terminée
    public func isGameOver(on board: Board, lastMoveRow: Int, lastMoveColumn: Int) -> (Bool, Result) {
        ///vérifier si un joueur a atteint la tannière de l'adversaire
        let lastMoveCell = board.grid[lastMoveRow][lastMoveColumn]
        if lastMoveCell.cellType == .den {
            let currentPlayer = getNextPlayer()
            let opponent = (currentPlayer == .player1) ? Owner.player2 : Owner.player1
            guard lastMoveCell.piece?.owner != opponent else {
                return (true, .winner(owner: opponent, .denReached))
            }
        }
        
        ///vérifier si un joueur a mangé toutes les pièces de l'adversaire
        let (player1Pieces, player2Pieces) = board.countTwoPlayersPieces()
        guard player1Pieces != 0 || player2Pieces != 0 else {
            return (true, .winner(owner: (player1Pieces == 0) ? .player2 : .player1, .noMorePieces))
        }

        ///vérifier si l'adversaire ne peut pas faire le moindre mouvement
        let opponent = (getNextPlayer() == .player1) ? Owner.player2 : Owner.player1
        let availableMoves = getMoves(for: board, of: opponent)
        return availableMoves.isEmpty ? (true, .winner(owner: opponent, .noMovesLeft)) : (false, .notFinished)
    }
    
    ///Méthode permettant de stocker les coups réalisés
    public mutating func playedMove(_ move: Move, on currentBoard: Board, resultingBoard: Board) {
        ///Ajouter le dernier coup joué dans l'historique
        historic.append(move)

        ///Mettre à jour le nombre d'occurrences pour le nouveau plateau
        if let count = occurrences[resultingBoard] {
            occurrences[resultingBoard] = count + 1
        } else {
            occurrences[resultingBoard] = 1
        }
    }
}
