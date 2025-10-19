import Foundation

struct Classification: Equatable {
    let label: String
    let confidence: Double
}

enum ClassificationError: Error, Equatable {
    case noImage
    case inferenceFailed(String)
}
