
/* Store:
 */




/* Config:
 1. Session:
    - access default config
    - modify default config before session initiate
 
 2. Request:
    - access/modify default config
 */




/* Access Request instance:
    - resume()
    - suspend()
    - cancel()
    - etc
 
 - DataRequest: Request
 - DataStreamRequest: Request
 - UploadRequest: DataRequest
 - DownloadRequest: Request
 */





/* Response Handling:
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







/*
// MARK: - Make URLRequest
// URL/Method
GET<P, R>(path/full)
.base()
.mock()
 
// Headers
.headers([k:v])

// Encode
.encoder() where ?
.encoding() where ?

// RequestModifier ?
.requestModifier()





// MARK: - Request Mid
// Authenticate
.authenticate(username: String, password: String, persistence: URLCredential.Persistence = .forSession)
.authenticate(with credential: URLCredential)

// Progress
.uploadProgress(queue: DispatchQueue, closure: @escaping ProgressHandler)
.downloadProgress(queue: DispatchQueue, closure: @escaping ProgressHandler)

// Redirect
.redirect(using handler: RedirectHandler)

// CacheResponse
.cacheResponse(using handler: CachedResponseHandler)

// cURLDescription
.cURLDescription(on queue: DispatchQueue, calling handler: @escaping (String) -> Void)


// onURLRequestCreation
onURLRequestCreation(on queue: DispatchQueue = .main, perform handler: @escaping (URLRequest) -> Void)

// onURLSessionTaskCreation
onURLSessionTaskCreation(on queue: DispatchQueue = .main, perform handler: @escaping (URLSessionTask) -> Void)

// Validation
.validate(Validation)     // DataStreamRequest: (URLRequest?, HTTPURLResponse) -> ValidationResult
.validateData(Validation) // DataRequest/UploadRequest: (URLRequest?, HTTPURLResponse, Data?) -> ValidationResult
.validateFile(Validation) // DownloadRequest: (URLRequest?, HTTPURLResponse, URL?) -> ValidationResult

// Validation Handy:
.validate(statusCode: )
.validate(contentType: )





// MARK: - Make Request
// RequestInterceptor ?
.interceptor()


// DataRequest
.request(parameters)

// DataStreamRequest
.dataStreamRequest(parameters, automaticallyCancelOnStreamError: Bool)

// DownloadRequest
.downloadDestination(DownloadRequest.Destination?)

.downloadRequest(parameters)
.downloadRequest(resumingWith data: Data)

// UploadRequest
.uploadFileManager(FileManager)

.uploadRequest(data: Data)
.uploadRequest(fileURL: URL)
.uploadRequest(stream: InputStream)
.uploadRequest(multipartFormData: MultipartFormData, usingThreshold encodingMemoryThreshold: UInt64)



// MARK: - Response
// ResponseQueue
.responseQueue()

// Serialize
// UploadRequest/DataRequest: Request
.serializeDataResponse<Serializer: DataResponseSerializerProtocol>(using: Serializer)
   DataResponseSerializer
   StringResponseSerializer
   JSONResponseSerializer
   DecodableResponseSerializer

// DataStreamRequest: Request
 .serializeDataStream<Serializer: DataStreamSerializer>(using: Serializer)
   DecodableStreamSerializer

// DownloadRequest: Request
 .serializeDownloadResponse<Serializer: DownloadResponseSerializerProtocol>(using: Serializer)
   URLResponseSerializer
   DataResponseSerializer
   StringResponseSerializer
   JSONResponseSerializer
   DecodableResponseSerializer


// Serialize Handy Modify
.serializeDataResponse(DataResponseSerializer)             // DownloadRequest/UploadRequest/DataRequest
.serializeStringResponse(StringResponseSerializer)         // DownloadRequest/UploadRequest/DataRequest
.serializeJSONResponse(JSONResponseSerializer)             // DownloadRequest/UploadRequest/DataRequest
.serializeDecodableResponse(DecodableResponseSerializer)   // DownloadRequest/UploadRequest/DataRequest
.serializeURLResponse(URLResponseSerializer)               // DownloadRequest
.serializeDataStream(DecodableStreamSerializer)            // DataStreamRequest


// CompletionHandler
// UploadRequest/DataRequest
 completionHandler(Data)
 completionHandler<DataResponseSerializerProtocol>

// DataStreamRequest: Request
 completionHandler(Data)
 completionHandler(String)
 completionHandler<DataStreamSerializer>

// DownloadRequest: Request
 completionHandler(URL)
 completionHandler<DownloadResponseSerializerProtocol>
*/
