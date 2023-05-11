import Foundation

struct ResponseModel: Codable{
    let results:  [CharacterModel]
    let info: InfoModel
}
