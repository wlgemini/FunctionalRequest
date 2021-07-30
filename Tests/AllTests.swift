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
        settingAPITests.caseRequestHeaders()
        settingAPITests.caseRequestModifier()
    }
}
