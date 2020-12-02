import XCTest
@testable import FunctionalRequest
@testable import Alamofire


final class FunctionalRequestTests: XCTestCase {
    
    static var allTests = [
        ("testAPI", testAPI),
        ("testMock", testMock),
        ("testTimeoutInterval", testTimeoutInterval),
        ("testCredential", testCredential),
        ("testRedirectHandler", testRedirectHandler),
        ("testEncodeParams", testEncodeParams),
        ("testCache", testCache)
    ]
    
    override class func setUp() {
        // eventMonitors
        let monitor = Alamofire.ClosureEventMonitor()
        monitor.requestDidFinish = { print($0.metrics) }
        FunctionalRequest.Configuration.eventMonitors = [monitor]
        
        // base
        FunctionalRequest.Configuration.DataRequest.base = { "http://127.0.0.1:8080" }
        
        // header
        FunctionalRequest.Configuration.DataRequest.headers = { Alamofire.HTTPHeaders(["foo": "bar"]) }
        
        // timeoutInterval
        FunctionalRequest.Configuration.DataRequest.timeoutInterval = { 10.0 }
        
        // credential
        FunctionalRequest.Configuration.DataRequest.credential = { nil }
        
        // redirectHandler
        FunctionalRequest.Configuration.DataRequest.redirectHandler = { Alamofire.Redirector(behavior: .follow) }
    }
}


enum APIs {
    
    struct Account: Encodable {
        let email: String
        let password: String
    }
    
    struct User: Decodable {
        let token: String
        let name: String
    }
    
    struct Friend {
        let name: String
    }
    
    static let login = POST<Account, User>("login")
    static let friends = GET<None, [Friend]>("friend")
}

extension FunctionalRequestTests {
    // GET: base & api & subApi & header
    func testAPI() {
        
    }
    
    func testMock() {
//        let exp = XCTestExpectation()
//
//        let id0 = ID(id: "123")
//
//        let mock = InputAndOutputCases.g11
//            .setMock("http://www.mocky.io/v2/5eb8edfc2d00007a6e357ea4")
//            .setTimeoutInterval(10)
//
//        mock.request(id0) {
//            let p = Persion(name: "wlg", age: 18, gender: true)
//            XCTAssert(p == $0.result.success)
//            XCTAssert(p == $0.cachedValue())
//            exp.fulfill()
//        }
//
//        wait(for: [exp], timeout: 10)
    }
    
    func testTimeoutInterval() {
        
    }
    
    func testCredential() {
        
    }
    
    func testRedirectHandler() {
//        let exp = XCTestExpectation()
//
//        let id0 = ID(id: "123")
//
//        RedirectCases.g0.setRedirectHandler(Redirector.follow).request(id0) {
//            let p = Persion(name: "wlg", age: 18, gender: true)
//            XCTAssert(p == $0.result.success)
//            XCTAssert(p != $0.cachedValue())
//            exp.fulfill()
//        }
//
//        wait(for: [exp], timeout: 10)
    }
    
    func testEncodeParams() {
        
    }
    
    func testCache() {
//        let exp = XCTestExpectation()
//
//        let id0 = ID(id: "123")
//
//        CacheCases
//            .g0
//            .setAdditionalHeaders(HTTPHeaders(["foo": "123", "bar": "456"]))
//            .setCachedResponseHandler(ResponseCacher.doNotCache)
//            .request(id0) {
//                let p = Persion(name: "wlg", age: 18, gender: true)
//                XCTAssert(p == $0.result.success)
//                XCTAssert(p == $0.cachedValue())
//                exp.fulfill()
//            }
//
//        wait(for: [exp], timeout: 10)
    }
}
