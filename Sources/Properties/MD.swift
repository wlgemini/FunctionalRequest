


//@propertyWrapper
//@dynamicMemberLookup
//struct KeyPathProperty<O, V> {
//
//    let value: O
//
//    public subscript<V>(dynamicMember keyPath: ReferenceWritableKeyPath<O, V>) -> Binding<V> {
//        return value[keyPath]
//    }
//}



/*
 Store:
 1. Session
 
 
 Property:
 1. Session:
    - access default Session
    - modify default Session's property before session initiate
 
 2. Request:
     - make function call:
        - resume()
        - suspend()
        - cancel()
        - etc
     - modify default DataRequest's property:
        - Progress:
            - uploadProgress
            - downloadProgress
        - Handling Redirects
        - Customizing Caching
        - Credentials
        - Lifetime Values
            - URLRequests
            - URLSessionTasks
        - Response
 
    1. DataRequest: Request
        - Additional State
            - data: Data
            - convertible:
                - URLRequestConvertible
        - Validation:
            - validate()
 
    2. DataStreamRequest: Request
        - Additional State
            - none
        - Validation:
            - validate()
        
    3. UploadRequest: DataRequest
        - Additional State:
            - fileManager
            - upload
                - URLRequestConvertible
                - Uploadable
 
    4. DownloadRequest: Request
        - Additional State:
            - resumeData
            - fileURL
        - Cancellation
            - cancel(producingResumeData shouldProduceResumeData: Bool)
            - cancel(byProducingResumeData completionHandler: @escaping (_ data: Data?) -> Void)
            - cancel()
        - Validation
            - typealias Validation = (_ request: URLRequest?, _ response: HTTPURLResponse, _ fileURL: URL?)
 
    5. Response Handling
        - Handling Responses Without Serialization
        - Response Serializer:
            - DataResponseSerializerProtocol
            - DownloadResponseSerializerProtocol
            * responseData
            * responseString
            * responseJSON
            * responseDecodable
    
            - DataStreamRequest
 
    6. Combine
 
    7. Network Reachability
    
 */


