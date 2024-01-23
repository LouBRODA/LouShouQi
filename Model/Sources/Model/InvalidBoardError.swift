import Foundation

public enum InvalidBoardError: Error, Hashable{
    case badDimensions(row: Int, column: Int)
    case badCellType(cellType: CellType, row: Int, column: Int)
    case multipleOccurrencesOfSamePiece(piece: Piece)
    case pieceWithNoOwner(piece: Piece)
    case pieceNotAllowedOnThisCell(piece: Piece, onCell: Cell)
    case numberOfPiece(piecesPlayer1: Int, piecesPlayer2: Int)
    case animalNotAuthorized
    case noError
}
