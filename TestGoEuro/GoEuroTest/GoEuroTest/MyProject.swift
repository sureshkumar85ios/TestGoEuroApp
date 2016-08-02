//
//  MyProject.swift
//  GoEuroTest
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

import Foundation

@objc class Hello: NSObject {
    func sayHello() {
        print("Hi test application!")
        
   
    }
    

    
    func myArrayFunc(inputArray:Array<String>) -> Array<String>{
        
        var newArray = inputArray
        
        // do stuff with newArray
        
        newArray.sortInPlace {
            return $0 < $1
        }
        
        return newArray
    }
}