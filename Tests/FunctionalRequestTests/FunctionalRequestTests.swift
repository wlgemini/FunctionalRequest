import XCTest
@testable import FunctionalRequest
@testable import Alamofire

enum Bases {
}

enum InputAndOutputCases {
    // base
    static var base0 = "https://www.mocky.io/v2/"
    
    // api
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

enum BaseAndAPICases {
    // base
    static var base0 = "https://www.mocky.io/v2/"
    static var base1 = "https://www.mocky.io/v2/"

    // api
    static let g0 = GET<ID, Persion>("5eb663ca3100008d556999f1") // use `Configuration.base` for base url
    static let g1 = GET<ID, Persion>("5eb663ca3100008d556999f1", base: Self.base0)
    static let g2 = GET<ID, Persion>("5eb663ca3100008d556999f1", base: Self.base1)
}

enum CacheCases {
    // base
    static var base0 = "https://www.mocky.io/v2/"
    
    // api
    static let g0 = GET<ID, Persion>("5eb663ca3100008d556999f1", base: Self.base0)
}

struct ID: Encodable {
    var id: String
}

struct Persion: Decodable {
    var name: String
    var age: Int
    var gender: Bool
}


final class FunctionalRequestTests: XCTestCase {
    
    
    func testInputAndOutput() {

        let id0 = ID(id: "123")
        let id1 = ["id": "123"]

        InputAndOutputCases.g1.request(id1)

        InputAndOutputCases.g1.request(id1)

        InputAndOutputCases.g2.request(id0)

        InputAndOutputCases.g3.request {
            print($0.value!)
        }

        InputAndOutputCases.g4.request {
            print($0.value!)
        }

        InputAndOutputCases.g5.request {
            print($0.value!)
        }

        InputAndOutputCases.g6.request(id1) {
            print($0.value!)
        }

        InputAndOutputCases.g7.request(id1) {
            print($0.value!)
        }

        InputAndOutputCases.g8.request(id1) {
            print($0.value!)
        }
        
        InputAndOutputCases.g9.request(id0) {
            print($0.value!)
        }
        
        InputAndOutputCases.g10.request(id0) {
            print($0.value!)
        }
        
        InputAndOutputCases.g11.request(id0) {
            print($0.value!)
        }
    }
    
    func testMock() {
        let id0 = ID(id: "123")
        
        let mock = InputAndOutputCases.g11
            .setMocking("http://www.mocky.io/v2/5e9421b631000080005e2dfa")
            .setTimeoutInterval(2)
        mock.request(id0) {
            print($0.value!)
        }
    }
    
    func testBaseAndAPI() {
        Configuration.base = "http://www.mocky.io/v2/"
        
        let id0 = ID(id: "123")
        
        BaseAndAPICases.g0.request(id0) {
            print($0.value!)
        }
        
        BaseAndAPICases.g1.request(id0) {
            print($0.value!)
        }
        
        BaseAndAPICases.g2.request(id0) {
            print($0.value!)
        }
    }
    
    func testCache() {
        let id0 = ID(id: "123")
        
        CacheCases
            .g0
            .setCachedResponseHandler(ResponseCacher.cache)
            .request(id0) {
                print($0.value!)
            }
    }

    static var allTests = [
        ("testInputAndOutput", testInputAndOutput),
        ("testMock", testMock),
        ("testBaseAndAPI", testBaseAndAPI),
        ("testCache", testCache),
    ]
}
