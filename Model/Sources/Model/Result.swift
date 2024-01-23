import Foundation

public enum Result : Hashable {
    case notFinished
    case even
    case winner(owner: Owner, WinningReason)
}
