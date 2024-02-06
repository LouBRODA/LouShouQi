import XCTest
import Model

final class HumanPlayerTest: XCTestCase {

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

    // Test d'initialisation de la classe HumanPlayer
    func testHumanPlayerInitialization() {
        let humanPlayer = HumanPlayer(withName: "Lou", andId: .player2, andInputMethod: { _ in Move(owner: .player2, rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 1) })
        
        XCTAssertNotNil(humanPlayer, "ERR : La création du HumanPlayer a échoué !")
        XCTAssertEqual(humanPlayer?.name, "Lou", "ERR : Le nom du HumanPlayer est incorrect ")
        XCTAssertEqual(humanPlayer?.id, .player2, "ERR : L'identifiant du HumanPlayer est incorrect !")
    }
    
    // Test de la méthode chooseMove avec une instance HumanPlayer
    func testHumanPlayerChooseMove(){
        let humanPlayer = HumanPlayer(withName: "Lou", andId: .player2, andInputMethod: { _ in Move(owner: .player2, rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 1) })
        let move = humanPlayer?.chooseMove(in: board, with: rules)
        
        XCTAssertNotNil(move, "ERR : Move est nil !")
        XCTAssertEqual(move, Move(owner: .player2, rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 1))
    }

}
