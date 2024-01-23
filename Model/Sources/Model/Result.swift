import Foundation

public enum Result {
    case notFinished
    case even
    case winner(owner: Owner, WinningReason)
}
