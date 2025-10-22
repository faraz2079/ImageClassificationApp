# 🍔 SeeFood – Clean SwiftUI Image Classifier App

**SeeFood** is an iOS app built with **SwiftUI**, **Core ML**, and **Vision** that classifies objects in photos captured from the camera or selected from the photo library.

The project has been fully refactored to follow **SOLID principles**, **clean architecture**, and **MVVM** design — making the code **testable**, **maintainable**, and **easy to extend**.

---

## 🧠 Two Interchangeable ML Implementations

SeeFood supports **two modular classification strategies**, both conforming to a shared `ImageClassifying` protocol:

| Implementation | Description |
|----------------|--------------|
| 🧩 **Apple Vision Built-in Classifier** | The **default** implementation using `VNClassifyImageRequest`. No `.mlmodel` file needed; uses Apple’s on-device Vision model. |
| ⚡ **MobileNetV2 Core ML Model** | A **custom pre-trained neural network** integrated via Core ML. Demonstrates how to plug in your own model. |

Both exist in the codebase under  
`Features/Classification/Services/` → `VisionBuiltinClassifier.swift` & `MobileNetV2Classifier.swift`.  
You can swap them by changing **one line** in `SeeFoodApp.swift`:

```swift
let classifier: ImageClassifying = VisionBuiltinClassifier()
// let classifier: ImageClassifying = MobileNetV2Classifier()
```

