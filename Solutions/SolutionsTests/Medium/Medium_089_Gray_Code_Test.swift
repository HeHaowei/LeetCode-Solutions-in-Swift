//
//  Medium_089_Gray_Code_Test.swift
//  Solutions
//
//  Created by Di Wu on 10/21/15.
//  Copyright © 2015 diwu. All rights reserved.
//

import XCTest

class Medium_089_Gray_Code_Test: XCTestCase {
    private static let ProblemName: String = "Medium_089_Gray_Code"
    private static let TimeOutName = ProblemName + Default_Timeout_Suffix
    private static let TimeOut = Default_Timeout_Value * 10
    func test_001() {
        let input: Int = 2
        asyncHelper(input: input)
    }
    func twoNumberSatisfyGrayCodeRule(a a: Int, b: Int, N: Int) -> Bool {
        var counter: Int = 0
        for var i = 0; i < N; i++ {
            let tmp: Int = 1 << i
            let x: Int = a & tmp
            let y: Int = b & tmp
            if x != y {
                counter++
            }
        }
        if counter == 1 {
            return true
        } else {
            return false
        }
    }
    private func asyncHelper(input input: Int) {
        weak var expectation: XCTestExpectation? = self.expectationWithDescription(Medium_089_Gray_Code_Test.TimeOutName)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let result: [Int] = Medium_089_Gray_Code.grayCode(input)
            if input == 0 {
                if result.count != 0 {
                    assertHelper(false, problemName: Medium_089_Gray_Code_Test.ProblemName, input: input, resultValue: result, expectedValue: [])
                }
            } else {
                if result.count != Int(pow(Double(2), Double(input))) {
                    assertHelper(false, problemName: Medium_089_Gray_Code_Test.ProblemName, input: input, resultValue: result, expectedValue: [])
                }
                var prev: Int = result.last!
                for var i = 0; i < result.count; i++ {
                    var next: Int = 0
                    if i == result.count - 1 {
                        next = result.first!
                    } else {
                        next = result[i+1]
                    }
                    if self.twoNumberSatisfyGrayCodeRule(a: result[i], b: prev, N: input) == false || self.twoNumberSatisfyGrayCodeRule(a: result[i], b: next, N: input) == false {
                        assertHelper(false, problemName: Medium_089_Gray_Code_Test.ProblemName, input: input, resultValue: result, expectedValue: [])
                    }
                    prev = result[i]
                }
            }
            if let unwrapped = expectation {
                unwrapped.fulfill()
            }
        })
        waitForExpectationsWithTimeout(Medium_089_Gray_Code_Test.TimeOut) { (error: NSError?) -> Void in
            if error != nil {
                assertHelper(false, problemName: Medium_089_Gray_Code_Test.ProblemName, input: input, resultValue: Medium_089_Gray_Code_Test.TimeOutName, expectedValue: [])
            }
        }
    }
}
