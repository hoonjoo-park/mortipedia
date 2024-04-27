import Foundation
import RxSwift
import RxAlamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://rickandmortyapi.com/api"
    private let decoder = JSONDecoder()
    private let disposeBag = DisposeBag()
    
    private init() {}
    
    func getCharacters() {
        let url = baseURL + "/character"
        RxAlamofire.data(.get, url)
            .map { [weak self] data -> CharacterResponse? in
                guard let self = self else { return nil }
                
                let response = try? self.decoder.decode(CharacterResponse.self, from: data)
                return response
            }
            .subscribe(onNext: { response in
                guard let response = response else { return }
                
                print(response.results)
            })
            .disposed(by: disposeBag)
    }
}
