import Foundation
import RxSwift
import RxAlamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://rickandmortyapi.com/api"
    private let decoder = JSONDecoder()
    private let disposeBag = DisposeBag()
    
    private init() {}
    
    func getCharacters(page: Int) -> Observable<[Character]> {
        let url = baseURL + "/character?page=\(page)"
        return RxAlamofire.data(.get, url).map { [weak self] data -> [Character] in
            guard let self = self else { return [] }
            
            do {
                let response = try self.decoder.decode(CharacterResponse.self, from: data)
                return response.results
            } catch {
                return []
            }
        }
    }
    
    
    func searchCharacters(name: String) -> Observable<[Character]> {
        let url = baseURL + "/character?name=\(name)"
        return RxAlamofire.data(.get, url).map { [weak self] data -> [Character] in
            guard let self = self else { return [] }
            
            do {
                let response = try self.decoder.decode(CharacterResponse.self, from: data)
                return response.results
            } catch {
                return []
            }
        }
    }
}
