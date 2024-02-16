import Foundation

// Définition d'une structure qui agit comme un observateur des notifications de jeu
public struct ConsoleGameNotificationObserver: GameNotificationObserver {
    
    /// Initialiseur public de la structure.
    public init() {}
    
    /// Fonction appelée lorsque le jeu démarre.
    public func gameStarted() {
        print("**************************************")
        print("        ==>> GAME STARTS! <<==        ")
        print("**************************************")
    }
    
    /// Fonction appelée lorsqu'un joueur doit jouer.
    ///
    /// - Parameter player: Le joueur qui doit jouer.
    public func playerNotified(player: Player) {
        print("**************************************")
        print("Player \(player.id) - \(player.name), it's your turn!")
        print("**************************************")
    }
    
    /// Fonction appelée lorsqu'un coup est joué.
    ///
    /// - Parameter move: Le coup joué.
    public func movePlayed(move: Move) {
        print("**************************************")
        print("Move selected by player \(move.owner)")
        print("\(move)")
        print("**************************************")
    }
    
    /// Fonction appelée lorsque le coup joué n'est pas valide.
    ///
    /// - Parameter move: Le coup non valide.
    public func moveNotValidated(move: Move?) {
        print("**************************************")
        print("Move invalid, please try again !")
        print("**************************************")
    }
    
    /// Fonction appelée lorsque le jeu est terminé.
    ///
    /// - Parameters:
    ///   - winningResult: Le résultat du jeu.
    ///   - player: Le joueur gagnant.
    public func gameOver(winningResult: (Bool, Result), player: Player) {
        print("**************************************")
        print("Game Over!!!")
        print("and the winner is... \(player.description)!")
        print("\(winningResult.1)")
        print("**************************************")
    }
    
    /// Fonction appelée lorsque le plateau est modifié.
    ///
    /// - Parameter board: Le plateau modifié.
    public func boardChanged(board: Board) {
        print("**************************************")
        print("Board modified :")
        print("\(board)")
        print("**************************************")
    }

    public func gameSaved(game: Game) {
        game.gameSavedHandler?(game)
    }
    
}
