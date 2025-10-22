//
//  ClassificationViewModelTests.swift
//  SeeFood
//
//  Created by Faraz on 10/22/25.
//

import XCTest
@testable import SeeFood

final class ClassificationViewModelTests: XCTestCase {
    
    @MainActor
    func test_onImageSelected_updateResult() async {
        
        let expected = Classification(label: "Pizza", confidence: 0.88)
        let vm = ClassificationViewModel(classifier: MockClassifier(result: .success(expected)))
        
        vm.onImageSelected(UIImage())
        
        await Task.yield()
        
        var conf = vm.result?.confidence
        
        XCTAssertEqual(vm.result?.label, "Pizza")
        XCTAssertEqual(conf!, 0.88, accuracy: 0.0001)
        XCTAssertNil(vm.errorMessage)
    }
    
    @MainActor
    func test_onImageSelected_handlesError() async {
        
        let vm = ClassificationViewModel(classifier: MockClassifier(result: .failure(FakeError.boom)))
        
        vm.onImageSelected(UIImage())
        await Task.yield()
        
        XCTAssertNil(vm.result)
        XCTAssertNotNil(vm.errorMessage)
    }
}
