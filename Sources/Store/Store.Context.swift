//
//  Store.Context.swift
//  

import Foundation
import Alamofire


extension Store {
    
    /// Context
    public final class _Context {
        
        // DataRequest Location
        let requestLocation: _Location
        
        // DataRequest
        let dataRequest = _Context._DataRequest()
        
        // DataResponse
        let dataResponse = _Context._DataResponse()
        
        // Accessing
        let accessing = _Context._Accessing()
        
        /// init
        init(requestLocation: _Location) {
            self.requestLocation = requestLocation
        }
    }
}


extension Store._Context {
    
    // MARK: _API
    final class _API {
        
        // Initial URL
        var initialURL: DataRequestModifier.InitialURL._Type?
        
        // Modify URL
        var base: Compute<String>?
        var appendPaths: [Compute<String>] = []
        var mock: Compute<String>?
        
        // Final URL
        var finalURL: String?
        
        // Method
        var method: Alamofire.HTTPMethod?
    }
    
    
    // MARK: _Request
    final class _DataRequest {
        
        // API
        let api = Store._Context._API()
        
        // Headers
        var headers: Alamofire.HTTPHeaders = Alamofire.HTTPHeaders()
        
        // Encoder/Encoding
        var encoder: Alamofire.ParameterEncoder?
        var encoding: Alamofire.ParameterEncoding?
        
        // URLRequest Modifiers
        var urlRequestModifiers: [MutatingAvailable<URLRequest>] = []
        
        // Authentication
        var authenticate: URLCredential?
        
        // Redirect
        var redirectHandler: Alamofire.RedirectHandler?
    }
    
    
    // MARK: _DataResponse
    final class _DataResponse {
        
        // Validate DataResponse
        var acceptableStatusCodes: Range<Int>?
        var acceptableContentTypes: Compute<[String]>?
        
        // Serialize DataResponse
        var serializeData = Store.SerializeData()
        var serializeString = Store.SerializeString()
        var serializeJSON = Store.SerializeJSON()
        var serializeDecodable = Store.SerializeDecodable()
        
        // Cache DataResponse
        var cacheHandler: Alamofire.CachedResponseHandler?
    }
    
    // MARK: _Accessing
    final class _Accessing {
        
        var onDataRequestAvailable: Available<Alamofire.DataRequest>?
    }
}
