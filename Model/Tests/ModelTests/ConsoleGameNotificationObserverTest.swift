import XCTest
import Model

final class ConsoleGameNotificationObserverTest: XCTestCase {
/*
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testGameStarted() {
        // Given
        let observer = ConsoleGameNotificationObserver()
        let expectedOutput = """
        **************************************
                ==>> GAME STARTS! <<==
        **************************************
        """
        
        // When
        captureOutput {
            observer.gameStarted()
        }
        
        // Then
        XCTAssertEqual(capturedOutput, expectedOutput)
    }
    
    func testPlayerNotified() {
        // Given
        let observer = ConsoleGameNotificationObserver()
        let player = RandomPlayer(withName: "TestPlayer", andId: .player1)
        let expectedOutput = """
        **************************************
        Player \(player!.id) - \(player!.name), it's your turn!
        **************************************
        """
        
        // When
        captureOutput {
            observer.playerNotified(player: player!)
        }
        
        // Then
        XCTAssertEqual(capturedOutput, expectedOutput)
    }
    
    func testMovePlayed() {
        // Given
        let observer = ConsoleGameNotificationObserver()
        let move = Move(owner: .player1, rowOrigin: 0, columnOrigin: 0, rowDestination: 1, columnDestination: 1)
        let expectedOutput = """
        **************************************
        Move selected by player \(move.owner)
        \(move)
        **************************************
        """
        
        // When
        captureOutput {
            observer.movePlayed(move: move)
        }
        
        // Then
        XCTAssertEqual(capturedOutput, expectedOutput)
    }
    
    func testMoveNotValidated() {
        // Given
        let observer = ConsoleGameNotificationObserver()
        let expectedOutput = """
        **************************************
        Move invalid, please try again !
        **************************************
        """
        
        // When
        captureOutput {
            observer.moveNotValidated(move: nil)
        }
        
        // Then
        XCTAssertEqual(capturedOutput, expectedOutput)
    }
    
    func testGameOver() {
        // Given
        let observer = ConsoleGameNotificationObserver()
        let player = RandomPlayer(withName: "TestPlayer", andId: .player1)
        let winningResult: (Bool, Result) = (true, .winner(owner: .player1, .noMorePieces))
        let expectedOutput = """
        **************************************
        Game Over!!!
        and the winner is... \(player!.description)!
        \(winningResult.1)
        **************************************
        """
        
        // When
        captureOutput {
            observer.gameOver(winningResult: winningResult, player: player!)
        }
        
        // Then
        XCTAssertEqual(capturedOutput, expectedOutput)
    }
    
    func testBoardChanged() {
        // Given
        let observer = ConsoleGameNotificationObserver()
        let board = VerySimpleRules.createBoard()
        let expectedOutput = """
        **************************************
        Board modified :
        \(board)
        **************************************
        """
        
        // When
        captureOutput {
            observer.boardChanged(board: board)
        }
        
        // Then
        XCTAssertEqual(capturedOutput, expectedOutput)
    }

    var capturedOutput = ""
    
    private func captureOutput(closure: () -> Void) {
        let originalOutput = ConsoleGameNotificationObserver.outputFunction
        ConsoleGameNotificationObserver.outputFunction = { print($0) }
        let outputStream = OutputStream.toMemory()
        outputStream.open()
        defer {
            outputStream.close()
            ConsoleGameNotificationObserver.outputFunction = originalOutput
        }
        capturedOutput = ""
        ConsoleGameNotificationObserver.outputStream = outputStream
        closure()
        capturedOutput = String(data: outputStream.property(forKey: .dataWrittenToMemoryStreamKey) as! Data, encoding: .utf8)!
    }
*/
}
