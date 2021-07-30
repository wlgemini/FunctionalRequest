//
//  SettingAPITests.swift
//

import XCTest
@testable import Alamofire
@testable import FunctionalRequest


class SettingAPITests {
    
    // DataRequest
    @Setting.API(\.dataRequest.base)
    var base
    
    @Setting.API(\.dataRequest.headers)
    var headers
    
    @Setting.API(\.dataRequest.encoder.get)
    var encoder_get
    
    @Setting.API(\.dataRequest.encoder.delete)
    var encoder_delete
    
    @Setting.API(\.dataRequest.encoder.patch)
    var encoder_patch
    
    @Setting.API(\.dataRequest.encoder.post)
    var encoder_post
    
    @Setting.API(\.dataRequest.encoder.put)
    var encoder_put

    @Setting.API(\.dataRequest.encoding.get)
    var encoding_get
    
    @Setting.API(\.dataRequest.encoding.delete)
    var encoding_delete
    
    @Setting.API(\.dataRequest.encoding.patch)
    var encoding_patch
    
    @Setting.API(\.dataRequest.encoding.post)
    var encoding_post
    
    @Setting.API(\.dataRequest.encoding.put)
    var encoding_put

    @Setting.API(\.dataRequest.authenticate)
    var authenticate
    
    @Setting.API(\.dataRequest.redirect)
    var redirect
    
    // DataResponse
    @Setting.API(\.dataResponse.queue)
    var queue
    
    @Setting.API(\.dataResponse.acceptableStatusCodes)
    var acceptableStatusCodes
    
    @Setting.API(\.dataResponse.acceptableContentTypes)
    var acceptableContentTypes
    
    @Setting.API(\.dataResponse.serializeData.dataPreprocessor)
    var serializeData_dataPreprocessor
    
    @Setting.API(\.dataResponse.serializeData.emptyResponseCodes)
    var serializeData_emptyResponseCodes
    
    @Setting.API(\.dataResponse.serializeData.emptyRequestMethods)
    var serializeData_emptyRequestMethods
    
    @Setting.API(\.dataResponse.serializeString.dataPreprocessor)
    var serializeString_dataPreprocessor
    
    @Setting.API(\.dataResponse.serializeString.encoding)
    var serializeString_encoding
    
    @Setting.API(\.dataResponse.serializeString.emptyResponseCodes)
    var serializeString_emptyResponseCodes
    
    @Setting.API(\.dataResponse.serializeString.dataPreprocessor)
    var serializeString_emptyRequestMethods
    
    
    @Setting.API(\.dataResponse.serializeJSON.dataPreprocessor)
    var serializeJSON_dataPreprocessor
    
    @Setting.API(\.dataResponse.serializeJSON.emptyResponseCodes)
    var serializeJSON_emptyResponseCodes
    
    @Setting.API(\.dataResponse.serializeJSON.emptyRequestMethods)
    var serializeJSON_emptyRequestMethods
    
    @Setting.API(\.dataResponse.serializeJSON.options)
    var serializeJSON_options
    
    
    @Setting.API(\.dataResponse.serializeDecodable.dataPreprocessor)
    var serializeDecodable_dataPreprocessor
    
    @Setting.API(\.dataResponse.serializeDecodable.decoder)
    var serializeDecodable_decoder
    
    @Setting.API(\.dataResponse.serializeDecodable.emptyResponseCodes)
    var serializeDecodable_emptyResponseCodes
    
    @Setting.API(\.dataResponse.serializeDecodable.emptyRequestMethods)
    var serializeDecodable_emptyRequestMethods

