//
//  Store.ModifyContext.swift
//

import Foundation
import Alamofire


extension Store {
    
    public final class ModifyContext {
        /// request location
        let requestLocation: _Location
        
        /// request api
        let forAPI = _ForAPI()
        
        /// request
        let forRequest = _ForRequest()

        /// data request
        let forDataRequest = _ForDataRequest()
        
        /// init
        init(requestLocation: _Location) {
            self.requestLocation = requestLocation
        }
    }
}

extension Store.ModifyContext {
    
    // MARK: _ForAPI
    final class _ForAPI {
        // Initial URL
        var initialURL: RM.InitialURL._Type?
        
        // Modify URL
        var base: Compute<String>?
        var appendPaths: [Compute<String>] = []
        var mock: Compute<String>?
        
        // Final URL
        var finalURL: String?
        
        // Method
        var method: Alamofire.HTTPMethod?
    }
    
    
    // MARK: _ForRequest
    final class _ForRequest {
        
        // uploadProgress
        var uploadProgress: (DispatchQueue, Alamofire.Request.ProgressHandler)?
        
        // downloadProgress
        var downloadProgress: (DispatchQueue, Alamofire.Request.ProgressHandler)?
        
        // redirect
        var redirectUsing: Alamofire.RedirectHandler?
        
        // cacheResponse
        var cacheResponseUsing: Alamofire.CachedResponseHandler?
        
        // authenticate
        var authenticate: RM.Authenticate._Type?
    }
    
    
    // MARK: _ForDataRequest
    final class _ForDataRequest {
        
    }
}
