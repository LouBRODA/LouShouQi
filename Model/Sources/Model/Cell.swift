import Foundation

///Structure définissant une case du plateau de jeu
public struct Cell : CustomStringConvertible{
    
    ///Properties
    public var description: String{
        return " \(piece?.description ?? "ø") on \(cellType), \(initialOwner.rawValue)"
    }
    
    public let cellType: CellType
    public let initialOwner: Owner
    public let piece : Piece?
    
    public init(cellType: CellType, initialOwner: Owner = .noOne, piece: Piece? = nil) {
        self.cellType = cellType
        self.initialOwner = initialOwner
        self.piece = piece
    }
}
