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

    private let isSearchModeSubject = BehaviorSubject<Bool>(value: false)
    var isSearchMode: Observable<Bool> {
        return isSearchModeSubject.asObservable()
    }
    
    private let searchedCharactersSubject = BehaviorSubject<[Character?]>(value: [])
    var searchedCharacters: Observable<[Character?]> {
        return searchedCharactersSubject.asObservable()
    }
    
    private let characterDetailSubject = BehaviorSubject<Character?>(value: nil)
    var characterDetail: Observable<Character?> {
        return characterDetailSubject.asObservable()
    }
    
    private let isFetchingCharacterDetailSubject = BehaviorSubject<Bool>(value: true)
    var isFetchingCharacterDetail: Observable<Bool> {
        return isFetchingCharacterDetailSubject.asObservable()
    }
    
    func getCharacters() {
        NetworkManager.shared.getCharacters(page: characterPage).subscribe(onNext: { [weak self] characters in
            guard let self = self, isFetchingCharacters == false, canFetchMoreCharacters == true else { return }
            
            self.isFetchingCharacters = true
            characterPage += 1
            
            if characters.count < 20 {
                self.canFetchMoreCharacters = false
            }

            let currentCharacters = try? self.charactersSubject.value()
            let newCharacters = (currentCharacters ?? []) + characters
            
            self.charactersSubject.onNext(newCharacters)
            self.isFetchingCharacters = false
        }).disposed(by: disposeBag)
    }
    
    
    func getCharacterByIndex(index: Int) -> Character? {
        return try? charactersSubject.value()[index]
    }
    
    
    func toggleSearchMode() {
        let newValue = try? !isSearchModeSubject.value()
        isSearchModeSubject.onNext(newValue ?? false)
    }
    
    
    func searchCharacters(keyword: String) {
        NetworkManager.shared.searchCharacters(name: keyword).subscribe(onNext: { [weak self] characters in
            guard let self = self else { return }
            
            self.searchedCharactersSubject.onNext(characters)
        }).disposed(by: disposeBag)
    }
    
    
    func clearSearchedCharacters() {
        searchedCharactersSubject.onNext([])
    }
    
    
    func fetchCharacterDetail(id: Int) {
        isFetchingCharacterDetailSubject.onNext(true)
        
        NetworkManager.shared.fetchCharacterDetailById(id: id).subscribe(onNext: { [weak self] character in
            guard let self = self else { return }
            
            
            self.characterDetailSubject.onNext(character)
        }).disposed(by: disposeBag)
        
        isFetchingCharacterDetailSubject.onNext(false)
    }
    
    
    func clearCharacterDetail(id: Int) {        
        let currentCharacterDetailId = try? characterDetailSubject.value()?.id
        
        if currentCharacterDetailId == id { return }
        
        characterDetailSubject.onNext(nil)
    }
}
