import XCTest
import Model

final class BoardResultTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
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

}
