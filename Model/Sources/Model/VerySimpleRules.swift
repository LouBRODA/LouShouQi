import Foundation

public struct VerySimpleRules: Rules {
    public var occurrences: Int = 0
    public var historic: [Move] = []
    
    public init(occurrences: Int, historic: [Move]) {
        self.occurrences = occurrences
        self.historic = historic
    }
    
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
    
    public static func checkBoard(_ board: Board) -> Bool {
        let expectedRows = 5
        let expectedColumns = 5
        
        ///vérifier le nombre de lignes
        guard board.nbRows == expectedRows else {
            return false
        }
        
        ///vérifier le nombre de colonnes
        guard board.nbColumns == expectedColumns else {
            return false
        }
        
        ///vérifier l'emplacement des niches sur le board
        guard board.grid[0][2].cellType == CellType.den && board.grid[4][2].cellType == CellType.den else {
            return false
        }
        
        ///vérifier le nombre de pièces de chaque joueur
        guard board.countOnePlayerPieces(of: .player1) < 6 &&
                board.countOnePlayerPieces(of: .player2) < 6 else {
            return false
        }
        
        ///vérifier que les types d'animaux (wolf et leopard) ne sont pas présents sur le board
        guard !board.grid.flatMap({ $0 }).contains(where: { $0.piece?.animal == .wolf || $0.piece?.animal == .leopard || $0.piece?.animal == .dog }) else {
            return false
        }
        
        ///vérifier qu'il n'y a pas de cases de type eau sur le plateau
        guard !board.grid.flatMap({ $0 }).contains(where: { $0.cellType == .water }) else {
            return false
        }
        
        return true
    }
    
    public func getNextPlayer() -> Owner {
        return (historic.count % 2 == 0) ? .player1 : .player2
    }
    
    public func getMoves(for board: Board, of player: Owner) -> [Move] {
        var availableMoves: [Move] = []

            for row in 0..<board.nbRows {
                for column in 0..<board.nbColumns {
                    let move = Move(owner: player, rowOrigin: row, columnOrigin: column, rowDestination: row, columnDestination: column)

                    ///vérifier si le coup est valide
                    if isMoveValid(on: board, move: move) {
                        availableMoves.append(move)
                    }
                }
            }

            return availableMoves
    }
    
    public func getMoves(for board: Board, of player: Owner, fromRow row: Int, fromColumn column: Int) -> [Move] {
        var availableMoves: [Move] = []

        ///vérifier la validité des coordonnées données
        guard row >= 0 && row < board.nbRows && column >= 0 && column < board.nbColumns else {
            return availableMoves
        }

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
        
        return true
    }
    
    public func isMoveValid(on board: Board, move: Move) -> Bool {
        //on utilise la méthode précédente avec les coordonées du Move
        return isMoveValid(on: board, fromRow: move.rowOrigin, fromColumn: move.columnOrigin, toRow: move.rowDestination, toColumn: move.columnDestination)
    }
    
    public func isGameOver(on board: Board, lastMoveRow: Int, lastMoveColumn: Int) -> Bool {
        ///vérifier si un joueur a atteint la tannière de l'adversaire
        let lastMoveCell = board.grid[lastMoveRow][lastMoveColumn]
        if lastMoveCell.cellType == .den {
            let currentPlayer = getNextPlayer()
            let opponent = (currentPlayer == .player1) ? Owner.player2 : Owner.player1
            guard lastMoveCell.piece?.owner != opponent else {
                return true
            }
        }
        
        ///vérifier si un joueur a mangé toutes les pièces de l'adversaire
        let (player1Pieces, player2Pieces) = board.countTwoPlayersPieces()
        guard player1Pieces != 0 || player2Pieces != 0 else {
            return true
        }

        ///vérifier si l'adversaire ne peut pas faire le moindre mouvement
        let opponent = (getNextPlayer() == .player1) ? Owner.player2 : Owner.player1
        let availableMoves = getMoves(for: board, of: opponent)
        return availableMoves.isEmpty
    }
    
    public func playedMove(_ move: Move, on currentBoard: Board, resultingBoard: Board) {

    }
}
