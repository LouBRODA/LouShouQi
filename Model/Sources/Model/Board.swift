import Foundation

//Structure définissant le plateau de jeu en lui-même
public struct Board{
    
    //Properties
    public let nbRows: Int
    public let nbColumns: Int
    public private(set) var grid: [[Cell]]
    
    //Initializer
    public init?(grid: [[Cell]]) {
        //vérifie si le nombre de Cell de la première ligne est différente de nul mais aussi égal au nombre de Cell des autres lignes.
        guard let checkRowSize = grid.first?.count, grid.allSatisfy({ $0.count == checkRowSize }) else {
            return nil
        }
        
        self.nbRows = grid.count
        self.nbColumns = checkRowSize
        self.grid = grid
    }
}
