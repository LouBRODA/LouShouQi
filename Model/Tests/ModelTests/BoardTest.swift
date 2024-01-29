import XCTest
import Model

final class BoardTest: XCTestCase {

    var board: Board!
    
    override func setUpWithError() throws {
        let piece = Piece(owner: .player1, animal: .cat)
        let cell = Cell(cellType: .jungle, initialOwner: .player1, piece: piece)
        let cell2 = Cell(cellType: .jungle, initialOwner: .player1)
        let validGrid = [[cell, cell], [cell, cell2]]
        board = Board(withGrid: validGrid)
    }

    override func tearDownWithError() throws {
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
    
    ///Test de performance pour l'initialiseur de Board
    func testInitBoardPerformance() throws {
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
    
}
