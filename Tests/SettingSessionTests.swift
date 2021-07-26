//
//  SettingSessionTests.swift
//

import XCTest
@testable import Alamofire
@testable import FunctionalRequest


class SessionTests: XCTestCase {
    
    @Setting.Session(\.configuration)
    static var configuration
    
    @Setting.Session(\.requestQueue)
    static var requestQueue
    
    @Setting.Session(\.serializationQueue)
    static var serializationQueue
    
    @Setting.Session(\.interceptor)
    static var interceptor
    
    @Setting.Session(\.serverTrustManager)
    static var serverTrustManager
    
    @Setting.Session(\.redirectHandler)
    static var redirectHandler
    
    @Setting.Session(\.cachedResponseHandler)
    static var cachedResponseHandler
    
    @Setting.Session(\.eventMonitors)
    static var eventMonitors
    
    @Setting.Session(\.shared)
    static var shared
    
    override class func setUp() {
        self.configuration = URLSessionConfiguration.af.default
        self.requestQueue = DispatchQueue(label: "FunctionalRequest.Session.requestQueue")
        self.serializationQueue = DispatchQueue(label: "FunctionalRequest.Session.serializationQueue")
        self.interceptor = Alamofire.Interceptor()
        self.serverTrustManager = Alamofire.ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:])
        self.redirectHandler = Alamofire.Redirector.doNotFollow
        self.cachedResponseHandler = Alamofire.ResponseCacher.doNotCache
        self.eventMonitors = [Alamofire.ClosureEventMonitor()]
    }
    
    func testSessionFinalized() {
        
        // session not finalized
        XCTAssert(Store._sessionFinalized == false, "session finalized")
        
        // session finalized
        let sessionRaw = Store._sessionRaw
        
        // session finalized
        XCTAssert(Store._sessionFinalized == true, "session not finalized")
        
        // URLSessionConfiguration.af.default
        for header in sessionRaw.sessionConfiguration.headers {
            XCTAssert(Self.configuration.headers.contains(header), "configuration.header not match")
        }
        
        // requestQueue
        XCTAssert(sessionRaw.requestQueue.label == Self.requestQueue?.label, "requestQueue not equal")
        
        // serializationQueue
        XCTAssert(sessionRaw.serializationQueue.label == Self.serializationQueue?.label, "serializationQueue not equal")
        
        // interceptor
        XCTAssert(sessionRaw.interceptor != nil && Self.interceptor != nil, "interceptor is nil")
        
        // serverTrustManager
        XCTAssert(sessionRaw.serverTrustManager === Self.serverTrustManager, "serverTrustManager not equal")
        
        // redirectHandler
        XCTAssert(sessionRaw.redirectHandler != nil && Self.redirectHandler != nil, "redirectHandler is nil")
        
        // cachedResponseHandler
        XCTAssert(sessionRaw.cachedResponseHandler != nil && Self.redirectHandler != nil, "cachedResponseHandler is nil")
        
        // eventMonitors
        let isMonitorsEqual = sessionRaw.eventMonitor.monitors.count == sessionRaw.defaultEventMonitors.count + (Self.eventMonitors?.count ?? 0)
        XCTAssert(isMonitorsEqual, "eventMonitors not equal")
    }
    
    func testSettingSessionAfterSessionFinalized() {
        // session finalized
        XCTAssert(Store._sessionFinalized == true, "session not finalized")
        
        Self.requestQueue = nil
        XCTAssert(Self.requestQueue != nil, "requestQueue is nil")
    }
}
