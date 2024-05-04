import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

class CharactersVC: UIViewController {
    private let disposeBag = DisposeBag()
    
    let rootFlexContainer = UIView()
    let headerView = CharacterHeader()
    let characterVM = CharacterVM.shared
    var characterCollectionView: UICollectionView!
    var searchResultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureUI()
        bindCollectionView()
    }
    
    
    private func configureVC() {
        characterVM.getCharacters()
        
        characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewHelper.createCharactersFlowLayout(view: self.view))
        characterCollectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseId)
        characterCollectionView.backgroundColor = Colors.background
        
        searchResultCollectionView = UICollectionView(frame: .zero, 
                                                      collectionViewLayout: CollectionViewHelper.createCharactersFlowLayout(view: self.view))
        searchResultCollectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseId)
        searchResultCollectionView.backgroundColor = Colors.background
        searchResultCollectionView.alpha = 0
        searchResultCollectionView.backgroundView = EmptyResultView(message: "No Results Found ;(")
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isUserInteractionEnabled = false
        
        view.addSubview(rootFlexContainer)
        view.backgroundColor = Colors.background
    }
    
    
    private func configureUI() {
        rootFlexContainer.flex.direction(.column).define { flex in
            flex.addItem(headerView)
            flex.addItem().grow(1).define { flex in
                flex.addItem(characterCollectionView).position(.absolute).horizontally(0).vertically(0)
                flex.addItem(searchResultCollectionView).position(.absolute).horizontally(0).vertically(0)
            }
        }
    }
    
    
    private func bindCollectionView() {
        characterVM.characters
            .bind(to: characterCollectionView.rx.items(cellIdentifier: CharacterCell.reuseId, cellType: CharacterCell.self)) { row, character, cell in
                guard let character = character else { return }
                cell.configure(with: character)
            }
            .disposed(by: disposeBag)
        
        characterVM.searchedCharacters
            .bind(to: searchResultCollectionView.rx.items(cellIdentifier: CharacterCell.reuseId,
                                                          cellType: CharacterCell.self)) { row, result, cell in
                guard let result = result else { return }
                cell.configure(with: result)
            }.disposed(by: disposeBag)
        
        characterVM.searchedCharacters.subscribe(onNext: { [weak self] results in
            guard let self = self else { return }
            
            self.searchResultCollectionView.backgroundView?.isHidden = !results.isEmpty
        }).disposed(by: disposeBag)
        
        characterVM.isSearchMode.subscribe(onNext: { [weak self]  isSearchMode in
            guard let self = self else { return }
            if isSearchMode == true {
                self.characterCollectionView.alpha = 0
                self.searchResultCollectionView.alpha = 1
            } else {
                self.characterCollectionView.alpha = 1
                self.searchResultCollectionView.alpha = 0
            }
        }).disposed(by: disposeBag)
        
        characterCollectionView.rx.contentOffset
            .map { [weak self] in self?.isEndReached(contentOffset: $0) }
            .distinctUntilChanged()
            .filter { $0 == true }
            .subscribe(onNext: { [weak self] _ in
                self?.characterVM.getCharacters()
            }).disposed(by: disposeBag)
    }
    
    
    private func isEndReached(contentOffset: CGPoint) -> Bool {
        guard contentOffset.y > 0 else { return false }
        
        return contentOffset.y + self.characterCollectionView.frame.size.height + 50 > self.characterCollectionView.contentSize.height
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootFlexContainer.pin.all(view.safeAreaInsets)
        rootFlexContainer.flex.layout()
    }
}
