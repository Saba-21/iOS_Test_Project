import Foundation

final class CharactersViewModel {
    
    private var characters: [CharacterModel] = []
    
    public func fetch(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        APIService.shared.execute(
            APIRequest(),
            expecting: ResponseModel.self
        ) { [weak self] result in
            switch result {
            case .success(let data):
                self?.characters = data.results
                onSuccess()
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    public func getCharacterListCount() -> Int{
        return characters.count
    }
    
    public func getCharacterData(index: Int) -> CharacterModel{
        return characters[index]
    }
    
    public func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>)->Void){
        
        let request = URLRequest(url: URL(string: imageUrl)!)
        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
