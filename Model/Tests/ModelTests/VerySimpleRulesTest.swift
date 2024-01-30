import XCTest
import Model

final class VerySimpleRulesTest: XCTestCase {

    var rules = VerySimpleRules()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    ///Test de création et vérification du plateau
    func testCreateBoard() throws {
        let initialBoard = VerySimpleRules.createBoard()
        XCTAssert(try VerySimpleRules.checkBoard(initialBoard) == true)
    }
 
    ///Test de validation du tableau valide et invalide
    func testCheckBoard() throws {
        let validBoard = VerySimpleRules.createBoard()
        XCTAssert(try VerySimpleRules.checkBoard(validBoard) == true)

        var invalidBoard = VerySimpleRules.createBoard()
        let piece = Piece(owner: .player1, animal: .cat)
        _ = invalidBoard.insertPiece(piece: piece, atRow: 0, andColumn: 0)
        XCTAssertThrowsError(try VerySimpleRules.checkBoard(invalidBoard))
    }
    
    ///Test de récupération du prochain joueur
    func testGetNextPlayer() {
        XCTAssert(rules.getNextPlayer() == .player1)
    }
    
    ///Test de récupération des déplacements de pièce valides pour la première version de  la méthode
    func testGetMovesV1() throws {
        let board = VerySimpleRules.createBoard()
        let validMoves = rules.getMoves(for: board, of: .player1)
        let expectedValidMoves = [Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 1, columnDestination: 1), 
            Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 0, columnDestination: 0), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 3, rowDestination: 1, columnDestination: 3), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 3, rowDestination: 0, columnDestination: 4), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 0, rowDestination: 0, columnDestination: 0), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 0, rowDestination: 2, columnDestination: 0), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 0, rowDestination: 1, columnDestination: 1), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 2, rowDestination: 2, columnDestination: 2), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 2, rowDestination: 1, columnDestination: 1), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 2, rowDestination: 1, columnDestination: 3), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 4, rowDestination: 0, columnDestination: 4), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 4, rowDestination: 2, columnDestination: 4), Model.Move(owner: .player1, rowOrigin: 1, columnOrigin: 4, rowDestination: 1, columnDestination: 3)]
        
        let sortedValidMoves = validMoves.sorted(by: { $0.description < $1.description })
        let sortedExpectedValidMoves = expectedValidMoves.sorted(by: { $0.description < $1.description })
        XCTAssert(sortedValidMoves == sortedExpectedValidMoves, "ERR : Les tableaux ne sont pas égaux !")
    }

    ///Test de récupération des déplacements de pièce valides pour la deuxième version de  la méthode
    func testGetMovesV2() throws {
        let board = VerySimpleRules.createBoard()
        let validMoves = rules.getMoves(for: board, of: .player1, fromRow: 0, fromColumn: 1)
        let expectedValidMoves = [Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 0, columnDestination: 0), Model.Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 1, columnDestination: 1)]
        XCTAssert(validMoves == expectedValidMoves)
    }

    ///Test de la fin d'une partie
    func testIsGameOver() throws {
        let board = VerySimpleRules.createBoard()
        XCTAssert(try rules.isGameOver(on: board, lastMoveRow: 0, lastMoveColumn: 1) == (false, .notFinished))
    }
    
    ///Test de l'historisation d'un coup
    func testPlayedMove() {
        let initialBoard = VerySimpleRules.createBoard()
        let move = Move(owner: .player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 1, columnDestination: 1)
        let lionJ1: Piece = Piece(owner: .player1, animal: .lion)
        var resultingBoard = initialBoard
        _ = resultingBoard.removePiece(atRow: 0, andColumn: 1)
        _ = resultingBoard.insertPiece(piece: lionJ1, atRow: 1, andColumn: 1)

        rules.playedMove(move, on: initialBoard, resultingBoard: resultingBoard)

        XCTAssertEqual(rules.historic, [move])
        XCTAssertEqual(rules.occurrences[resultingBoard], 1)
        XCTAssertEqual(rules.getNextPlayer(), .player2)
    }
    
}
