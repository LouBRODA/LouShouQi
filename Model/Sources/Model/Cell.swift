import Foundation

///Structure définissant une case du plateau de jeu
public struct Cell : CustomStringConvertible, Hashable{
    ///Properties
    public var description: String{
        return " \(piece?.description ?? "ø") on \(cellType), \(initialOwner.description)"
    }
    
    public let cellType: CellType
    public let initialOwner: Owner
    public var piece : Piece?
    
    public init(cellType: CellType, initialOwner: Owner = .noOne, piece: Piece? = nil) {
        self.cellType = cellType
        self.initialOwner = initialOwner
        self.piece = piece
    }
    
    public static func == (left: Cell, right: Cell) -> Bool {
        return left.cellType == right.cellType &&
        left.initialOwner == right.initialOwner &&
        left.piece == right.piece
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(cellType)
        hasher.combine(initialOwner)
        hasher.combine(piece)
    }
}
