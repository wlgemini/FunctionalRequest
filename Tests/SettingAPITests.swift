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
    
    func case0NonSettingDataRequest() {
        
    }
    
    func case0SettingDataRequest() {
        self.base("http://www.xyz.com")
        self.headers(["x": "1", "y": "2", "z": "3"])
        
    }
}
