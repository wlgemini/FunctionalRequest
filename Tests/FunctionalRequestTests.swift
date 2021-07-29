//import XCTest
//@testable import FunctionalRequest
//@testable import Alamofire
//
//
//final class FunctionalRequestTests: XCTestCase {
//    
//    static var allTests = [
//        ("testAPI", testAPI),
//        ("testParamsModelEncode", testParamsModelEncode),
//        ("testParamsJSONEncode", testParamsJSONEncode),
//        ("testMock", testMock),
//        ("testTimeoutInterval", testTimeoutInterval),
//        ("testCredential", testCredential),
//        ("testRedirectHandler", testRedirectHandler),
//        ("testValidation", testValidation),
//        ("testCache", testCache)
//    ]
//    
//    override class func setUp() {
//        
//        // eventMonitors
//        let monitor = Alamofire.ClosureEventMonitor()
//        monitor.requestDidFinish = { print($0.metrics) }
//        FunctionalRequest.Configuration.eventMonitors = [monitor]
//        
//        // base
//        FunctionalRequest.Configuration.DataRequest.base = { Domain.base }
//        
//        // header
//        FunctionalRequest.Configuration.DataRequest.headers = { Headers.defaultHeaders }
//        
//        // timeoutInterval
//        FunctionalRequest.Configuration.DataRequest.timeoutInterval = { 10.0 }
//        
//        // credential
//        FunctionalRequest.Configuration.DataRequest.credential = { nil }
//        
//        // redirectHandler
//        FunctionalRequest.Configuration.DataRequest.redirectHandler = { Alamofire.Redirector(behavior: .follow) }
//    }
//}
//
//
//
//
//extension FunctionalRequestTests {
//    
//    // GET: base & api & subApi & header
//    func testAPI() {
//
//        let expPost = XCTestExpectation()
//        
//        APIs.echoPost
//            .setSubApi("/v1")
//            .setAdditionalHeaders(Headers.moreHeaders)
//            .request(Models.echo) {
//                // url
//                XCTAssert($0.request?.url == URL(string: Domain.base + APIs.echoPost.modifier.api + "/v1"))
//                
//                // defaultHeaders
//                for h in Headers.defaultHeaders {
//                    XCTAssert($0.request?.headers[h.name] == h.value)
//                }
//                
//                // moreHeaders
//                for h in Headers.moreHeaders {
//                    XCTAssert($0.request?.headers[h.name] == h.value)
//                }
//                
//                expPost.fulfill()
//            }
//        
//        wait(for: [expPost], timeout: 10)
//    }
//    
//    func testParamsModelEncode() {
//        let expGet = XCTestExpectation()
//        let expDelete = XCTestExpectation()
//        let expPatch = XCTestExpectation()
//        let expPost = XCTestExpectation()
//        let expPut = XCTestExpectation()
//        
//        APIs.echoGet
//            .request(Models.echo) {
//                XCTAssert($0.result.isSuccess)
//                XCTAssert($0.result.success == Models.echo)
//                expGet.fulfill()
//            }
//        
//        APIs.echoDelete
//            .request(Models.echo) {
//                XCTAssert($0.result.isSuccess)
//                XCTAssert($0.result.success == Models.echo)
//                expDelete.fulfill()
//            }
//        
//        APIs.echoPatch
//            .request(Models.echo) {
//                XCTAssert($0.result.isSuccess)
//                XCTAssert($0.result.success == Models.echo)
//                expPatch.fulfill()
//            }
//        
//        APIs.echoPost
//            .request(Models.echo) {
//                XCTAssert($0.result.isSuccess)
//                XCTAssert($0.result.success == Models.echo)
//                expPost.fulfill()
//            }
//        
//        APIs.echoPut
//            .request(Models.echo) {
//                XCTAssert($0.result.isSuccess)
//                XCTAssert($0.result.success == Models.echo)
//                expPut.fulfill()
//            }
//        
//        wait(for: [expGet, expDelete, expPatch, expPost, expPut], timeout: 10)
//    }
//    
//    func testParamsJSONEncode() {
//        
//        let expGet = XCTestExpectation()
//        let expDelete = XCTestExpectation()
//        let expPatch = XCTestExpectation()
//        let expPost = XCTestExpectation()
//        let expPut = XCTestExpectation()
//        
//        APIs.echoJSONGet
//            .request(Models.echoJSON) {
//                XCTAssert($0.result.isSuccess)
//                expGet.fulfill()
//            }
//        
//        APIs.echoJSONDelete
//            .request(Models.echoJSON) {
//                XCTAssert($0.result.isSuccess)
//                expDelete.fulfill()
//            }
//        
//        APIs.echoJSONPatch
//            .request(Models.echoJSON) {
//                XCTAssert($0.result.isSuccess)
//                expPatch.fulfill()
//            }
//        
//        APIs.echoJSONPost
//            .request(Models.echoJSON) {
//                XCTAssert($0.result.isSuccess)
//                expPost.fulfill()
//            }
//        
//        APIs.echoJSONPut
//            .request(Models.echoJSON) {
//                XCTAssert($0.result.isSuccess)
//                expPut.fulfill()
//            }
//        
//        
//        wait(for: [expGet, expDelete, expPatch, expPost, expPut], timeout: 10)
//    }
//    
//    func testMock() {
//        let exp = XCTestExpectation()
//        
//        let mock = "http://127.0.0.1:8080/mock"
//        
//        APIs.echoPost
//            .setMock(mock)
//            .request(Models.echo) {
//                // url
//                XCTAssert($0.request?.url == URL(string: mock))
//                
//                // model
//                XCTAssert($0.result.success == Models.echo)
//                exp.fulfill()
//            }
//        
//        wait(for: [exp], timeout: 10)
//    }
//    
//    func testTimeoutInterval() {
//        let expPost = XCTestExpectation()
//        
//        let timeoutInterval: TimeInterval = 2.0
//        
//        APIs.echoGet
//            .setTimeoutInterval(timeoutInterval)
//            .request(Models.echo) {
//                XCTAssert($0.request?.timeoutInterval == timeoutInterval)
//                expPost.fulfill()
//            }
//        
//        wait(for: [expPost], timeout: 10)
//    }
//    
//    func testCredential() {
//        
//    }
//    
//    func testRedirectHandler() {
//        let exp = XCTestExpectation()
//        
//        APIs.echoPost
//            .setRedirectHandler(Alamofire.Redirector.follow)
//            .request(Models.echo) {
//                XCTAssert($0.result.success == Models.echo)
//                exp.fulfill()
//            }
//        
//        wait(for: [exp], timeout: 10)
//    }
//    
//    func testValidation() {
//        
//    }
//    
//    func testCache() {
//        let exp = XCTestExpectation()
//        
//        APIs.echoPost
//            .setCachedResponseHandler(ResponseCacher.doNotCache)
//            .request(Models.echo) {
//                XCTAssert(Models.echo == $0.result.success)
//                XCTAssert(Models.echo != $0.cachedValue())
//                exp.fulfill()
//            }
//        
//        wait(for: [exp], timeout: 10)
//    }
//}
