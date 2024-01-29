import XCTest
import Model 

final class RandomPlayerTest: XCTestCase {

    var board: Board!
    var rules = VerySimpleRules()
    let emptyGrid: [[Cell]] = [[]]
    
    override func setUpWithError() throws {
        let piece = Piece(owner: .player1, animal: .cat)
        let cell = Cell(cellType: .jungle, initialOwner: .player1, piece: piece)
        let cell2 = Cell(cellType: .jungle, initialOwner: .player1)
        let validGrid = [[cell, cell], [cell, cell2]]
        board = Board(withGrid: validGrid)
    }

    override func tearDownWithError() throws {
    }

    // Test d'initialisation de la classe RandomPlayer
    func testRandomPlayerInitialization() {
        let randomPlayer = RandomPlayer(withName: "Lou", andId: .player1)
        XCTAssertNotNil(randomPlayer, "ERR : La création du RandomPlayer a échoué !")
        XCTAssertEqual(randomPlayer?.name, "Lou", "ERR : Le nom du RandomPlayer est incorrect !")
        XCTAssertEqual(randomPlayer?.id, .player1, "ERR : L'identifiant du RandomPlayer est incorrect !")
    }

    // Test de la méthode chooseMove avec une instance de RandomPlayer
    func testChooseMove() {
        let randomPlayer = RandomPlayer(withName: "LouBis", andId: .player2)

        XCTAssertNoThrow {
            let move = try randomPlayer?.chooseMove(in: self.board, with: self.rules)
            XCTAssertNotNil(move, "ERR : La méthode chooseMove ne doit pas renvoyer nil !")
        }
    }

    // Test de la méthode chooseMove avec une instance de RandomPlayer avec un board vide
    func testChooseMoveWithEmptyBoard() {
        let randomPlayer = RandomPlayer(withName: "Lou", andId: .player1)

        XCTAssertNoThrow {
            let emptyBoard = Board(withGrid: self.emptyGrid)
            let move = try randomPlayer?.chooseMove(in: emptyBoard!, with: self.rules)
            XCTAssertNil(move, "La méthode chooseMove doit renvoyer nil avec un plateau vide.")
        }
    }
    
}
