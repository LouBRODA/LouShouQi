import XCTest
import Model

final class HumanPlayerTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // Test d'initialisation de la classe HumanPlayer
    func testHumanPlayerInitialization() {
        let humanPlayer = HumanPlayer(withName: "Lou", andId: .player2, andInputMethod: { Move(owner: .player1, rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 1) })
        XCTAssertNotNil(humanPlayer, "ERR : La création du HumanPlayer a échoué !")
        XCTAssertEqual(humanPlayer?.name, "Lou", "ERR : Le nom du HumanPlayer est incorrect ")
        XCTAssertEqual(humanPlayer?.id, .player2, "ERR : L'identifiant du HumanPlayer est incorrect !")
    }
    
}
