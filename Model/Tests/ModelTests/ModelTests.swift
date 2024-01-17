import XCTest
import Model

final class ModelTests: XCTestCase {

    var board: Board!

    ///Fonction lancée avant chaque fonction de test
    override func setUpWithError() throws {
        let piece = Piece(owner: .player1, animal: .cat)
        let cell = Cell(cellType: .jungle, initialOwner: .player1, piece: piece)
        let cell2 = Cell(cellType: .jungle, initialOwner: .player1)
        let validGrid = [[cell, cell], [cell, cell2]]
        board = Board(withGrid: validGrid)
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

}
