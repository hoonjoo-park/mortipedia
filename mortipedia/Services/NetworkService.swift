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
        RxAlamofire.json(.get, url)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
}
