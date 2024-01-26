import Foundation

/// Structure définissant une case du plateau de jeu.
public struct Cell: CustomStringConvertible, Hashable {
    
    // Description textuelle de la cellule.
    public var description: String {
        return " \(piece?.description ?? "ø") on \(cellType), \(initialOwner.description)"
    }
    
    // Type de la cellule.
    public let cellType: CellType
    
    // Propriétaire initial de la cellule.
    public let initialOwner: Owner
    
    // Pièce actuellement présente sur la cellule (peut être nulle).
    public var piece: Piece?
    
    /// Initialiseur de la cellule.
    ///
    /// - Parameters:
    ///   - cellType: Le type de la cellule.
    ///   - initialOwner: Le propriétaire initial de la cellule (par défaut, pas de propriétaire).
    ///   - piece: La pièce initialement présente sur la cellule (par défaut, pas de pièce).
    public init(cellType: CellType, initialOwner: Owner = .noOne, piece: Piece? = nil) {
        self.cellType = cellType
        self.initialOwner = initialOwner
        self.piece = piece
    }
    
    // Méthode d'égalité pour le protocole Equatable.
    public static func == (left: Cell, right: Cell) -> Bool {
        return left.cellType == right.cellType &&
            left.initialOwner == right.initialOwner &&
            left.piece == right.piece
    }
    
    // Méthode de hachage pour le protocole Hashable.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(cellType)
        hasher.combine(initialOwner)
        hasher.combine(piece)
    }
}
