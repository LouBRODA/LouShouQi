import Foundation

public enum BoardResult{
    case unknown
    case ok
    case failed(reason: BoardFailingReason)
}
