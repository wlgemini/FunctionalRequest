
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
















DataRequest: Request
validate
func validate(_ validation: @escaping Validation) -> Self
    typealias Validation = (URLRequest?, HTTPURLResponse, Data?) -> ValidationResult
func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> Self where S.Iterator.Element == Int
func validate<S: Sequence>(contentType acceptableContentTypes: @escaping @autoclosure () -> S) -> Self where S.Iterator.Element == String
func validate() -> Self

response
func response(queue: DispatchQueue = .main, completionHandler: @escaping (AFDataResponse<Data?>) -> Void) -> Self
func response<Serializer: DataResponseSerializerProtocol>(queue: DispatchQueue = .main, responseSerializer: Serializer, completionHandler: @escaping (AFDataResponse<Serializer.SerializedObject>) -> Void) -> Self
func responseData(queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = DataResponseSerializer.defaultDataPreprocessor, emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods, completionHandler: @escaping (AFDataResponse<Data>) -> Void) -> Self
func responseString(queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = StringResponseSerializer.defaultDataPreprocessor, encoding: String.Encoding? = nil, emptyResponseCodes: Set<Int> = StringResponseSerializer.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = StringResponseSerializer.defaultEmptyRequestMethods, completionHandler: @escaping (AFDataResponse<String>) -> Void) -> Self
func responseJSON(queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = JSONResponseSerializer.defaultDataPreprocessor, emptyResponseCodes: Set<Int> = JSONResponseSerializer.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = JSONResponseSerializer.defaultEmptyRequestMethods, options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: @escaping (AFDataResponse<Any>) -> Void) -> Self
func responseDecodable<T: Decodable>(of type: T.Type = T.self, queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = DecodableResponseSerializer<T>.defaultDataPreprocessor, decoder: DataDecoder = JSONDecoder(), emptyResponseCodes: Set<Int> = DecodableResponseSerializer<T>.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = DecodableResponseSerializer<T>.defaultEmptyRequestMethods, completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self












DataStreamRequest: Request
validate
func validate(_ validation: @escaping Validation) -> Self
    typealias Validation = (_ request: URLRequest?, _ response: HTTPURLResponse) -> ValidationResult
func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> Self where S.Iterator.Element == Int
func validate<S: Sequence>(contentType acceptableContentTypes: @escaping @autoclosure () -> S) -> Self where S.Iterator.Element == String
func validate() -> Self

responseStream
func responseStream(on queue: DispatchQueue = .main, stream: @escaping Handler<Data, Never>) -> Self
func responseStream<Serializer: DataStreamSerializer>(using serializer: Serializer, on queue: DispatchQueue = .main, stream: @escaping Handler<Serializer.SerializedObject, AFError>) -> Self
func responseStreamString(on queue: DispatchQueue = .main, stream: @escaping Handler<String, Never>) -> Self
func responseStreamDecodable<T: Decodable>(of type: T.Type = T.self, on queue: DispatchQueue = .main, using decoder: DataDecoder = JSONDecoder(), preprocessor: DataPreprocessor = PassthroughPreprocessor(), stream: @escaping Handler<T, AFError>) -> Self












DownloadRequest: Request
func cancel(producingResumeData shouldProduceResumeData: Bool) -> Self
func cancel(byProducingResumeData completionHandler: @escaping (_ data: Data?) -> Void) -> Self

validate
func validate(_ validation: @escaping Validation) -> Self
    typealias Validation = (_ request: URLRequest?, _ response: HTTPURLResponse, _ fileURL: URL?)
func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> Self where S.Iterator.Element == Int
func validate<S: Sequence>(contentType acceptableContentTypes: @escaping @autoclosure () -> S) -> Self where S.Iterator.Element == String
func validate() -> Self

response
func response(queue: DispatchQueue = .main, completionHandler: @escaping (AFDownloadResponse<URL?>) -> Void) -> Self
func response<Serializer: DownloadResponseSerializerProtocol>(queue: DispatchQueue = .main, responseSerializer: Serializer, completionHandler: @escaping (AFDownloadResponse<Serializer.SerializedObject>) -> Void) -> Self
func responseURL(queue: DispatchQueue = .main, completionHandler: @escaping (AFDownloadResponse<URL>) -> Void) -> Self
func responseData(queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = DataResponseSerializer.defaultDataPreprocessor, emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods, completionHandler: @escaping (AFDownloadResponse<Data>) -> Void) -> Self
func responseString(queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = StringResponseSerializer.defaultDataPreprocessor, encoding: String.Encoding? = nil, emptyResponseCodes: Set<Int> = StringResponseSerializer.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = StringResponseSerializer.defaultEmptyRequestMethods, completionHandler: @escaping (AFDownloadResponse<String>) -> Void) -> Self
func responseJSON(queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = JSONResponseSerializer.defaultDataPreprocessor, emptyResponseCodes: Set<Int> = JSONResponseSerializer.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = JSONResponseSerializer.defaultEmptyRequestMethods, options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: @escaping (AFDownloadResponse<Any>) -> Void) -> Self
func responseDecodable<T: Decodable>(of type: T.Type = T.self, queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = DecodableResponseSerializer<T>.defaultDataPreprocessor, decoder: DataDecoder = JSONDecoder(), emptyResponseCodes: Set<Int> = DecodableResponseSerializer<T>.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = DecodableResponseSerializer<T>.defaultEmptyRequestMethods, completionHandler: @escaping (AFDownloadResponse<T>) -> Void) -> Self








UploadRequest: DataRequest
func cleanup()
*/
