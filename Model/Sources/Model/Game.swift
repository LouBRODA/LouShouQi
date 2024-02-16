import Foundation

public struct Game {
    
    public var rules: any Rules
    public var board: Board
    public let player1: Player
    public let player2: Player
    
    public var observers: [GameNotificationObserver] = []
    
    public var gameSavedHandler: ((Game) -> Void)?
    
    /// Initialiseur d'une partie
    public init(withRules rules: any Rules, andPlayer1 player1: Player, andPlayer2 player2: Player) {
        self.rules = rules
        self.board = type(of: rules).createBoard()
        self.player1 = player1
        self.player2 = player2
    }
    
    //Méthodes de gestion des observers
    public mutating func addObserver(_ observer: GameNotificationObserver, gameSavedHandler: ((Game) -> Void)? = nil){
        observers.append(observer)
        self.gameSavedHandler = gameSavedHandler
    }
    
    //mutating func removeObserver(_ observer: GameNotificationObserver)
    
    
    // Méthodes de notification
    public func notifyGameStarted() {
        observers.forEach { $0.gameStarted() }
    }

    public func notifyPlayerNotified(player: Player) {
        observers.forEach { $0.playerNotified(player: player) }
    }

    public func notifyMovePlayed(move: Move) {
        observers.forEach { $0.movePlayed(move: move) }
    }
    
    public func notifyMoveNotValidated(move: Move?) {
        observers.forEach { $0.moveNotValidated(move: move) }
    }

    public func notifyGameOver(winningResult: (Bool, Result), player: Player) {
        observers.forEach { $0.gameOver(winningResult: winningResult, player: player) }
    }

    public func notifyBoardChanged(board: Board) {
        observers.forEach { $0.boardChanged(board: board) }
    }
    
    public func notifyGameSaved(game: Game) {
        observers.forEach { $0.gameSaved(game: game) }
    }
    
    
    public mutating func start() throws{
        var selectedPiece: Piece
        var winningReason: (Bool, Result) = (false, .notFinished)
        var nextPlayer: Player
        nextPlayer = player1
        
        notifyGameStarted()
        
        while(winningReason == (false, .notFinished)){
            
            notifyBoardChanged(board: board)
            
            let nextOwner = rules.getNextPlayer()
            let preMovePlayerBoard = board
            
            if (nextOwner == player1.id) {
                nextPlayer = player1
            }
            else {
                nextPlayer = player2
            }
            
            notifyPlayerNotified(player: nextPlayer)
                        
            var selectMove: Move?
            repeat {
                selectMove = nextPlayer.chooseMove(in: board, with: rules)
                if let move = selectMove {
                    let possibleMoves = rules.getMoves(for: board, of: nextPlayer.id)
                    if !possibleMoves.contains(move){
                        selectMove = nil
                        notifyMoveNotValidated(move: selectMove)
                    }
                }
                else {
                    notifyMoveNotValidated(move: selectMove)
                }
            } while selectMove == nil
                        
            if let move = selectMove {
                selectedPiece = board.grid[move.rowOrigin][move.columnOrigin].piece!
                _ = board.removePiece(atRow: move.rowOrigin, andColumn: move.columnOrigin)
                if let _ = board.grid[move.rowDestination][move.columnDestination].piece {
                    _ = board.removePiece(atRow: move.rowDestination, andColumn: move.columnDestination)
                }
                _ = board.insertPiece(piece: selectedPiece, atRow: move.rowDestination, andColumn: move.columnDestination)
                
                notifyMovePlayed(move: move)
                
                rules.playedMove(move, on: preMovePlayerBoard, resultingBoard: board)
                
                winningReason = try rules.isGameOver(on: board, lastMoveRow: move.rowDestination, lastMoveColumn: move.columnDestination)
            }
            
            notifyGameSaved(game: self)
        }
        notifyGameOver(winningResult: winningReason, player: nextPlayer)
        notifyBoardChanged(board: board)
    }
}
