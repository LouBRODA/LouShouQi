import XCTest
import Model

final class CellTest: XCTestCase {

    ///Fonction lancée avant chaque fonction de test
    override func setUpWithError() throws {
    }

    ///Fonction lancée après chaque fonction de test
    override func tearDownWithError() throws {
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
