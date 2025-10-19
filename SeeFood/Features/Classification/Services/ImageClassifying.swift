import UIKit

protocol ImageClassifying {
    func classify(_ image: UIImage) async throws -> Classification
}

