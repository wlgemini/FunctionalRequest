//
//  APIs.swift
//  FunctionalRequestTests
//
//  Created by wangluguang on 2021/3/2.
//

import Foundation
import FunctionalRequest


enum APIs {
    
    static let echoGet = GET<Echo, Echo>("echo")
    static let echoDelete = DELETE<Echo, Echo>("echo")
    static let echoPatch = PATCH<Echo, Echo>("echo")
    static let echoPost = POST<Echo, Echo>("echo")
    static let echoPut = PUT<Echo, Echo>("echo")
    
    static let echoJSONGet = GET<JSON, JSON>("echo")
    static let echoJSONDelete = DELETE<JSON, JSON>("echo")
    static let echoJSONPatch = PATCH<JSON, JSON>("echo")
    static let echoJSONPost = POST<JSON, JSON>("echo")
    static let echoJSONPut = PUT<JSON, JSON>("echo")
    
    static let redirectFrom = POST<Echo, Echo>("redirectFrom")
    static let redirectTo = POST<Echo, Echo>("redirectTo")
}
