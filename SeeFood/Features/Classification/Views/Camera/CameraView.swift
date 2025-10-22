//
//  CameraView.swift
//  SeeFood
//
//  Created by Faraz on 10/18/25.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    typealias Coordinator = CameraCoordinator
    
    @Environment(\.dismiss) var dismiss
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(sourceType) ? sourceType : .photoLibrary
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        if picker.sourceType == .camera {
            picker.cameraCaptureMode = .photo
        }
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> CameraCoordinator { CameraCoordinator(parent: self) }
    
}

