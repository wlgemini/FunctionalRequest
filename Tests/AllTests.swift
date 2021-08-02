//
//  AllTests.swift
//  

import XCTest
import Alamofire
import FunctionalRequest


class AllTests: XCTestCase {
    
    let settingSession = SettingSessionTests()
    let settingAPI = SettingAPITests()
    let dataRequest = DataRequestTests()
    
    func testALL() {
        // Session
        settingSession.sessionSetting()
        settingSession.sessionInit()
        settingSession.sessionNonmutating()
        
        
        // API
        settingAPI.requestMethod()
        settingAPI.requestURL()
        settingAPI.requestEncoding()
        settingAPI.requestEncoder()
        settingAPI.requestHeaders()
        settingAPI.requestModifier()
        settingAPI.requestModify()
        
        settingAPI.responseModify()
        settingAPI.responseQueue()
        settingAPI.responseDataResponseSerializer()
        settingAPI.responseStringResponseSerializer()
        settingAPI.responseJSONResponseSerializer()
        settingAPI.responseDecodableResponseSerializer()
        settingAPI.accessing()
        
        
        // DataRequest
        dataRequest.method(test: self)
        dataRequest.auth(test: self)
        dataRequest.statusCodes(test: self)
        dataRequest.headers(test: self)
    }
}
