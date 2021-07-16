
/*
DataRequest:
    RequestConvertible:
            let url: URLConvertible
            let method: HTTPMethod
            let parameters: Parameters?
            let encoding: ParameterEncoding
            let headers: HTTPHeaders?
            let requestModifier: RequestModifier?

    RequestEncodableConvertible:
            let url: URLConvertible
            let method: HTTPMethod
            let parameters: Parameters?
            let encoder: ParameterEncoder
            let headers: HTTPHeaders?
            let requestModifier: RequestModifier?

func request(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor?) -> DataRequest
    RequestConvertible:
    RequestEncodableConvertible:



 
 
 
 
 
DataStreamRequest:
func streamRequest(_ convertible: URLRequestConvertible, automaticallyCancelOnStreamError: Bool, interceptor: RequestInterceptor?) -> DataStreamRequest
    RequestEncodableConvertible:




 
 
 
 
 
DownloadRequest:
func download(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor?, to destination: DownloadRequest.Destination?) -> DownloadRequest
    RequestConvertible:
    RequestEncodableConvertible:

func download(resumingWith data: Data, interceptor: RequestInterceptor?, to destination: DownloadRequest.Destination?) -> DownloadRequest


 
 
 
 


UploadRequest:
ParameterlessRequestConvertible
    let url: URLConvertible
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let requestModifier: RequestModifier?

Data:
    func upload(_ data: Data, with convertible: URLRequestConvertible, interceptor: RequestInterceptor?, fileManager: FileManager) -> UploadRequest
        ParameterlessRequestConvertible

File:
    func upload(_ fileURL: URL, with convertible: URLRequestConvertible, interceptor: RequestInterceptor?, fileManager: FileManager) -> UploadRequest
        ParameterlessRequestConvertible

InputStream:
    func upload(_ stream: InputStream, with convertible: URLRequestConvertible, interceptor: RequestInterceptor?, fileManager: FileManager) -> UploadRequest
        ParameterlessRequestConvertible

MultipartFormData:
    func upload(multipartFormData: MultipartFormData, with request: URLRequestConvertible, usingThreshold encodingMemoryThreshold: UInt64, interceptor: RequestInterceptor?, fileManager: FileManager) -> UploadRequest
        ParameterlessRequestConvertible
*/





/*
RequestConvertible: DataRequest/DataStreamRequest/DownloadRequest
    let url: URLConvertible => mody: base + path \ full \ mock
    let method: HTTPMethod  => mody
    let headers: HTTPHeaders? => mody
    let requestModifier: RequestModifier? => mody
 
    let parameters: Parameters? => _
    let encoding: ParameterEncoding => cond mody
    let encoder: ParameterEncoder => cond mody
        
RequestConvertible: UploadRequest
    let url: URLConvertible => mody: base + path \ full \ mock
    let method: HTTPMethod  => mody
    let headers: HTTPHeaders? => mody
    let requestModifier: RequestModifier? => mody
 
 
 
Modify: RequestConvertible/RequestEncodableConvertible/ParameterlessRequestConvertible
url: base + path / full / mock
method: x
headers: header / headers
encoding: Parameters cond
encoder: Parameters cond
requestModifier: ?
 
Call:
parameters: Request cond
*/






/*
DataRequest
convertible: URLRequestConvertible => RequestConvertible \ RequestEncodableConvertible
interceptor: RequestInterceptor?



DataStreamRequest:
convertible: URLRequestConvertible => RequestEncodableConvertible
automaticallyCancelOnStreamError: Bool
interceptor: RequestInterceptor?



DownloadRequest:
1
convertible: URLRequestConvertible => RequestConvertible | RequestEncodableConvertible
interceptor: RequestInterceptor?
to destination: DownloadRequest.Destination?

2
resumingWith data: Data
interceptor: RequestInterceptor?
to destination: DownloadRequest.Destination?




UploadRequest:
Data:
    data: Data
    with convertible: URLRequestConvertible => ParameterlessRequestConvertible
    interceptor: RequestInterceptor?
    fileManager: FileManager

File:
    fileURL: URL
    with convertible: URLRequestConvertible => ParameterlessRequestConvertible
    interceptor: RequestInterceptor?
    fileManager: FileManager

InputStream:
    stream: InputStream
    with convertible: URLRequestConvertible => ParameterlessRequestConvertible
    interceptor: RequestInterceptor?
    fileManager: FileManager
        
MultipartFormData:
    multipartFormData: MultipartFormData
    with convertible: URLRequestConvertible => ParameterlessRequestConvertible
    usingThreshold encodingMemoryThreshold: UInt64
    interceptor: RequestInterceptor?
    fileManager: FileManager
 
 
 

Modify:
interceptor: RequestInterceptor?
 
Call:
    DataRequest:
        parameters
     
    DataStreamRequest:
        parameters
        automaticallyCancelOnStreamError: Bool
        
    DownloadRequest:
        1
        parameters
        destination: DownloadRequest.Destination?
 
        2
        resumingWith data: Data
        destination: DownloadRequest.Destination?
 
    UploadRequest:
         Data:
             data: Data
             fileManager: FileManager

         File:
             fileURL: URL
             fileManager: FileManager
                 

         InputStream:
             stream: InputStream
             fileManager: FileManager

         MultipartFormData:
             multipartFormData: MultipartFormData
             usingThreshold encodingMemoryThreshold: UInt64
             fileManager: FileManager
    
*/
