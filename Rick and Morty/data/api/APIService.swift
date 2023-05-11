import Foundation

final class APIService{
    
    static let shared = APIService()
    
    private init(){}
    
    public func execute<T: Codable>(_ request:APIRequest,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void){
        guard let url = request.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
            guard let response = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do{
                let result = try JSONDecoder().decode(type.self, from: response)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
