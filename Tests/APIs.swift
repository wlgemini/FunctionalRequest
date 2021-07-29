////
////  APIs.swift
////  FunctionalRequestTests
////
////  Created by wangluguang on 2021/3/2.
////

import Foundation
import FunctionalRequest


enum APIs {
    
    static let echoGet = GET<Echo, Echo>("echo")
    static let echoDelete = DELETE<Echo, Echo>("echo")
    static let echoPatch = PATCH<Echo, Echo>("echo")
    static let echoPost = POST<Echo, Echo>("echo")
    static let echoPut = PUT<Echo, Echo>("echo")
    
    static let echoJSONGet = GET<[String: Any], Any>("echo")
    static let echoJSONDelete = DELETE<[String: Any], Any>("echo")
    static let echoJSONPatch = PATCH<[String: Any], Any>("echo")
    static let echoJSONPost = POST<[String: Any], Any>("echo")
    static let echoJSONPut = PUT<[String: Any], Any>("echo")
    
    static let redirectFrom = POST<Echo, Echo>("redirectFrom")
    static let redirectTo = POST<Echo, Echo>("redirectTo")
}
