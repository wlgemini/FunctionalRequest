//
//  main.swift
//  FunctionalRequest-Demo
//
//  Created by wangluguang on 2020/4/24.
//  Copyright © 2020 com.wlgemini. All rights reserved.
//



struct APIs {
    
    static var base0 = "https://www.base0-dev.com/" // "https://www.base0-online.com/"
    
    static var base1 = "https://www.base1-dev.com/" // "https://www.base1-online.com/"
    
    static var base2 = "https://www.base2-dev.com/" // "https://www.base2-online.com/"
    

    static let g0 = GET<None, None>("foo", base: Self.base0)
    
    static let g1 = GET<JSON, None>("foo", base: Self.base0)
    static let g2 = GET<ID, None>("foo", base: Self.base0)
    
    static let g3 = GET<None, Data>("foo", base: Self.base0)
    static let g4 = GET<None, JSON>("foo", base: Self.base0)
    static let g5 = GET<None, Persion>("foo", base: Self.base0)
    
    static let g6 = GET<JSON, Data>("foo", base: Self.base0)
    static let g7 = GET<JSON, JSON>("foo", base: Self.base0)
    static let g8 = GET<JSON, Persion>("foo", base: Self.base0)
    
    static let g9 = GET<ID, Data>("foo", base: Self.base0)
    static let g10 = GET<ID, JSON>("foo", base: Self.base0)
    static let g11 = GET<ID, Persion>("foo", base: Self.base0)
    
}

struct ID: Encodable {
    var id: String
}

struct Persion: Decodable {
    var name: String
    var age: Int
    var gender: Bool
}

let id0 = ID(id: "123")
    let id1 = ["id": "123"]

    let mock = APIs.g0
        .setMocking("http://www.mocky.io/v2/5e9421b631000080005e2dfa")
        .setTimeoutInterval(2)
    mock.request()

    APIs.g0.request()

    APIs.g1.request(id1)

    APIs.g2.request(id0)

    APIs.g3.request {
        print($0.value!)
    }

    APIs.g4.request {
        print($0.value!)
    }

    APIs.g5.request {
        print($0.value!)
    }

    APIs.g6.request(id1) {
        print($0.value!)
    }

    APIs.g7.request(id1) {
        print($0.value!)
    }

    APIs.g8.request(id1) {
        print($0.value!)
    }
    
    APIs.g9.request(id0) {
        print($0.value!)
    }
    
    APIs.g10.request(id0) {
        print($0.value!)
    }
    
    APIs.g11.request(id0) {
        print($0.value!)
    }
}
