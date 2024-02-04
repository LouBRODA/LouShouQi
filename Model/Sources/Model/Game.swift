import Foundation

public struct Game {
    
    public var rules: any Rules
    public var board: Board
    public let player1: Player
    public let player2: Player
    
    /// Initialiseur d'une partie
    public init(withRules rules: any Rules, andPlayer1 player1: Player, andPlayer2 player2: Player) {
        self.rules = rules
        self.board = rules.createBoard()
        self.player1 = player1
        self.player2 = player2
    }
    
    public mutating func start() throws{
        var selectedPiece: Piece
        var winningReason: (Bool, Result) = (false, .notFinished)
        
        while(winningReason == (false, .notFinished)){
            
            let nextOwner = rules.getNextPlayer()
            let nextPlayer: Player
            var preMovePlayerBoard = board
            
            if (nextOwner == player1.id) {
                nextPlayer = player1
            }
            else {
                nextPlayer = player2
            }
            
            //TMP
            //print(nextPlayer)
            
            var _ = rules.getMoves(for: board, of: nextPlayer.id)
            let selectMove = nextPlayer.chooseMove(in: board, with: rules)
            
            selectedPiece = board.grid[selectMove!.rowOrigin][selectMove!.columnOrigin].piece!
            _ = board.removePiece(atRow: selectMove!.rowOrigin, andColumn: selectMove!.columnOrigin)
            if let _ = board.grid[selectMove!.rowDestination][selectMove!.columnDestination].piece {
                _ = board.removePiece(atRow: selectMove!.rowDestination, andColumn: selectMove!.columnDestination)
            }
            _ = board.insertPiece(piece: selectedPiece, atRow: selectMove!.rowDestination, andColumn: selectMove!.columnDestination)
            
            //TMP
            //print(playerBoard)
            
            rules.playedMove(selectMove!, on: preMovePlayerBoard, resultingBoard: board)
            
            winningReason = try rules.isGameOver(on: board, lastMoveRow: selectMove!.rowDestination, lastMoveColumn: selectMove!.columnDestination)
            
            //TMP
            //print(winningReason)
        }
    }
}
