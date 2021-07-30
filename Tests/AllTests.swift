//
//  AllTests.swift
//  

import XCTest
import Alamofire
import FunctionalRequest


class AllTests: XCTestCase {
    
    let settingSessionTests = SettingSessionTests()
    let settingAPITests = SettingAPITests()
    
    func testALL() {
        // session
        settingSessionTests.case0SessionSetting()
        settingSessionTests.case1SessionInit()
        settingSessionTests.case2SessonNonmutating()
        
        // API
        settingAPITests.caseRequestMethod()
        settingAPITests.caseRequestURL()
        settingAPITests.caseRequestEncoding()
        settingAPITests.caseRequestEncoder()
        settingAPITests.caseRequestHeaders()
        settingAPITests.caseRequestModifier()
        settingAPITests.caseRequestModify()
        
        settingAPITests.caseResponseModify()
        settingAPITests.caseResponseQueue()
        settingAPITests.caseResponseDataResponseSerializer()
        settingAPITests.caseResponseStringResponseSerializer()
        settingAPITests.caseResponseJSONResponseSerializer()
        settingAPITests.caseResponseDecodableResponseSerializer()
        settingAPITests.caseAccessing()
    }
    
    func testRequest() {
        
    }
}
