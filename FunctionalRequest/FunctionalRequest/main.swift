//
//  main.swift
//  FunctionalRequest
//
//  Created by wangluguang on 2020/4/13.
//  Copyright © 2020 com.wlgemini. All rights reserved.
//

import Foundation

Configuration.base = "https://www.wlgemini.com/"

struct APIs {

    static let mk = PUT<ID, Persion>(api: "foo")
    
}

struct ID: Encodable {
    var id: String
}

struct Persion: Decodable {
    var name: String
    var age: Int
    var gender: Bool
}


let mock = APIs.mk
    .setMocking("http://www.mocky.io/v2/5e9421b631000080005e2dfa")
    .setTimeoutInterval(2)


let pams = ID(id: "123")
mock(params: pams) { res in
    print(res.value!)
}


RunLoop.current.run()


