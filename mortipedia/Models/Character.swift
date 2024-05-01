import Foundation

enum CharacterStatus: String {
    case Alive = "Alive"
    case Dead = "Dead"
    case Unknown = "unknown"
}

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name, species, type: String
    let status: CharacterStatus.RawValue
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

