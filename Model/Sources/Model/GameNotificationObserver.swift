import Foundation

/// Protocole définissant les différentes notifications à implémenter
public protocol GameNotificationObserver {
    func gameStarted() -> Void
    func playerNotified(player: Player) -> Void
    func movePlayed(move: Move) -> Void
    func moveNotValidated(move: Move?) -> Void
    func gameOver(winningResult: (Bool, Result), player: Player) -> Void
    func boardChanged(board: Board) -> Void
    func gameSaved(game: Game) -> Void
}
