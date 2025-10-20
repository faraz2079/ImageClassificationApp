//
//  SeeFoodApp.swift
//  SeeFood
//
//  Created by Faraz on 10/16/25.
//

import SwiftUI

@main
struct SeeFoodApp: App {
    var body: some Scene {
        WindowGroup {
            let classifier: ImageClassifying = MobileNetV2Classifier()
            
            ClassificationView(vm: .init(classifier: classifier))
        }
    }
}
