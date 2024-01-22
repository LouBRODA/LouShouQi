import Foundation

public enum BoardResult: Equatable{
    case unknown
    case ok
    case failed(reason: BoardFailingReason)
    
    public static func == (left: BoardResult, right: BoardResult) -> Bool {
        switch (left, right) {
        case (.unknown, .unknown):
            return true
        case (.ok, .ok):
            return true
        case (.failed(_), .failed(_)):
            return true
        default:
            return false
        }
    }
}