    @Setting.API(\.dataResponse.cacheHandler)
    var cacheHandler
    
    
    func caseRequestMethod() {
        let contextEchoGet = APIs.echoGet._context(file: #fileID, line: #line)
        XCTAssert(contextEchoGet._method() == .get)
        
        let contextEchoDelete = APIs.echoDelete._context(file: #fileID, line: #line)
        XCTAssert(contextEchoDelete._method() == .delete)
        
        let contextEchoPatch = APIs.echoPatch._context(file: #fileID, line: #line)
        XCTAssert(contextEchoPatch._method() == .patch)
        
        let contextEchoPost = APIs.echoPost._context(file: #fileID, line: #line)
        XCTAssert(contextEchoPost._method() == .post)
        
        let contextEchoPut = APIs.echoPut._context(file: #fileID, line: #line)
        XCTAssert(contextEchoPut._method() == .put)
    }
    
    func caseRequestURL() {
        let BaseURL0 = "http://www.xyz.com/"
        let Path = "echo/"
        let FullURL = BaseURL0 + Path
        let AppendPath0 = "foo/"
        let AppendPath1 = "bar/"
        let AbsURL0 = BaseURL0 + Path + AppendPath0 + AppendPath1
        let MockURL = "http://www.mocking.com/mock/"
        
        do {
            // URL = FullURL + AppendPath
            let api0 = GET<Echo, Echo>(url: FullURL)
                .appendPath(AppendPath0)
                .appendPath(AppendPath1)
            let url0 = api0._context(file: #fileID, line: #line)._url()
            
            // URL = BaseURL + Path + AppendPath
            let api1 = GET<Echo, Echo>(Path)
                .base(BaseURL0)
                .appendPath(AppendPath0)
                .appendPath(AppendPath1)
            let url1 = api1._context(file: #fileID, line: #line)._url()
            
            XCTAssert(AbsURL0 == url0)
            XCTAssert(AbsURL0 == url1)
            
            // Mock
            let api2 = api0
                .mock(MockURL)
            let url2 = api2._context(file: #fileID, line: #line)._url()
            XCTAssert(MockURL == url2)
            
            let api3 = api1
                .mock(MockURL)
            let url3 = api3._context(file: #fileID, line: #line)._url()
            XCTAssert(MockURL == url3)
        }
        
        do {
            // Path + AppendPath
            let api0 = GET<Echo, Echo>(Path).appendPath(AppendPath0).appendPath(AppendPath1)
            let url0 = api0._context(file: #fileID, line: #line)._url()
            XCTAssert(url0 == nil)
            
            // Mock
            let api1 = api0
                .mock(MockURL)
            let url1 = api1._context(file: #fileID, line: #line)._url()
            XCTAssert(nil == url1)
        }
        
        do {
            // URL = BaseURL + Path + AppendPath
            let BaseURL1 = "http://www.abc.com/"
            let AbsURL1 = BaseURL1 + Path + AppendPath0 + AppendPath1
            self.base(BaseURL1)
            let api0 = GET<Echo, Echo>(Path).appendPath(AppendPath0).appendPath(AppendPath1)
            let url0 = api0._context(file: #fileID, line: #line)._url()
            XCTAssert(AbsURL1 == url0)
            
            // Mock
            let api1 = api0
                .mock(MockURL)
            let url1 = api1._context(file: #fileID, line: #line)._url()
            XCTAssert(MockURL == url1)
            
            // Path + AppendPath
            self.base(nil)
            let api2 = GET<Echo, Echo>(Path).appendPath(AppendPath0).appendPath(AppendPath1)
            let url2 = api2._context(file: #fileID, line: #line)._url()
            XCTAssert(nil == url2)
            
            // Mock
            let api3 = api2
                .mock(MockURL)
            let url3 = api3._context(file: #fileID, line: #line)._url()
            XCTAssert(nil == url3)
        }
    }

    
    func caseRequestHeaders() {
        let BaseURL = "http://www.xyz.com/"
        let Path = "echo/"
        let FullURL = BaseURL + Path
  
        let kv0 = ("X", "y")
        
        let kv1 = ["a": "0",
                   "b": "1",
                   "c": "2"]
        
        let kv2 = ["a": "3",
                   "b": "4",
                   "c": "5",
                   "d": "6",
                   "e": "7"]

        do {
            // Headers: []
            let api0 = GET<Echo, Echo>(url: FullURL).header(name: kv0.0, value: kv0.1)
            let header0 = api0._context(file: #file, line: #line)._headers()
            
            XCTAssert(header0.count == 1)
            XCTAssert(header0[kv0.0] == kv0.1)
            
            // Headers: kv1
            let api1 = api0.headers(kv1)
            let header1 = api1._context(file: #file, line: #line)._headers()
            
            XCTAssert(header1.count == kv1.count + 1)
            XCTAssert(header1[kv0.0] == kv0.1)
            
            for h in kv1 {
                XCTAssert(header1[h.key] == h.value)
            }
            
            // Headers: kv2
            let api2 = api1.headers(kv2)
            let header2 = api2._context(file: #file, line: #line)._headers()
            
            XCTAssert(header2.count == kv2.count + 1)
            XCTAssert(header2[kv0.0] == kv0.1)
            
            for h in kv2 {
                XCTAssert(header2[h.key] == h.value)
            }
        }
    }
    
    func caseRequestModifier() {
        
    }
    
}
