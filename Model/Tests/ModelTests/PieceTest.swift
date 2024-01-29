import XCTest
import Model

final class PieceTest: XCTestCase {

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

}
