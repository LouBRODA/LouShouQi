import XCTest
import Model

final class ModelTests: XCTestCase {

    var board: Board!
    var rules = VerySimpleRules(occurrences: [:], historic: [])
    
    ///Fonction lancée avant chaque fonction de test
    override func setUpWithError() throws {
        let piece = Piece(owner: .player1, animal: .cat)
        let cell = Cell(cellType: .jungle, initialOwner: .player1, piece: piece)
        let cell2 = Cell(cellType: .jungle, initialOwner: .player1)
        let validGrid = [[cell, cell], [cell, cell2]]
        board = Board(withGrid: validGrid)
        rules = VerySimpleRules(occurrences: [:], historic: [])
    }

    ///Fonction lancée après chaque fonction de test
    override func tearDownWithError() throws {
        board = nil // useless
    }

    ///Test de l'initialisation du board avec une grille valide
    func testInitializationWithValidGrid() throws {
        XCTAssertNotNil(board)
        XCTAssertEqual(board.nbRows, 2)
        XCTAssertEqual(board.nbColumns, 2)
    }

    ///Test de l'initialisation du board avec une grille invalide
    func testInitializationWithInvalidGrid() throws {
        let cell1 = Cell(cellType: .jungle, initialOwner: .player1)
        let cell2 = Cell(cellType: .jungle, initialOwner: .player1)
        let invalidGrid = [[cell1, cell1], [cell2]]
        let invalidBoard = Board(withGrid: invalidGrid)
        
        XCTAssertNil(invalidBoard)
    }
    
    ///Test de l'insertion fonctionnelle d'une pièce dans le board
    func testInsertPiece() throws {
        let piece = Piece(owner: .player1, animal: .cat)
        
        let result = board.insertPiece(piece: piece, atRow: 1, andColumn: 1)
        
        XCTAssertEqual(result, .ok)
        XCTAssertEqual(board.grid[1][1].piece?.owner, .player1)
    }

    ///Test de l'insertion non fonctionnelle d'une pièce hors du board
    func testInsertPieceOutOfBounds() throws {
        let piece = Piece(owner: .player1, animal: .cat)
        
        let result = board.insertPiece(piece: piece, atRow: 2, andColumn: 2)
        
        XCTAssertEqual(result, .failed(reason: .outOfBounds))
        XCTAssertNil(board.grid[1][1].piece)
    }

    ///Test de l'insertion non fonctionnelle d'une pièce dans une cellule du board non vide
    func testInsertPieceInNonEmptyCell() throws {
        let piece1 = Piece(owner: .player1, animal: .cat)
        
        let result = board.insertPiece(piece: piece1, atRow: 0, andColumn: 0)
        
        XCTAssertEqual(result, .failed(reason: .cellNotEmpty))
        XCTAssertEqual(board.grid[0][0].piece?.owner, .player1)
    }

    ///Test de la suppression fonctionnelle d'une pièce du board
    func testRemovePiece() throws {
        let result = board.removePiece(atRow: 0, andColumn: 0)
        
        XCTAssertEqual(result, .ok)
        XCTAssertNil(board.grid[0][0].piece)
    }

    ///Test de la suppression non fonctionnelle d'une pièce hors du board
    func testRemovePieceOutOfBounds() throws {
        let result = board.removePiece(atRow: 2, andColumn: 2)
        
        XCTAssertEqual(result, .failed(reason: .outOfBounds))
    }

    ///Test de la suppression non fonctionnelle d'une pièce dans une cellule du board non vide
    func testRemovePieceFromEmptyCell() throws {
        let result = board.removePiece(atRow: 1, andColumn: 1)
        
        XCTAssertEqual(result, .failed(reason: .cellEmpty))
    }

    ///Test du comptage fonctionnel du nombre de pièces d'un joueur dans le board
    func testCountOnePlayerPieces() throws {
        let count = board.countOnePlayerPieces(of: .player1)
        
        XCTAssertEqual(count, 3)
    }

    ///Test du comptage fonctionnel du nombre de pièces des deux joueurs dans le board
    func testCountTwoPlayersPieces() throws {
        let count = board.countTwoPlayersPieces()
        
        XCTAssertEqual(count.player1Pieces, 3)
        XCTAssertEqual(count.player2Pieces, 0)
    }

    ///Test pour le cas unknown de l'enum BoardResult
    func testUnknownResult() throws {
        let unknownResult: BoardResult = .unknown

        XCTAssertEqual(unknownResult, .unknown)
    }

    ///Test pour le cas par défaut de l'enum BoardResult
    func testFailedResult() throws {
        let unknownResult: BoardResult = .unknown

        XCTAssertNotEqual(unknownResult, .ok)
    }
    
    ///Test pour le cas noOne de l'enum Owner
    func testNoOne() throws {
        let noOne: Owner = .noOne

        XCTAssertEqual(noOne.description, "x")
    }
    
