//
//  ClassificationView.swift
//  SeeFood
//
//  Created by Faraz on 10/19/25.
//

import SwiftUI

struct ClassificationView: View {
    @StateObject var vm: ClassificationViewModel
    @State private var showCamera = false
    @State private var showLibrary = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let img = vm.image {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .overlay(alignment: .bottom) {
                            if let r = vm.result {
                                Text("\(r.label) - \(Int(r.confidence * 100))%")
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
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {showCamera = true}, label: { Image(systemName: "camera.fill") })
                    Button(action: {showLibrary = true}, label: { Image(systemName: "photo.fill.on.rectangle.fill") })
                }
            }
            .sheet(isPresented: $showCamera) {
                CameraView(image:
                            Binding(
                                get: {vm.image}
                                ,set: { if let img = $0 { vm.onImageSelected(img) }} )
                           ,sourceType: .camera )
            }
            .sheet(isPresented: $showLibrary) {
                CameraView(image:
                            Binding(
                                get: {vm.image}
                                ,set: { if let img = $0 { vm.onImageSelected(img) }} )
                           ,sourceType: .photoLibrary )
            }
            .alert("Error", isPresented: .constant(vm.errorMessage != nil)) {
                Button("OK") { vm.errorMessage = nil }
            }
            message: { Text(vm.errorMessage ?? "") }
        }
    }
}

#Preview {
    ClassificationView(vm: ClassificationViewModel(classifier: VisionBuiltinClassifier()))
}
