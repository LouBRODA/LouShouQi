import Foundation

//Structure définissant une pièce du jeu
public struct Piece : CustomStringConvertible{
    
    //Properties
    public var description: String { "[\(owner):\(animal)]" }
    
    public let owner: Owner
    public let animal: Animal
    
    public init(owner: Owner, animal: Animal){
        self.owner = owner
        self.animal = animal
    }
}