    ///Test pour le cas player 2 de l'enum Owner
    func testPlayer2() throws {
        let player2: Owner = .player2

        XCTAssertEqual(player2.description, "2")
    }
    
    ///Test pour l'affichage de la description d'une pièce
    func testDescriptionPiece() throws {
        let piece = Piece(owner: .player1, animal: .cat)

        XCTAssertEqual(piece.description, "[1:cat]")
    }
    
    ///Test pour l'initialiseur de Piece sous la forme Parameterized Unit Test
    func testParameterizedPieceInitializer() throws {
        func expect(expectedPiece: Piece, withOwner: Owner, andAnimal: Animal) {
            let piece = Piece(owner: withOwner, animal: andAnimal)
            XCTAssertEqual(expectedPiece.owner, piece.owner)
            XCTAssertEqual(expectedPiece.animal, piece.animal)
        }

        expect(expectedPiece: Piece(owner: .player1, animal: .cat), withOwner: .player1, andAnimal: .cat)
        expect(expectedPiece: Piece(owner: .player2, animal: .lion), withOwner: .player2, andAnimal: .lion)
    }
    
    ///Test pour l'ajout d'une Piece sous la forme Parameterized Unit Test
    func testParameterized() throws {
        func expect(expectedBoardResult: BoardResult, atRow: Int, andColumn: Int) {
            let piece = Piece(owner: .player1, animal: .cat)
            let boardResult = board.insertPiece(piece: piece, atRow: atRow, andColumn: andColumn)
            XCTAssertEqual(expectedBoardResult, boardResult)
        }

        expect(expectedBoardResult: .ok, atRow: 1, andColumn: 1)
        expect(expectedBoardResult: .failed(reason: BoardFailingReason.cellNotEmpty), atRow: 0, andColumn: 0)
    }
    
    
    ///Test de performance pour l'initialiseur de Board
    func testInitPerformance() throws {
        let gridSize = 1000
        let cell = Cell(cellType: .jungle, initialOwner: .player1)
        let grid = Array(repeating: Array(repeating: cell, count: gridSize), count: gridSize)

        measure {
            let _ = Board(withGrid: grid)
        }
    }

    ///Test de performance pour la méthode insertPiece de Board
    func testInsertPiecePerformance() throws {
        var board = Board(withGrid: [[Cell(cellType: .jungle, initialOwner: .player1)]])!
        let piece = Piece(owner: .player1, animal: .cat)

        measure {
            _ = board.insertPiece(piece: piece, atRow: 0, andColumn: 1)
        }
    }

    ///Test de performance pour la méthode removePiece de Board
    func testRemovePiecePerformance() throws {
        var board = Board(withGrid: [[Cell(cellType: .jungle, initialOwner: .player1)]])!

        measure {
            _ = board.removePiece(atRow: 0, andColumn: 0)
        }
    }

    ///Test de performance pour la méthode countOnePlayerPieces de Board
    func testCountOnePlayerPiecesPerformance() throws {
        let board = Board(withGrid: [[Cell(cellType: .jungle, initialOwner: .player1)]])!

        measure {
            _ = board.countOnePlayerPieces(of: .player1)
        }
    }

    ///Test de performance pour la méthode countTwoPlayersPieces de Board
    func testCountTwoPlayersPiecesPerformance() throws {
        let board = Board(withGrid: [[Cell(cellType: .jungle, initialOwner: .player1)]])!

        measure {
            _ = board.countTwoPlayersPieces()
        }
    }

    ///TESTS POUR LA CLASSE VERY SIMPLE RULES
    
    ///Test de création et vérification du plateau
    func testCreateBoard() {
        let initialBoard = VerySimpleRules.createBoard()
        XCTAssert(VerySimpleRules.checkBoard(initialBoard) == .noError)
    }
 
    ///Test de validation du tableau valide et invalide
    func testCheckBoard() {
        let validBoard = VerySimpleRules.createBoard()
        XCTAssert(VerySimpleRules.checkBoard(validBoard) == .noError)

        var invalidBoard = VerySimpleRules.createBoard()
        let piece = Piece(owner: .player1, animal: .cat)
        _ = invalidBoard.insertPiece(piece: piece, atRow: 0, andColumn: 0)
        XCTAssert(VerySimpleRules.checkBoard(invalidBoard) != .noError)
    }
    
    ///Test de récupération du prochain joueur
    func testGetNextPlayer() {
        let rules = VerySimpleRules(occurrences: [:], historic: [])
        XCTAssert(rules.getNextPlayer() == .player1)
    }
    
