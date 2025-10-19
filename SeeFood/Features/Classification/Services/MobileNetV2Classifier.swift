import UIKit
import Vision
import CoreML


struct MobileNetV2Classifier: ImageClassifying {
    func classify(_ image: UIImage) async throws -> Classification {
        guard let ci = CIImage(image: image) else {
            throw ClassificationError.noImage
        }
        let vnModel = try VNCoreMLModel(for: MobileNetV2(configuration: .init()).model)
        
        return try await withCheckedThrowingContinuation { cont in
            let req = VNCoreMLRequest(model: vnModel) { req, err in
                if let err { cont.resume(throwing: ClassificationError.inferenceFailed(err.localizedDescription)); return }
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
