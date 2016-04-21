//
//  Input.swift
//  litleTalk
//
//  Created by Tek on 16/4/19.
//  Copyright © 2016年 Tek. All rights reserved.
//

import Foundation

struct Inputs:OptionSetType {
    let rawValue:Int
    
    static let user = Inputs(rawValue: 1)
    static let passWord = Inputs(rawValue: 1<<1)
    static let email = Inputs(rawValue: 1<<2)
}

extension Inputs {
 
    func isAllDone() -> Bool {
        let count = 3
        var done = 0
        
        for item in 0..<count where contains(Inputs(rawValue:1<<item)){
            done += 1
        }
        return count == done
    }
    
}
