import SwiftUI

struct ContentView: View {
    @State private var showCamera = false
    @State private var image: UIImage?
    
    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
            } else {
                Text("Tap the camera button to capture an image")
            }
        }.navigationTitle(showCamera ? "Processing..." : "Camera")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCamera = true
                    } label: {
                        Image(systemName: "camera.fill")
                    }
                    .accessibilityLabel("Open Camera")
                }
            }
            .sheet(isPresented: $showCamera) {
                ContentView() // change to CameraView
            }
    }
}

#Preview {
    ContentView()
}
