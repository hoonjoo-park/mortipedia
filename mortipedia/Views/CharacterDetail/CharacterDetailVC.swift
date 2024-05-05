//
//  CharacterDetailVC.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 5/4/24.
//

import UIKit
import Kingfisher
import RxSwift
import FlexLayout
import PinLayout

class CharacterDetailVC: UIViewController {
    private var characterId: Int!
    private let characterVM = CharacterVM.shared
    private let disposeBag = DisposeBag()
    
    private let characterImageView = UIImageView()
    private let imageOverlay = UIView()
    private let nameLabel = MortyLabel(fontSize: 24, weight: .bold, color: Colors.text)
    private let statusBullet = UIView()
    private let statusLabel = MortyLabel(fontSize: 14, weight: .medium, color: Colors.text)
    private let genderLabel = MortyLabel(fontSize: 14, weight: .medium, color: Colors.text)
    private let locationLabel = MortyLabel(fontSize: 14, weight: .medium, color: Colors.text)
    private let originLabel = MortyLabel(fontSize: 14, weight: .medium, color: Colors.text)

    init(characterId: Int) {
        self.characterId = characterId
        
        super.init(nibName: nil, bundle: nil)
        
        characterVM.fetchCharacterDetail(id: characterId)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        bindViewModel()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = Colors.background
        navigationController?.navigationBar.isHidden = false
        
    }
    
    
    private func bindViewModel() {
        characterVM.characterDetail.subscribe(onNext: { [weak self] data in
            guard let self = self, let character = data else { return }
            let imageUrl = URL(string: character.image)
            let status = CharacterStatus(rawValue: character.status) ?? .Alive
            
            self.characterImageView.kf.setImage(with: imageUrl)
            self.nameLabel.text = character.name
            self.statusBullet.backgroundColor = {
                switch status {
                case .Alive:
                    return Colors.accent
                case .Dead:
                    return Colors.negative
                default:
                    return Colors.yellow
                }
            }()
            self.statusLabel.text = "\(status) - \(character.species)"
            self.genderLabel.text = "Gender - \(character.gender)"
            self.locationLabel.text = "Location - \(character.location.name)"
            self.originLabel.text = "Origin - \(character.origin.name)"
        }).disposed(by: disposeBag)
    }
}
