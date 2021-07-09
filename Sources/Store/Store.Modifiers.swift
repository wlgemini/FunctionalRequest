//
//  Store.Modifiers.swift
//

import Alamofire


extension Store {
    
    public final class Modifiers {
        
        // MARK: Internal
        /// url
        var urls: [URLType] = []
        
        /// Request
        var request: Alamofire.Request?
        
        /// DataRequest: Request
        var dataRequest: Alamofire.DataRequest?
        
        /// DataStreamRequest: Request
        var dataStreamRequest: Alamofire.DataStreamRequest?
        
        /// UploadRequest: DataRequest
        var uploadRequest: Alamofire.UploadRequest?
        
        /// DownloadRequest: Request
        var downloadRequest: Alamofire.DownloadRequest?
        
        /// init
        init() { }
    }
}
