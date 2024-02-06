import Foundation
import Model

/// Extension de la classe WinningReason du package Model permettant la justification de la raison de fin de partie.
extension Model.WinningReason: CustomStringConvertible{
    public var description: String {
        switch self {
        case .denReached:
            return "the opponent's den has been reached."
        case .noMorePieces:
            return "the opponent has no pieces left."
        case .noMovesLeft:
            return "the opponent has no moves left."
        case .tooManyOccurrences:
            return "the opponent has repeated the same move too many times."
        }
    }
}
