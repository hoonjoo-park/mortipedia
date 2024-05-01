import Foundation
import RxSwift

class CharacterVM {
    static let shared = CharacterVM()
    private let disposeBag = DisposeBag()
    
    private var characterPage = 1
    private var isFetchingCharacters = false
    private var canFetchMoreCharacters = true
    
    private let charactersSubject = BehaviorSubject<[Character?]>(value: [])
    var characters: Observable<[Character?]> {
        return charactersSubject.asObservable()
    }
    
    func getCharacters() {
        NetworkManager.shared.getCharacters(page: characterPage).subscribe(onNext: { [weak self] characters in
            guard let self = self, isFetchingCharacters == false, canFetchMoreCharacters == true else { return }
            
            self.isFetchingCharacters = true
            characterPage += 1
            
            if characters.count < 20 {
                self.canFetchMoreCharacters = false
            }

            let currentCharacters = try! self.charactersSubject.value()
            let newCharacters = currentCharacters + characters
            
            self.charactersSubject.onNext(newCharacters)
            self.isFetchingCharacters = false
        }).disposed(by: disposeBag)
    }
}
