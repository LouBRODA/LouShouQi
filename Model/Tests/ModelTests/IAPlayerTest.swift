import XCTest
import Model

final class IAPlayerTest: XCTestCase {

    var board: Board!
    var rules = VerySimpleRules()
    let emptyGrid: [[Cell]] = [[]]
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // Test de l'initialisation réussie de la classe IAPlayer
    func testInitializationIAPlayerWithValidParameters() {
        let name = "IA1"
        let id = Owner.player1

        let iaPlayer = IAPlayer(withName: name, andId: id)

        XCTAssertNotNil(iaPlayer, "ERR : L'initialisation d'IAPlayer a échoué avec des paramètres valides !")
        XCTAssertEqual(iaPlayer?.name, name, "ERR : Le nom de correspond pas au nom fourni !")
        XCTAssertEqual(iaPlayer?.id, id, "ERR : L'id ne correspond pas à l'id fourni !")
    }

    // Test de l'initialisation échouée de la classe IAPlayer avec un identifiant incorrect
    func testInitializationIAPlayerWithInvalidId() {
        let name = "IA2"
        let id = Owner.noOne

        let iaPlayer = IAPlayer(withName: name, andId: id)

        XCTAssertNil(iaPlayer, "ERR : L'initialisation devrait échouer avec un id invalide !")
    }

    // Test de la méthode chooseMove avec une instance de IAPlayer avec un board vide
    func testChooseMoveWithEmptyBoard() {
        let iaPlayer = IAPlayer(withName: "IA3", andId: .player1)

        let emptyBoard = Board(withGrid: self.emptyGrid)
        let move = iaPlayer?.chooseMove(in: emptyBoard!, with: self.rules)
        XCTAssertNil(move, "ERR : La méthode chooseMove doit renvoyer nil avec un plateau vide !")
    }
    
}
