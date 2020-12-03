import XCTest
@testable import FunctionalRequest
@testable import Alamofire


final class FunctionalRequestTests: XCTestCase {
    
    static var allTests = [
        ("testAPI", testAPI),
        ("testParamsModelEncode", testParamsModelEncode),
        ("testParamsJSONEncode", testParamsJSONEncode),
        ("testMock", testMock),
        ("testTimeoutInterval", testTimeoutInterval),
        ("testCredential", testCredential),
        ("testRedirectHandler", testRedirectHandler),
        ("testValidation", testValidation),
        ("testCache", testCache)
    ]
    
    override class func setUp() {
        // eventMonitors
        let monitor = Alamofire.ClosureEventMonitor()
        monitor.requestDidFinish = { print($0.metrics) }
        FunctionalRequest.Configuration.eventMonitors = [monitor]
        
        // base
        FunctionalRequest.Configuration.DataRequest.base = { APIs.base }
        
        // header
        FunctionalRequest.Configuration.DataRequest.headers = { Alamofire.HTTPHeaders(["foo": "x"]) }
        
        // timeoutInterval
        FunctionalRequest.Configuration.DataRequest.timeoutInterval = { 10.0 }
        
        // credential
        FunctionalRequest.Configuration.DataRequest.credential = { nil }
        
        // redirectHandler
        FunctionalRequest.Configuration.DataRequest.redirectHandler = { Alamofire.Redirector(behavior: .follow) }
    }
}


enum APIs {
    
    struct Echo: Codable, Equatable {
        let foo: String
        let bar: String
        let baz: String
    }
    
    static let base = "http://127.0.0.1:8080/"

    
    static let api = POST<Echo, Echo>("api")
    
    static let echoGet = GET<Echo, Echo>("echo")
    static let echoDelete = DELETE<Echo, Echo>("echo")
    static let echoPatch = PATCH<Echo, Echo>("echo")
    static let echoPost = POST<Echo, Echo>("echo")
    static let echoPut = PUT<Echo, Echo>("echo")
    
    static let echoJSONGet = GET<JSON, JSON>("echo")
    static let echoJSONDelete = DELETE<JSON, JSON>("echo")
    static let echoJSONPatch = PATCH<JSON, JSON>("echo")
    static let echoJSONPost = POST<JSON, JSON>("echo")
    static let echoJSONPut = PUT<JSON, JSON>("echo")

    static let timeInterval = POST<Echo, Echo>("timeInterval")
    
    static let redirectFrom = POST<Echo, Echo>("redirectFrom")
    static let redirectTo = POST<Echo, Echo>("redirectTo")
}

extension FunctionalRequestTests {
    
    // GET: base & api & subApi & header
    func testAPI() {

        let expPost = XCTestExpectation()
        
        let model = APIs.Echo(foo: "x", bar: "y", baz: "z")
        let headers = HTTPHeaders(["bar": "y", "foo": "xx"])
        
        APIs.api
            .setSubApi("/v1")
            .setAdditionalHeaders(headers)
            .request(model) {
                // url
                XCTAssert($0.request?.url == URL(string: APIs.base + APIs.api.configuration.api + "/v1"))
                
                // headers
                for h in headers {
                    XCTAssert($0.request?.headers[h.name] == h.value)
                }
                
                // model
                XCTAssert($0.result.success == model)
                expPost.fulfill()
            }
        
        wait(for: [expPost], timeout: 10)
    }
    
    func testParamsModelEncode() {
        let expGet = XCTestExpectation()
        let expDelete = XCTestExpectation()
        let expPatch = XCTestExpectation()
        let expPost = XCTestExpectation()
        let expPut = XCTestExpectation()
        
        let model = APIs.Echo(foo: "x", bar: "y", baz: "z")
        
        APIs.echoGet
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expGet.fulfill()
            }
        
        APIs.echoDelete
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expDelete.fulfill()
            }
        
        APIs.echoPatch
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expPatch.fulfill()
            }
        
        APIs.echoPost
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expPost.fulfill()
            }
        
        APIs.echoPut
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expPut.fulfill()
            }
        
        wait(for: [expGet, expDelete, expPatch, expPost, expPut], timeout: 10)
    }
    
    func testParamsJSONEncode() {
        
        let expGet = XCTestExpectation()
        let expDelete = XCTestExpectation()
        let expPatch = XCTestExpectation()
        let expPost = XCTestExpectation()
        let expPut = XCTestExpectation()
        
        let model = [
            "foo": "x",
            "bar": "y",
            "baz": "z"
        ]
        
        APIs.echoJSONGet
            .setSubApi("/v1")
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expGet.fulfill()
            }
        
        APIs.echoJSONDelete
            .setSubApi("/v1")
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expDelete.fulfill()
            }
        
        APIs.echoJSONPatch
            .setSubApi("/v1")
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expPatch.fulfill()
            }
        
        APIs.echoJSONPost
            .setSubApi("/v1")
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expPost.fulfill()
            }
        
        APIs.echoJSONPut
            .setSubApi("/v1")
            .request(model) {
                XCTAssert($0.result.isSuccess)
                expPut.fulfill()
            }
        
        
        wait(for: [expGet, expDelete, expPatch, expPost, expPut], timeout: 10)
    }
    
    func testMock() {
        let exp = XCTestExpectation()
        
        let model = APIs.Echo(foo: "x", bar: "y", baz: "z")
        let mock = "http://127.0.0.1:8080/mock"
        
        APIs.api
            .setSubApi("/v1")
            .setMock(mock)
            .request(model) {
                // url
                XCTAssert($0.request?.url == URL(string: mock))
                
                // model
                XCTAssert($0.result.success == model)
                exp.fulfill()
            }
        
        wait(for: [exp], timeout: 10)
    }
    
    func testTimeoutInterval() {
        let expPost = XCTestExpectation()
        
        let timeoutInterval: TimeInterval = 2.0
        let model = APIs.Echo(foo: "x", bar: "y", baz: "z")
        
        APIs.timeInterval
            .setTimeoutInterval(timeoutInterval)
            .request(model) {
                XCTAssert($0.request?.timeoutInterval == timeoutInterval)
                expPost.fulfill()
            }
        
        wait(for: [expPost], timeout: 10)
    }
    
    func testCredential() {
        
    }
    
    func testRedirectHandler() {
        let exp = XCTestExpectation()
        
        let model = APIs.Echo(foo: "x", bar: "y", baz: "z")
        
        APIs.redirectFrom
            .setRedirectHandler(Alamofire.Redirector.follow)
            .request(model) {
                XCTAssert($0.result.success == model)
                exp.fulfill()
            }
        
        wait(for: [exp], timeout: 10)
    }
    
    func testValidation() {
        
    }
    
    func testCache() {
        let exp = XCTestExpectation()
        
        let model = APIs.Echo(foo: "x", bar: "y", baz: "z")
        
        APIs.api
            .setSubApi("/v1")
            .setCachedResponseHandler(ResponseCacher.doNotCache)
            .request(model) {
                XCTAssert(model == $0.result.success)
                XCTAssert(model != $0.cachedValue())
                exp.fulfill()
            }
        
        wait(for: [exp], timeout: 10)
    }
}
