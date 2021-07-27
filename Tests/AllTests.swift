//
//  AllTests.swift
//  

import XCTest
@testable import Alamofire
@testable import FunctionalRequest


class AllTests: XCTestCase {
    
    let settingSessionTests = SettingSessionTests()
    let settingAPITests = SettingAPITests()
    
    func testSession() {
        settingSessionTests.case0SessionSetting()
        settingSessionTests.case1SessionInit()
        settingSessionTests.case2SessonNonmutating()
    }
    
    func testAPI() {
        
        
    }

}
