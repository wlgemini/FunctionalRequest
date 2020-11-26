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
    static let g0 = GET<ID, Persion>("5eb8edfc2d00007a6e357ea4") // use `Configuration.base` for base url
    static let g1 = GET<ID, Persion>("5eb8edfc2d00007a6e357ea4", base: Self.base0)
    static let g2 = GET<ID, Persion>("5eb8edfc2d00007a6e357ea4", base: Self.base1)
}

enum CacheCases {
    // base
    static var base0 = "https://www.mocky.io/v2/"
    
    // api
    static let g0 = GET<ID, Persion>("5eb8edfc2d00007a6e357ea4", base: Self.base0)
}

enum RedirectCases {
    // base
    static var base0 = "https://www.mocky.io/v2/"
    
    // api
    static let g0 = GET<ID, Persion>("5eb908ec2d00007a6e357f9f", base: Self.base0)
}

enum EventMonitorCases {
    // base
    static var base0 = "https://www.mocky.io/v2/"
    
    // api
    static let g0 = GET<ID, Persion>("5eb908ec2d00007a6e357f9f", base: Self.base0)
}


struct ID: Encodable {
    var id: String
}

struct Persion: Decodable, Equatable {
    var name: String
    var age: Int
    var gender: Bool
}


final class FunctionalRequestTests: XCTestCase {
    
    
    func testInputAndOutput() {

        let id0 = ID(id: "123")
        let id1 = ["id": "123"]

        InputAndOutputCases.g0.request()

        InputAndOutputCases.g1.request(id1)

        InputAndOutputCases.g2.request(id0)

        InputAndOutputCases.g3.request {
            print($0.value)
        }

        InputAndOutputCases.g4.request {
            print($0.value)
        }

        InputAndOutputCases.g5.request {
            print($0.value)
        }

        InputAndOutputCases.g6.request(id1) {
            print($0.value)
        }

        InputAndOutputCases.g7.request(id1) {
            print($0.value)
        }

        InputAndOutputCases.g8.request(id1) {
            print($0.value)
        }
        
        InputAndOutputCases.g9.request(id0) {
            print($0.value)
        }
        
        InputAndOutputCases.g10.request(id0) {
            print($0.value)
        }
        
        InputAndOutputCases.g11.request(id0) {
            print($0.value)
        }
    }
    
    func testMock() {
        let exp = XCTestExpectation()
        
        let id0 = ID(id: "123")
        
        let mock = InputAndOutputCases.g11
            .setMock("http://www.mocky.io/v2/5eb8edfc2d00007a6e357ea4")
            .setTimeoutInterval(10)
        
        mock.request(id0) {
            let p = Persion(name: "wlg", age: 18, gender: true)
            XCTAssert(p == $0.result.success)
            XCTAssert(p == $0.cachedValue())
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
    }
    
    func testBaseAndAPI() {
        let exp0 = XCTestExpectation()
        let exp1 = XCTestExpectation()
        let exp2 = XCTestExpectation()

        let id0 = ID(id: "123")
        let p = Persion(name: "wlg", age: 18, gender: true)
        
        Config.DataRequest.base = { "http://www.mocky.io/v2/" }
        BaseAndAPICases
            .g0
            .request(id0) {
            XCTAssert(p == $0.result.success)
            XCTAssert(p == $0.cachedValue())
            exp0.fulfill()
        }
        
        BaseAndAPICases
            .g1
            .request(id0) {
            XCTAssert(p == $0.result.success)
            XCTAssert(p == $0.cachedValue())
            exp1.fulfill()
        }
        
        BaseAndAPICases
            .g2
            .request(id0) {
            XCTAssert(p == $0.result.success)
            XCTAssert(p == $0.cachedValue())
            exp2.fulfill()
        }
        
        wait(for: [exp0, exp1, exp2], timeout: 10)
    }
    
    func testCache() {
        
        let exp = XCTestExpectation()
        
        let id0 = ID(id: "123")
        
        CacheCases
            .g0
            .setAdditionalHeaders(HTTPHeaders(["foo": "123", "bar": "456"]))
            .setCachedResponseHandler(ResponseCacher.doNotCache)
            .request(id0) {
                let p = Persion(name: "wlg", age: 18, gender: true)
                XCTAssert(p == $0.result.success)
                XCTAssert(p == $0.cachedValue())
                exp.fulfill()
            }
        
        wait(for: [exp], timeout: 10)
    }
    
    func testRedirect() {
        
        let exp = XCTestExpectation()
        
        let id0 = ID(id: "123")
        
        RedirectCases.g0.setRedirectHandler(Redirector.follow).request(id0) {
            let p = Persion(name: "wlg", age: 18, gender: true)
            XCTAssert(p == $0.result.success)
            XCTAssert(p != $0.cachedValue())
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
    }
    
    func testEventMonitor() {
        let exp = XCTestExpectation()

        let monitor = ClosureEventMonitor()
        monitor.taskDidFinishCollectingMetrics = { (session, task, metrics) in
            print("🔨:", metrics)
        }
        Config.DataRequest.eventMonitors = [monitor]
        
        let id0 = ID(id: "123")
        
        EventMonitorCases.g0.request(id0) {
            let p = Persion(name: "wlg", age: 18, gender: true)
            XCTAssert(p == $0.result.success)
            XCTAssert(p != $0.cachedValue())
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
    }

    static var allTests = [
        ("testInputAndOutput", testInputAndOutput),
        ("testMock", testMock),
        ("testBaseAndAPI", testBaseAndAPI),
        ("testCache", testCache),
        ("testRedirect", testRedirect),
        ("testEventMonitor", testEventMonitor),
    ]
}