    ///Test de récupération des déplacements de pièce valides pour la première version de  la méthode
    func testGetMovesV1() {
        let rules = VerySimpleRules(occurrences: [:], historic: [])
        let board = VerySimpleRules.createBoard()
        let validMoves = rules.getMoves(for: board, of: .player1)
        let expectedValidMoves = [Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 1, columnDestination: 1), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 0, columnDestination: 0), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 0, columnDestination: 2), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 3, rowDestination: 1, columnDestination: 3), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 3, rowDestination: 0, columnDestination: 2), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 3, rowDestination: 0, columnDestination: 4), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 0, rowDestination: 0, columnDestination: 0), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 0, rowDestination: 2, columnDestination: 0), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 0, rowDestination: 1, columnDestination: 1), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 2, rowDestination: 0, columnDestination: 2), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 2, rowDestination: 2, columnDestination: 2), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 2, rowDestination: 1, columnDestination: 1), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 2, rowDestination: 1, columnDestination: 3), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 4, rowDestination: 0, columnDestination: 4), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 4, rowDestination: 2, columnDestination: 4), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 4, rowDestination: 1, columnDestination: 3)]
        XCTAssert(validMoves == expectedValidMoves)
    }
    
    ///Test de récupération des déplacements de pièce valides pour la deuxième version de  la méthode
    func testGetMovesV2() {
        let rules = VerySimpleRules(occurrences: [:], historic: [])
        let board = VerySimpleRules.createBoard()
        let validMoves = rules.getMoves(for: board, of: .player1, fromRow: 0, fromColumn: 1)
        let expectedValidMoves = [Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 0, columnDestination: 0), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 0, columnDestination: 2), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 1, columnDestination: 1)]
        XCTAssert(validMoves == expectedValidMoves)
    }
    
    ///Test de la fin d'une partie
    func testIsGameOver() {
        let rules = VerySimpleRules(occurrences: [:], historic: [])
        let board = VerySimpleRules.createBoard()
        XCTAssert(rules.isGameOver(on: board, lastMoveRow: 0, lastMoveColumn: 1) == (false, .notFinished))
    }
    
    ///Test de l'historisation d'un coup
    func testPlayedMove() {
        var rules = VerySimpleRules(occurrences: [:], historic: [])
        let initialBoard = VerySimpleRules.createBoard()
        let move = Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 1, columnDestination: 1)
        let lionJ1: Piece = Piece(owner: .player1, animal: .lion)
        var resultingBoard = initialBoard
        _ = resultingBoard.removePiece(atRow: 0, andColumn: 1)
        _ = resultingBoard.insertPiece(piece: lionJ1, atRow: 1, andColumn: 1)

        rules.playedMove(move, on: initialBoard, resultingBoard: resultingBoard)

        XCTAssertEqual(rules.historic, [move])
        XCTAssertEqual(rules.occurrences[resultingBoard], 1)
        XCTAssertEqual(rules.getNextPlayer(), .player2)
    }
    
    ///TESTS HASHABLE - EQUALITY
    
    ///Test de la méthode == de Piece
    func testEqualityPiece() {
        let piece1 = Piece(owner: .player1, animal: .lion)
        let piece2 = Piece(owner: .player1, animal: .lion)
        let piece3 = Piece(owner: .player2, animal: .lion)
        
        XCTAssertEqual(piece1, piece2)
        XCTAssertNotEqual(piece1, piece3)
    }
    
    ///Test de la méthode hash de Piece
    func testHashingPiece() {
        let piece1 = Piece(owner: .player1, animal: .lion)
        let piece2 = Piece(owner: .player1, animal: .lion)
        let piece3 = Piece(owner: .player2, animal: .lion)
        
        XCTAssertEqual(piece1.hashValue, piece2.hashValue)
        XCTAssertNotEqual(piece1.hashValue, piece3.hashValue)
    }
    
    ///Test de la méthode == de Cell
    func testEqualityCell() {
        let piece1 = Piece(owner: .player1, animal: .lion)
        let piece2 = Piece(owner: .player1, animal: .lion)
        let cell1 = Cell(cellType: .jungle, initialOwner: .player1, piece: piece1)
        let cell2 = Cell(cellType: .jungle, initialOwner: .player1, piece: piece2)
        let cell3 = Cell(cellType: .water, initialOwner: .player2, piece: nil)
        
        XCTAssertEqual(cell1, cell2)
        XCTAssertNotEqual(cell1, cell3)
    }
    
    ///Test de la méthode hash de Cell
    func testHashingCell() {
        let piece1 = Piece(owner: .player1, animal: .lion)
        let piece2 = Piece(owner: .player1, animal: .lion)
        let cell1 = Cell(cellType: .jungle, initialOwner: .player1, piece: piece1)
        let cell2 = Cell(cellType: .jungle, initialOwner: .player1, piece: piece2)
        let cell3 = Cell(cellType: .water, initialOwner: .player2, piece: nil)
        
        XCTAssertEqual(cell1.hashValue, cell2.hashValue)
        XCTAssertNotEqual(cell1.hashValue, cell3.hashValue)
    }
}
