import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    @State private var showCamera = false
    @State private var showLibrary = false
    @State private var image: UIImage?
    @State private var classification: String?
    
    var body: some View {
        NavigationStack{
            ZStack {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                        .overlay(alignment: .bottom) {
                            if let classification {
                                Text(classification)
                                    .padding(8)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding()
                            }
                        }
                } else {
                    Text("Choose an image 📷 or 🖼️")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                }
            }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showCamera = true
                        } label: {
                            Image(systemName: "camera.fill")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showLibrary = true
                        } label: {
                             Image(systemName: "photo.fill.on.rectangle.fill")
                        }
                    }
                }
                .sheet(isPresented: $showCamera) {
                    CameraView(image: $image, sourceType: .camera) // change to CameraView
                }
                .sheet(isPresented: $showLibrary) {
                    CameraView(image: $image, sourceType: .photoLibrary)
                }
                .onChange(of: image) { newImage in
                    if let img = newImage {
                        detect(uiimage: img)
                    }
                }
        }
    }
    
    private func detect(uiimage: UIImage) {
        let ci = CIImage(image: uiimage)!
        let req = VNClassifyImageRequest { r, _ in
            let best = (r.results as? [VNClassificationObservation])?.first
            self.classification = "\(best?.identifier ?? "?") - \(Int((best?.confidence ?? 0)*100))%"
        }
        try? VNImageRequestHandler(ciImage: ci).perform([req])
    }
    
}

#Preview {
    ContentView()
}


// MobileNetV2 implementation
//    private func detect(uiimage: UIImage) {
//        let ciimage = CIImage(image: uiimage)!
//        let vnModel = try! VNCoreMLModel(for: MobileNetV2(configuration: .init()).model)
//        let req = VNCoreMLRequest(model: vnModel) { r, _ in
//            let best = (r.results as? [VNClassificationObservation])?.first
//            self.classification = "\(best?.identifier ?? "?") - \(Int((best?.confidence ?? 0)*100))%"
//        }
//        try? VNImageRequestHandler(ciImage: ciimage).perform([req])
//    }
