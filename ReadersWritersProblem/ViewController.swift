//
//  ViewController.swift
//  ReadersWritersProblem
//
//  Created by Chase Wang on 2/23/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // GOTO: Unit Tests Target
    
    func performDeadlock() {
//
        
        for i in 0..<3 {
            
        }
    }
    
    func performPriorityInversion() {
        
    }
   
}

extension Array {
    
    func parallelMap<T>(_ transform: (Element) -> T)  -> [T] {
        // Concurrently perform operations of map
        var resultArray = [Int: T]()
        
        
        let concurrentQueue = DispatchQueue(
            label: "concurrentQueue",
            attributes: .concurrent)
        
        DispatchQueue.concurrentPerform(iterations: count) { i in
            let result = transform(self[i])
            concurrentQueue.async { resultArray[i] = result }
            
        }
        
        return concurrentQueue.sync(flags: .barrier) {
            (0 ..< resultArray.count).map { resultArray[$0]! }
        }
    }
    
}
