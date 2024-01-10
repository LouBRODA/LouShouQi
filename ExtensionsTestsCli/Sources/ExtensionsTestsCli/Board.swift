import Foundation
import Model

///Extension de la classe Board du package Model permettant l'affichage de la valeur avec un emoji
extension Model.Board : CustomStringConvertible{
    public var description: String { "\(grid)" }
    
    
}
