
/* Response

DataRequest: Request
func response(queue: DispatchQueue,
              completionHandler: @escaping (AFDataResponse<Data?>) -> Void) -> Self
func response<Serializer: DataResponseSerializerProtocol>(queue: DispatchQueue,
                                                          responseSerializer: Serializer,
                                                          completionHandler: @escaping (AFDataResponse<Serializer.SerializedObject>) -> Void) -> Self
 DataResponseSerializer
 StringResponseSerializer
 JSONResponseSerializer
 DecodableResponseSerializer












DataStreamRequest: Request
func responseStream(on queue: DispatchQueue,
                    stream: @escaping Handler<Data, Never>) -> Self
func responseStreamString(on queue: DispatchQueue,
                          stream: @escaping Handler<String, Never>) -> Self
func responseStream<Serializer: DataStreamSerializer>(using serializer: Serializer,
                                                      on queue: DispatchQueue,
                                                      stream: @escaping Handler<Serializer.SerializedObject, AFError>) -> Self
 DecodableStreamSerializer
 













DownloadRequest: Request
func response(queue: DispatchQueue,
              completionHandler: @escaping (AFDownloadResponse<URL?>) -> Void) -> Self
func response<Serializer: DownloadResponseSerializerProtocol>(queue: DispatchQueue,
                                                              responseSerializer: Serializer,
                                                              completionHandler: @escaping (AFDownloadResponse<Serializer.SerializedObject>) -> Void) -> Self
 URLResponseSerializer
 DataResponseSerializer
 StringResponseSerializer
 JSONResponseSerializer
 DecodableResponseSerializer


UploadRequest: DataRequest

*/
