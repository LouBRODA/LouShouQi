import XCTest
import Model

final class PlayerTest: XCTestCase {

    var board: Board!
    var rules = VerySimpleRules()
    
    override func setUpWithError() throws {
        let piece = Piece(owner: .player1, animal: .cat)
        let cell = Cell(cellType: .jungle, initialOwner: .player1, piece: piece)
        let cell2 = Cell(cellType: .jungle, initialOwner: .player1)
        let validGrid = [[cell, cell], [cell, cell2]]
        board = Board(withGrid: validGrid)
    }

    override func tearDownWithError() throws {
    }

    // Test d'initialisation de la classe Player
    func testPlayerInitialization() {
        let player = Player(withName: "Lou", andId: .player1)
        XCTAssertNotNil(player, "ERR : La création du joueur a échoué !")
        XCTAssertEqual(player?.name, "Lou", "ERR : Le nom du joueur est incorrect !")
        XCTAssertEqual(player?.id, .player1, "ERR : L'identifiant du joueur est incorrect !")
    }

    // Test de la méthode chooseMove avec une instance Player
    func testChooseMove() {
        let player = Player(withName: "LouBis", andId: .player2)
        
        let move = player?.chooseMove(in: self.board, with: self.rules)
        XCTAssertNil(move, "La méthode chooseMove doit renvoyer nil.")
    }
    
}
