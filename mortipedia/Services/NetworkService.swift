import Foundation
import RxSwift
import RxAlamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://rickandmortyapi.com/api"
    private let decoder = JSONDecoder()
    private let disposeBag = DisposeBag()
    
    private init() {}
    
    func getCharacters() -> Observable<[Character]> {
        let url = baseURL + "/character"
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
