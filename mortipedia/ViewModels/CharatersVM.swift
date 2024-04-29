import Foundation
import RxSwift

class CharacterVM {
    static let shared = CharacterVM()
    private let disposeBag = DisposeBag()
    
    private let charactersSubject = BehaviorSubject<[Character?]>(value: [])
    var characters: Observable<[Character?]> {
        return charactersSubject.asObservable()
    }
    
    func getCharacters() {
        NetworkManager.shared.getCharacters().subscribe(onNext: { [weak self] characters in
            guard let self = self else { return }
            
            self.charactersSubject.onNext(characters)
        }).disposed(by: disposeBag)
    }
}
