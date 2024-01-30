import Foundation

/// Structure représentant un mouvement sur le plateau de jeu.
public struct Move: CustomStringConvertible, Hashable {
    // Description textuelle du mouvement.
    public var description: String {
        return "\(owner.description): [\(rowOrigin):\(columnOrigin)] -> [\(rowDestination):\(columnDestination)]"
    }
    
    // Le propriétaire du mouvement.
    public let owner: Owner
    
    // Ligne d'origine du mouvement.
    public let rowOrigin: Int
    
    // Colonne d'origine du mouvement.
    public let columnOrigin: Int
    
    // Ligne de destination du mouvement.
    public let rowDestination: Int
    
    // Colonne de destination du mouvement.
    public let columnDestination: Int
    
    /// Initialiseur de la structure `Move`.
    ///
    /// - Parameters:
    ///   - owner: Le propriétaire du mouvement.
    ///   - rowOrigin: La ligne d'origine du mouvement.
    ///   - columnOrigin: La colonne d'origine du mouvement.
    ///   - rowDestination: La ligne de destination du mouvement.
    ///   - columnDestination: La colonne de destination du mouvement.
    public init(owner: Owner, rowOrigin: Int, columnOrigin: Int, rowDestination: Int, columnDestination: Int) {
        self.owner = owner
        self.rowOrigin = rowOrigin
        self.columnOrigin = columnOrigin
        self.rowDestination = rowDestination
        self.columnDestination = columnDestination
    }
}
