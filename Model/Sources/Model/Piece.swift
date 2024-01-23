import Foundation

///Structure définissant une pièce du jeu
public struct Piece : CustomStringConvertible, Hashable{
    
    ///Properties
    public var description: String { "[\(owner):\(animal)]" }
    
    public let owner: Owner
    public let animal: Animal
    
    public init(owner: Owner, animal: Animal){
        self.owner = owner
        self.animal = animal
    }
    
    public static func == (left: Piece, right: Piece) -> Bool {
        return left.owner == right.owner &&
        left.animal == right.animal
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(owner)
        hasher.combine(animal)
    }
}
