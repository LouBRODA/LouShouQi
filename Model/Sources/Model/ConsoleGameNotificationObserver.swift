import Foundation

public struct ConsoleGameNotificationObserver: GameNotificationObserver {
    
    public init() {}
    
    public func gameStarted() {
        print("**************************************")
        print("        ==>> GAME STARTS! <<==        ")
        print("**************************************")
    }
    
    public func playerNotified(player: Player) {
        print("**************************************")
    }
    
    public func movePlayed(move: Move) {
        print("**************************************")
    }
    
    public func moveNotValidated(move: Move?) {
        print("**************************************")
    }
    
    public func gameOver(winningResult: (Bool, Result), player: Player) {
        print("**************************************")
    }
    
    public func boardChanged(board: Board) {
        print("**************************************")
    }

}
