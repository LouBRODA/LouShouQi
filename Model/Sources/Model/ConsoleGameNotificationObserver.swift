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
        print("Player \(player.id) - \(player.name), it's your turn!")
        print("**************************************")
    }
    
    public func movePlayed(move: Move) {
        print("**************************************")
        print("Move selected by player \(move.owner)")
        print("\(move)")
        print("**************************************")
    }
    
    public func moveNotValidated(move: Move?) {
        print("**************************************")
        print("**************************************")
        print("**************************************")
    }
    
    public func gameOver(winningResult: (Bool, Result), player: Player) {
        print("**************************************")
        print("Game Over!!!")
        print("and the winner is... \(player.description)!")
        print("\(winningResult.1)")
        print("**************************************")
    }
    
    public func boardChanged(board: Board) {
        print("**************************************")
        print("Board modified :")
        print("\(board)")
        print("**************************************")
    }

}
