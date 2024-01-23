import Foundation

public struct Move : CustomStringConvertible {
    public var description: String{
        return "\(owner.description) : [\(rowOrigin):\(columnOrigin)] -> [\(rowDestination):\(columnDestination)]"
    }
    
    let owner: Owner
    let rowOrigin: Int
    let columnOrigin: Int
    let rowDestination: Int
    let columnDestination: Int
}
