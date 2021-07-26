//
//  SettingAPITests.swift
//

import XCTest
@testable import Alamofire
@testable import FunctionalRequest


class SettingAPITests: SessionTests {
    
    // DataRequest
    @Setting.API(\.dataRequest.base)
    var base
    
    /// for `get` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
    @Setting.API(\.dataRequest.encoder.get)
    var encoder_get
    
    /// for `delete` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
    @Setting.API(\.dataRequest.encoder.delete)
    var encoder_delete
    
    /// for `patch` encoder. default: `Alamofire.JSONParameterEncoder.default`
    @Setting.API(\.dataRequest.encoder.patch)
    var encoder_patch
    
    /// for `post` encoder. default: `Alamofire.JSONParameterEncoder.default`
    @Setting.API(\.dataRequest.encoder.post)
    var encoder_post
    
    /// for `put` encoder. default: `Alamofire.JSONParameterEncoder.default`
    @Setting.API(\.dataRequest.encoder.put)
    var encoder_put

    /// for `get` encoding. default: `Alamofire.URLEncoding.default`
    @Setting.API(\.dataRequest.encoding.get)
    var encoding_get
    
    /// for `delete` encoding. default: `Alamofire.URLEncoding.default`
    @Setting.API(\.dataRequest.encoding.delete)
    var encoding_delete
    
    /// for `patch` encoding. default: `Alamofire.JSONEncoding.default`
    @Setting.API(\.dataRequest.encoding.patch)
    var encoding_patch
    
    /// for `post` encoding. default: `Alamofire.JSONEncoding.default`
    @Setting.API(\.dataRequest.encoding.post)
    var encoding_post
    
    /// for `put` encoding. default: `Alamofire.JSONEncoding.default`
    @Setting.API(\.dataRequest.encoding.put)
    var encoding_put

    @Setting.API(\.dataRequest.authenticate)
    var authenticate
    
    @Setting.API(\.dataRequest.redirect)
    var redirect
    
    // DataResponse
    /// default: .main
    @Setting.API(\.dataResponse.queue)
    var queue
    
    /// default acceptable range: 200 ... 299
    @Setting.API(\.dataResponse.acceptableStatusCodes)
    var acceptableStatusCodes
    
    /// default acceptable content type: matches any specified in the Accept HTTP header field.
    @Setting.API(\.dataResponse.acceptableContentTypes)
    var acceptableContentTypes
    
    /// default `Alamofire.DataResponseSerializer.defaultDataPreprocessor`
    @Setting.API(\.dataResponse.serializeData.dataPreprocessor)
    var serializeData_dataPreprocessor
    
    /// default `Alamofire.DataResponseSerializer.defaultEmptyResponseCodes`
    @Setting.API(\.dataResponse.serializeData.emptyResponseCodes)
    var serializeData_emptyResponseCodes
    
    /// default `Alamofire.DataResponseSerializer.defaultEmptyRequestMethods`
    @Setting.API(\.dataResponse.serializeData.emptyRequestMethods)
    var serializeData_emptyRequestMethods
    
    /// default `Alamofire.StringResponseSerializer.defaultDataPreprocessor`
    @Setting.API(\.dataResponse.serializeString.dataPreprocessor)
    var serializeString_dataPreprocessor
    
    /// default `nil`
    @Setting.API(\.dataResponse.serializeString.encoding)
    var serializeString_encoding
    
    /// default `Alamofire.StringResponseSerializer.defaultEmptyResponseCodes`
    @Setting.API(\.dataResponse.serializeString.emptyResponseCodes)
    var serializeString_emptyResponseCodes
    
    /// default `Alamofire.StringResponseSerializer.defaultEmptyRequestMethods`
    @Setting.API(\.dataResponse.serializeString.dataPreprocessor)
    var serializeString_emptyRequestMethods
    
    
    /// default `Alamofire.JSONResponseSerializer.defaultDataPreprocessor`
    @Setting.API(\.dataResponse.serializeJSON.dataPreprocessor)
    var serializeJSON_dataPreprocessor
    
    /// default `Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes`
    @Setting.API(\.dataResponse.serializeJSON.emptyResponseCodes)
    var serializeJSON_emptyResponseCodes
    
    /// default `Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods`
    @Setting.API(\.dataResponse.serializeJSON.emptyRequestMethods)
    var serializeJSON_emptyRequestMethods
    
    /// default `.allowFragments`
    @Setting.API(\.dataResponse.serializeJSON.options)
    var serializeJSON_options
    
    
    /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultDataPreprocessor`
    @Setting.API(\.dataResponse.serializeDecodable.dataPreprocessor)
    var serializeDecodable_dataPreprocessor
    
    /// default `JSONDecoder`
    @Setting.API(\.dataResponse.serializeDecodable.decoder)
    var serializeDecodable_decoder
    
    /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyResponseCodes`
    @Setting.API(\.dataResponse.serializeDecodable.emptyResponseCodes)
    var serializeDecodable_emptyResponseCodes
    
    /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyRequestMethods`
    @Setting.API(\.dataResponse.serializeDecodable.emptyRequestMethods)
    var serializeDecodable_emptyRequestMethods

    @Setting.API(\.dataResponse.cacheHandler)
    var cacheHandler
}
