import Vision
import UIKit

struct VisionBuiltinClassifier: ImageClassifying {
    func classify(_ image: UIImage) async throws -> Classification {
        guard let ci = CIImage(image: image) else {throw ClassificationError.noImage}
        
        return try await withCheckedThrowingContinuation { cont in
            let req = VNClassifyImageRequest { req, error in
                if let error {
                    cont.resume(throwing: ClassificationError.inferenceFailed(error.localizedDescription));
                    return
                }
                guard let best = req.results?.first as? VNClassificationObservation else {
                    cont.resume(throwing: ClassificationError.inferenceFailed("No results")); return
                }
                cont.resume(returning: Classification(label: best.identifier, confidence: Double(best.confidence)))
            }
            do { try VNImageRequestHandler(ciImage: ci).perform([req]) }
            catch { cont.resume(throwing: error) }
        }
    }
}
