
/*
Request:

func authenticate(username: String, password: String, persistence: URLCredential.Persistence = .forSession) -> Self
func authenticate(with credential: URLCredential) -> Self

func downloadProgress(queue: DispatchQueue = .main, closure: @escaping ProgressHandler) -> Self
func uploadProgress(queue: DispatchQueue = .main, closure: @escaping ProgressHandler) -> Self

func redirect(using handler: RedirectHandler) -> Self

func cacheResponse(using handler: CachedResponseHandler) -> Self

func cURLDescription(on queue: DispatchQueue, calling handler: @escaping (String) -> Void) -> Self
func cURLDescription(calling handler: @escaping (String) -> Void) -> Self

func onURLRequestCreation(on queue: DispatchQueue = .main, perform handler: @escaping (URLRequest) -> Void) -> Self
func onURLSessionTaskCreation(on queue: DispatchQueue = .main, perform handler: @escaping (URLSessionTask) -> Void) -> Self
 
 
 
 Modify:
 ~
*/














/* Validate
DataRequest: Request
DataStreamRequest: Request
DownloadRequest: Request
UploadRequest: DataRequest


 
func validate(_ validation: @escaping Validation) -> Self
    typealias Validation = (URLRequest?, HTTPURLResponse) -> ValidationResult
    typealias Validation = (URLRequest?, HTTPURLResponse, Data?) -> ValidationResult
    typealias Validation = (URLRequest?, HTTPURLResponse, URL?) -> ValidationResult
 
func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> Self where S.Iterator.Element == Int
func validate<S: Sequence>(contentType acceptableContentTypes: @escaping @autoclosure () -> S) -> Self where S.Iterator.Element == String

 


 
 
 
 
 Modify:
    .validate()     // DataStreamRequest
    .validateData() // DataRequest/UploadRequest
    .validateFile() // DownloadRequest
 
    Handy:
        .validate(statusCode: )
        .validate(contentType: )
*/

