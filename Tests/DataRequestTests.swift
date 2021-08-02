//
//  DataRequestTests.swift
//
//  WebServer: https://httpbin.org/
//

import XCTest
@testable import Alamofire
@testable import FunctionalRequest


class DataRequestTests {
    
    @Setting.API(\.dataRequest.base)
    var baseURL
    
    func method(test: XCTestCase) {
        // Given
        self.baseURL("https://httpbin.org")
        let expectation = XCTestExpectation(description: "")
        var response: DataResponse<Any, AFError>?
        let post = POST<[String: Any], Any>("/post")

        
        // When
        post.request(nil) { resp in
            response = resp
            expectation.fulfill()
        }
        
        test.wait(for: [expectation], timeout: 20)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertNotNil(response?.result)
        XCTAssertNil(response?.error)
    }
    
    func auth(test: XCTestCase) {
        // Given
        struct Auth: Decodable {
            var authenticated: Bool
            var user: String
        }
        
        self.baseURL("https://httpbin.org")
        let expectation = XCTestExpectation(description: "")
        var response: DataResponse<Auth, AFError>?
        let get = GET<[String: Any], Auth>("/basic-auth/some_user/somepassword")

        
        // When
        get.authenticate(username: "some_user", password: "somepassword").request(nil) { resp in
            response = resp
            expectation.fulfill()
        }
        
        test.wait(for: [expectation], timeout: 20)
        
        // Then
        XCTAssertNotNil(response)
        let user = try? response?.result.get().user
        let auth = try? response?.result.get().authenticated
        XCTAssert(user == "some_user" && auth == true)
        XCTAssertNil(response?.error)
    }
    
    func statusCodes(test: XCTestCase) {
        // Given
        self.baseURL("https://httpbin.org")
        let expectation = XCTestExpectation(description: "")
        var response: DataResponse<Any, AFError>?
        let get = GET<[String: Any], Any>("/status/400")
        
        // When
        get.request(nil) { resp in
            response = resp
            expectation.fulfill()
        }
        
        test.wait(for: [expectation], timeout: 20)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssert(response?.response?.statusCode == 400)
    }
    
    func headers(test: XCTestCase) {
        // Given
        struct Body: Decodable {
            struct Headers: Decodable {
                let Abc: String
                let Def: String
            }
            
            let headers: Headers
        }
        
        self.baseURL("https://httpbin.org")
        let expectation = XCTestExpectation(description: "")
        var response: DataResponse<Body, AFError>?
        let get = GET<[String: Any], Body>("/headers")
        
        // When
        get
            .headers(["Abc": "1", "Def": "2"]).request(nil) { resp in
            response = resp
            expectation.fulfill()
        }
        
        test.wait(for: [expectation], timeout: 20)
        
        // Then
        XCTAssertNotNil(response)
        let body = try? response?.result.get()
        XCTAssert(body?.headers.Abc == "1")
        XCTAssert(body?.headers.Def == "2")
    }
}

