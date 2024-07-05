import Foundation

enum NetworkError: Error {
    case decodingError
    case domainErrror
    case urlError
}

struct Resource<T: Codable> {
    let url: URL
}

class WebService {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data, error == nil else  {
                completion(.failure(.domainErrror))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
