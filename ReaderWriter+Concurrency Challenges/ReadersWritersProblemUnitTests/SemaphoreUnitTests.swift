//
//  SemaphoreUnitTests.swift
//  ReadersWritersProblem
//
//  Created by Chase Wang on 2/23/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import XCTest
@testable import ReadersWritersProblem

class SemaphoreUnitTests: XCTestCase {
    
    let iterations = 200_000
    
    var user: SUser!
    
    override func setUp() {
        super.setUp()
        user = SUser.current
    }
    
    let semaphore = DispatchSemaphore(value: 1)
    
    func testSemaphoreReadersWritersProblem() {
        // solve with semaphores
         let expectation = self.expectation(description: "com.makeschool.expectation")
        
        for _ in 0..<iterations {
            semaphore.wait()
            print("wait: \(user.age)")
        
            DispatchQueue.global().async {
                self.user.age += 1
                self.semaphore.signal()
                print("signal: \(self.user.age)")
            }
           
        }
        
        expectation.fulfill()
        XCTAssertEqual(self.iterations, self.user.age)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
}
