import XCTest
import Model

final class GameTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testGameStarts() {
        let player1 = RandomPlayer(withName: "PlayerTest", andId: .player1)!
        let player2 = RandomPlayer(withName: "PlayerTest", andId: .player2)!
        var game = Game(withRules: VerySimpleRules(), andPlayer1: player1, andPlayer2: player2)
        
        let observer = MockGameNotificationObserver()
        game.addObserver(observer)
        
        do {
            try game.start()
        } catch {
            XCTFail("Erreur dans la méthode start de Game !")
        }
        
        XCTAssertTrue(observer.gameStartedCalled)
        XCTAssertTrue(observer.playerNotifiedCalled)
        XCTAssertTrue(observer.movePlayedCalled)
        XCTAssertTrue(observer.gameOverCalled)
        XCTAssertTrue(observer.boardChangedCalled)
    }
}

class MockGameNotificationObserver: GameNotificationObserver {
    var gameStartedCalled = false
    var playerNotifiedCalled = false
    var movePlayedCalled = false
    var moveNotValidatedCalled = false
    var gameOverCalled = false
    var boardChangedCalled = false
    
    func gameStarted() {
        gameStartedCalled = true
    }
    
    func playerNotified(player: Player) {
        playerNotifiedCalled = true
    }
    
    func movePlayed(move: Move) {
        movePlayedCalled = true
    }
    
    func moveNotValidated(move: Move?) {
        moveNotValidatedCalled = true
    }
    
    func gameOver(winningResult: (Bool, Result), player: Player) {
        gameOverCalled = true
    }
    
    func boardChanged(board: Board) {
        boardChangedCalled = true
    }

}
