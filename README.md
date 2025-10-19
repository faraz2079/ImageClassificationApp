# 🍔 SeeFood – SwiftUI Image Classifier App

**SeeFood** is an iOS app built with **SwiftUI**, **Core ML**, and **Vision** that recognizes objects in photos taken from the camera or selected from the photo library.

This project includes **two interchangeable implementations** for image classification:
1. 🧠 **Apple’s built-in Vision Classifier** – the default implementation (`VNClassifyImageRequest`)
2. ⚡ **MobileNetV2 Core ML Model** – a pre-trained custom model integrated into the project

Both implementations exist in the source code.  
The **default (active)** one is Apple’s built-in Vision classifier, and the **second one (MobileNetV2)** is **commented out**.  
You can switch between them easily by commenting/uncommenting the `detect(uiimage:)` function in **ContentView.swift**.

---

## 🛠️ Technologies Used

| Framework | Purpose |
|------------|----------|
| **SwiftUI** | Modern declarative UI |
| **Core ML** | Loads and runs the MobileNetV2 model |
| **Vision** | Handles image requests & classification |
| **UIKit (bridged)** | Accesses camera/photo picker via `UIViewControllerRepresentable` |

---

## ✨ Features

- 📷 Capture a photo with the camera  
- 🖼️ Select a photo from the library  
- 🧩 Run object recognition using **two different ML approaches**
- 💬 Display classification label and confidence overlay on the image  
- 💡 Built 100% in **SwiftUI** (no storyboard)

---

## 🧩 How It Works

1. The user taps either the **Camera** or **Gallery** button in the navigation bar.  
2. The app presents `UIImagePickerController` (wrapped for SwiftUI).  
3. The captured or selected image is stored in `@State image`.  
4. `onChange(of: image)` triggers the Vision request:  

   ```swift
   let vnModel = try! VNCoreMLModel(for: MobileNetV2(configuration: .init()).model)
   let request = VNCoreMLRequest(model: vnModel)
   try? VNImageRequestHandler(ciImage: CIImage(image: uiImage)!).perform([request])
