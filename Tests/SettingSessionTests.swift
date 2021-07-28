//
//  SettingSessionTests.swift
//

import XCTest
@testable import Alamofire
@testable import FunctionalRequest


class SettingSessionTests {
    
    @Setting.Session(\.configuration)
    var configuration
    
    @Setting.Session(\.requestQueue)
    var requestQueue
    
    @Setting.Session(\.serializationQueue)
    var serializationQueue
    
    @Setting.Session(\.interceptor)
    var interceptor
    
    @Setting.Session(\.serverTrustManager)
    var serverTrustManager
    
    @Setting.Session(\.redirectHandler)
    var redirectHandler
    
    @Setting.Session(\.cachedResponseHandler)
    var cachedResponseHandler
    
    @Setting.Session(\.eventMonitors)
    var eventMonitors
    
    @Getting.Session
    var session
    
    
    func case0SessionSetting() {
        // session not finalized
        XCTAssert(Store._sessionFinalized == false, "session finalized")
        
        self.configuration(URLSessionConfiguration.af.default)
        self.requestQueue(DispatchQueue(label: "FunctionalRequest.Session.requestQueue"))
        self.serializationQueue(DispatchQueue(label: "FunctionalRequest.Session.serializationQueue"))
        self.interceptor(Alamofire.Interceptor())
        self.serverTrustManager(Alamofire.ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:]))
        self.redirectHandler(Alamofire.Redirector.doNotFollow)
        self.cachedResponseHandler(Alamofire.ResponseCacher.doNotCache)
        self.eventMonitors([Alamofire.ClosureEventMonitor()])
        
        // session not finalized
        XCTAssert(Store._sessionFinalized == false, "session finalized")
    }
    
    func case1SessionInit() {
        // session not finalized
        XCTAssert(Store._sessionFinalized == false, "session finalized")
        
        // session finalized
        let sessionRaw = Store._sessionRaw
        
        // session finalized
        XCTAssert(Store._sessionFinalized == true, "session not finalized")
        
        // URLSessionConfiguration.af.default
        for header in sessionRaw.sessionConfiguration.headers {
            XCTAssert(self.configuration.value.headers.contains(header), "configuration.header not match")
        }
        
        // requestQueue
        XCTAssert(sessionRaw.requestQueue.label == self.requestQueue.value?.label, "requestQueue not equal")
        
        // serializationQueue
        XCTAssert(sessionRaw.serializationQueue.label == self.serializationQueue.value?.label, "serializationQueue not equal")
        
        // interceptor
        XCTAssert(sessionRaw.interceptor != nil && self.interceptor.value != nil, "interceptor is nil")
        
        // serverTrustManager
        XCTAssert(sessionRaw.serverTrustManager === self.serverTrustManager.value, "serverTrustManager not equal")
        
        // redirectHandler
        XCTAssert(sessionRaw.redirectHandler != nil && self.redirectHandler.value != nil, "redirectHandler is nil")
        
        // cachedResponseHandler
        XCTAssert(sessionRaw.cachedResponseHandler != nil && self.redirectHandler.value != nil, "cachedResponseHandler is nil")
        
        // eventMonitors
        let isMonitorsEqual = sessionRaw.eventMonitor.monitors.count == sessionRaw.defaultEventMonitors.count + (self.eventMonitors.value?.count ?? 0)
        XCTAssert(isMonitorsEqual, "eventMonitors not equal")
    }
    
    func case2SessonNonmutating() {
        // session finalized
        XCTAssert(Store._sessionFinalized == true, "session not finalized")
        
        self.requestQueue(nil)
        XCTAssert(self.requestQueue.value != nil, "requestQueue is nil")
    }
}
