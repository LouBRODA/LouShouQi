import Foundation

/// Structure définissant une pièce du jeu.
public struct Piece: CustomStringConvertible, Hashable {
        
    // Description textuelle de la pièce.
    public var description: String { "[\(owner):\(animal)]" }
    
    // Le propriétaire de la pièce.
    public let owner: Owner
    
    // L'animal associé à la pièce.
    public let animal: Animal
    
    /// Initialiseur de la structure `Piece`.
    ///
    /// - Parameters:
    ///   - owner: Le propriétaire de la pièce.
    ///   - animal: L'animal associé à la pièce.
    public init(owner: Owner, animal: Animal) {
        self.owner = owner
        self.animal = animal
    }
    
    // Méthode d'égalité pour le protocole Equatable.
    public static func == (left: Piece, right: Piece) -> Bool {
        return left.owner == right.owner &&
            left.animal == right.animal
    }
    
    // Méthode de hachage pour le protocole Hashable.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(owner)
        hasher.combine(animal)
    }
}
