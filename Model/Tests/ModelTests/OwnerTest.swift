import XCTest
import Model

final class OwnerTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
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
}
