import Foundation

struct CharacterModel: Codable{
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let url: String
    let created: String
    let origin: DataModel
    let location: DataModel
    let episode: [String]
}
