//
//  Store.ModifierContext.swift
//

import Foundation
import Alamofire


extension Store {
    
    public final class ModifierContext {
        /// request location
        let requestLocation: _Location
        
        let forAPI = _ForAPI()
        
        let forRequest = _ForRequest()

        let forDataRequest = _ForDataRequest()

        let forDataStreamRequest = _ForDataStreamRequest()

        let forUploadRequest = _ForUploadRequest()

        let forDownloadRequest = _ForDownloadRequest()
        
        /// init
        init(requestLocation: _Location) {
            self.requestLocation = requestLocation
        }
    }
}

extension Store.ModifierContext {
    
    // MARK: _ForAPI
    final class _ForAPI {
        // Initial URL
        var initialURL: InitialURL._Type?
        
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
        var authenticate: AuthenticateType?
    }
    
    
    // MARK: _ForDataRequest
    final class _ForDataRequest {
        
    }
    
    
    // MARK: _ForDataStreamRequest
    final class _ForDataStreamRequest {
        
    }
    
    
    // MARK: _ForUploadRequest
    final class _ForUploadRequest {
        
    }
    
    // MARK: _ForDownloadRequest
    final class _ForDownloadRequest {
        
    }
    
}
