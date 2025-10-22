import UIKit
@testable import SeeFood

struct MockClassifier: ImageClassifying {
    
    var result: Result<Classification, Error>
    
    func classify(_ image: UIImage) async throws -> Classification {
        switch result {
        case .success(let cls): return cls
        case .failure(let err): throw err
        }
    }
}

enum FakeError: Error { case boom }
