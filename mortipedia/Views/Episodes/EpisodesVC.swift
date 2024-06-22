import UIKit
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout

class EpisodesVC: UIViewController {
    private let episodeVM = EpisodeVM.shared
    private let disposeBag = DisposeBag()
    
    private let rootFlexContainer = UIView()
    private var episodesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        bindViewModel()
        configureUI()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootFlexContainer.pin.all(view.safeAreaInsets)
        rootFlexContainer.flex.layout()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = Colors.background
        navigationItem.title = "Episodes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        episodeVM.getEpisodes()
    }
    
    
    private func configureCollectionView() {
        episodesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewHelper.createEpisodesFlowLayout(view: self.view))
        episodesCollectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeCollectionViewCell.reuseId)
        episodesCollectionView.backgroundColor = Colors.background
    }
    
    
    private func bindViewModel() {
        episodeVM.episodes
            .bind(to: episodesCollectionView.rx.items(cellIdentifier: EpisodeCollectionViewCell.reuseId, cellType: EpisodeCollectionViewCell.self)) { row, episode, cell in
                guard let episode = episode else { return }
                cell.setCell(episode: episode)
            }.disposed(by: disposeBag)
    }
    
    
    private func configureUI() {
        view.addSubview(rootFlexContainer)
        view.backgroundColor = Colors.background
        
        rootFlexContainer.flex.define { flex in
            flex.addItem(episodesCollectionView).grow(1)
        }
    }
}
