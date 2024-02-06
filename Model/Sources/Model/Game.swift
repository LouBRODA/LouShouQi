import Foundation

public struct Game {
    
    public var rules: any Rules
    public var board: Board
    public let player1: Player
    public let player2: Player
    
    public var observers: [GameNotificationObserver] = []
    
    /// Initialiseur d'une partie
    public init(withRules rules: any Rules, andPlayer1 player1: Player, andPlayer2 player2: Player) {
        self.rules = rules
        self.board = type(of: rules).createBoard()
        self.player1 = player1
        self.player2 = player2
    }
    
    //Méthodes de gestion des observers
    mutating func addObserver(_ observer: GameNotificationObserver){
        observers.append(observer)
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
    
    public func notifyMoveNotValidated(move: Move) {
        observers.forEach { $0.moveNotValidated(move: move) }
    }

    public func notifyGameOver(winningResult: (Bool, Result), player: Player) {
        observers.forEach { $0.gameOver(winningResult: winningResult, player: player) }
    }

    public func notifyBoardChanged(board: Board) {
        observers.forEach { $0.boardChanged(board: board) }
    }
    
    
    public mutating func start() throws{
        var selectedPiece: Piece
        var winningReason: (Bool, Result) = (false, .notFinished)
        
        notifyGameStarted()
        
        while(winningReason == (false, .notFinished)){
            
            notifyBoardChanged(board: board)
            
            let nextOwner = rules.getNextPlayer()
            let nextPlayer: Player
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
                    do {
                        let isValidMove = try rules.isMoveValid(on: board, move: move)
                        if !isValidMove {
                            notifyMoveNotValidated(move: move)
                        }
                    } catch {
                        
                    }
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
                
                notifyGameOver(winningResult: winningReason, player: nextPlayer)
            }
        }
    }
}
