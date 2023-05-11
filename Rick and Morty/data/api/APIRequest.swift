import Foundation

final class APIRequest{
    
    private struct Constants {
        static let url = "https://rickandmortyapi.com/api/character"
    }
    
    private let path: [String]
    private let query: [URLQueryItem]
    
    var url: URL? {
        var value = Constants.url
        
        path.forEach({
            value += "/\($0)"
        })
        
        if !query.isEmpty {
            value += "?"
            let arg = query.compactMap({
                return "\($0.name)=\($0.value!)"
            }).joined(separator: "&")
            value += arg
        }
        
        print(value)
        return URL(string: value)
    }
    
    public init(path: [String] = [], query: [URLQueryItem] = []) {
        self.path = path
        self.query = query
    }
}
