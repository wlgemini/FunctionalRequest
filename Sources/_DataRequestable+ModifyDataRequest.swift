//
//  _DataRequestable+ModifyDataRequest.swift
//  FunctionalRequest
//
//  Created by wangluguang on 2021/3/1.
//

import Foundation
import Alamofire


// MARK: - Modify DataRequest
internal extension DataRequestable {
    
    /// 修改URLRequest
    func _modifyURLRequest() -> (_ req: inout URLRequest) throws -> Void {
        let timeoutInterval = self._timeoutInterval
        
        // NOTE: Make sure not access `self` in block
        return { (req) in
            // timeoutInterval
            if let timeoutInterval = timeoutInterval() {
                req.timeoutInterval = timeoutInterval
            }
        }
    }
    
    /// 修改Request
    func _modifyRequest(_ req: Alamofire.Request) {
        // credential
        if let credential = self._credential() {
            req.authenticate(with: credential)
        }
        
        // redirect
        if let redirectHandler = self._redirectHandler() {
            req.redirect(using: redirectHandler)
        }
        
        // cacheResponse
        if let cachedResponseHandler = self._cachedResponseHandler() {
            req.cacheResponse(using: cachedResponseHandler)
        }
    }
    
    /// 修改DataRequest
    func _modifyDataRequest(_ req: Alamofire.DataRequest) {
        // validate
        if let validation = self._validation() {
            req.validate(validation)
        } else {
            req.validate()
        }
    }
}
