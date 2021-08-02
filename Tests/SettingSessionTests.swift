//
//  SettingSessionTests.swift
//

import XCTest
@testable import Alamofire
import FunctionalRequest


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
    
    @Getting.Session(\.never)
    var session
    
    
    func sessionSetting() {
        // session not finalized
        XCTAssert(self.$session.session == nil, "session finalized")
        
        self.configuration(URLSessionConfiguration.af.default)
        self.requestQueue(DispatchQueue(label: "requestQueue"))
        self.serializationQueue(DispatchQueue(label: "serializationQueue"))
        self.interceptor(Alamofire.Interceptor())
        self.serverTrustManager(Alamofire.ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:]))
        self.redirectHandler(Alamofire.Redirector.doNotFollow)
        self.cachedResponseHandler(Alamofire.ResponseCacher.doNotCache)
        self.eventMonitors([Alamofire.ClosureEventMonitor()])
    }
    
    func sessionInit() {
        // session not finalized
        XCTAssert(self.$session.session == nil, "session finalized")
        
        // session finalize
        self.$session.finalize()
        
        // session finalized
        XCTAssert(self.$session.session != nil, "session not finalized")
        
        // URLSessionConfiguration.af.default
        for header in self.$session.finalize().sessionConfiguration.headers {
            XCTAssert(self.configuration.value.headers.contains(header), "configuration.header not match")
        }
        
        // requestQueue
        XCTAssert(self.$session.finalize().requestQueue.label == self.requestQueue.value?.label, "requestQueue not equal")
        
        // serializationQueue
        XCTAssert(self.$session.finalize().serializationQueue.label == self.serializationQueue.value?.label, "serializationQueue not equal")
        
        // interceptor
        XCTAssert(self.$session.finalize().interceptor != nil && self.interceptor.value != nil, "interceptor is nil")
        
        // serverTrustManager
        XCTAssert(self.$session.finalize().serverTrustManager === self.serverTrustManager.value, "serverTrustManager not equal")
        
        // redirectHandler
        XCTAssert(self.$session.finalize().redirectHandler != nil && self.redirectHandler.value != nil, "redirectHandler is nil")
        
        // cachedResponseHandler
        XCTAssert(self.$session.finalize().cachedResponseHandler != nil && self.redirectHandler.value != nil, "cachedResponseHandler is nil")
        
        // eventMonitors
        let isMonitorsEqual = self.$session.finalize().eventMonitor.monitors.count == self.$session.finalize().defaultEventMonitors.count + (self.eventMonitors.value?.count ?? 0)
        XCTAssert(isMonitorsEqual, "eventMonitors not equal")
    }
    
    func sessionNonmutating() {
        // session finalized
        XCTAssert(self.$session.session != nil, "session not finalized")
        
        self.requestQueue(nil)
        XCTAssert(self.requestQueue.value != nil, "requestQueue is nil")
    }
}
