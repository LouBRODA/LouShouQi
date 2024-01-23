import Foundation

public struct Move : CustomStringConvertible, Hashable {
    public var description: String{
        return "\(owner.description) : [\(rowOrigin):\(columnOrigin)] -> [\(rowDestination):\(columnDestination)]"
    }
    
    let owner: Owner
    let rowOrigin: Int
    let columnOrigin: Int
    let rowDestination: Int
    let columnDestination: Int
    
    public init(owner: Owner, rowOrigin: Int, columnOrigin: Int, rowDestination: Int, columnDestination: Int) {
        self.owner = owner
        self.rowOrigin = rowOrigin
        self.columnOrigin = columnOrigin
        self.rowDestination = rowDestination
        self.columnDestination = columnDestination
    }
}
