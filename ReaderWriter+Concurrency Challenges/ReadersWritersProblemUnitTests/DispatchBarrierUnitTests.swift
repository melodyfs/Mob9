//
//  DispatchBarrierUnitTests.swift
//  ReadersWritersProblem
//
//  Created by Chase Wang on 2/23/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import XCTest
@testable import ReadersWritersProblem

class DispatchBarrierUnitTests: XCTestCase {
    
    let iterations = 200_000
    
    var user: DBUser!
    
    override func setUp() {
        super.setUp()
        user = DBUser.current
    }
    
    fileprivate let concurrentQueue = DispatchQueue(
            label: "concurrentQueue",
            attributes: .concurrent)
    
    func testDispatchBarrierReadersWritersProblem() {
        // solve with dispatch barriers
        let expectation = self.expectation(description: "com.makeschool.expectation")
       
        for _ in 0..<self.iterations {
            print("read: \(self.user.age)")
             concurrentQueue.async(flags: .barrier){
                 self.user.age += 1
                
            }
        
        }
        XCTAssertEqual(self.iterations, self.user.age)
        print("It is: \(self.iterations, self.user.age)")
        expectation.fulfill()
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
