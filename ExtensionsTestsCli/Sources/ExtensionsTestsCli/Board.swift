import Foundation
import Model

///Extension de la classe Board du package Model permettant l'affichage de la valeur avec un emoji
extension Model.Board : CustomStringConvertible{
    public var description: String {
        var s = ""
        for i in 0..<grid.count{
            s += "\n"
            for j in 0..<grid[i].count{
                s += "\(grid[i][j].cellType.symbol)\(grid[i][j].piece?.animal.symbol ?? "   ")\(grid[i][j].piece?.owner.symbol ?? " ")     "
            }
        }
        return s
    }
    
}
