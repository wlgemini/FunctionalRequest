//
//  Store.ModifierContext.swift
//

import Foundation
import Alamofire


extension Store {
    
    public final class ModifierContext {
        
        let forAPI = _ForAPI()
        
        let forRequest = _ForRequest()

        let forDataRequest = _ForDataRequest()

        let forDataStreamRequest = _ForDataStreamRequest()

        let forUploadRequest = _ForUploadRequest()

        let forDownloadRequest = _ForDownloadRequest()
        
        /// init
        init() { }
    }
}

extension Store.ModifierContext {
    
    // MARK: _ForAPI
    final class _ForAPI {
        var paths: [String] = []
        var base: Compute<String>?
        
        var url: String?
        var mock: String?
        var method: Alamofire.HTTPMethod?
    }
    
    
    // MARK: _ForRequest
    final class _ForRequest {
        
        // uploadProgress
        var uploadProgressQueue: DispatchQueue?
        var uploadProgressClosure: Alamofire.Request.ProgressHandler?
        
        // downloadProgress
        var downloadProgressQueue: DispatchQueue?
        var downloadProgressClosure: Alamofire.Request.ProgressHandler?
        
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
