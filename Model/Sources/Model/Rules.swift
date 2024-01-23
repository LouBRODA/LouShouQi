import Foundation

public protocol Rules{
    var occurrences: [Board:Int] { get }
    var historic: [Move] { get }
    
    static func createBoard() -> Board
    static func checkBoard(_ board: Board) -> InvalidBoardError
    func getNextPlayer() -> Owner
    func getMoves(for board: Board, of player: Owner) -> [Move]
    func getMoves(for board: Board, of player: Owner, fromRow row: Int, fromColumn column: Int) -> [Move]
    func isMoveValid(on board: Board, fromRow originRow: Int, fromColumn originColumn: Int, toRow destinationRow: Int, toColumn destinationColumn: Int) -> Bool
    func isMoveValid(on board: Board, move: Move) -> Bool
    func isGameOver(on board: Board, lastMoveRow: Int, lastMoveColumn: Int) -> (Bool, Result)
    func playedMove(_ move: Move, on currentBoard: Board, resultingBoard: Board)
}
