//
//  Headers.swift
//  FunctionalRequestTests
//
//  Created by wangluguang on 2021/3/2.
//

import Foundation
import Alamofire


enum Headers {
    
    static let defaultHeaders = HTTPHeaders([
        "key0": "0",
        "key1": "1",
        "key2": "2"
    ])
    
    static let moreHeaders = HTTPHeaders([
        "key3": "3",
        "key4": "4",
        "key5": "5"
    ])
}
