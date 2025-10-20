import SwiftUI
internal import Combine

@MainActor
final class ClassificationViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var result: Classification?
    @Published var errorMessage: String?
    
    private let classifier: ImageClassifying
    
    init(classifier: ImageClassifying) {
        self.classifier = classifier
    }
    
    func onImageSelected(_ img: UIImage) {
        image = img
        Task {
            do {
                result = try await classifier.classify(img)
                errorMessage = nil
            } catch {
                errorMessage = String(describing: error)
            }
        }
    }
    
}
