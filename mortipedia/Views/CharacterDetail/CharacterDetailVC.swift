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
    private let statusLabel = MortyLabel(fontSize: 16, weight: .medium, color: Colors.text)
    private let genderIcon = UIImageView(image: UIImage(named: "gender")?.withRenderingMode(.alwaysTemplate))
    private let genderLabel = MortyLabel(fontSize: 16, weight: .medium, color: Colors.text)
    private let locationIcon = UIImageView(image: UIImage(named: "location")?.withRenderingMode(.alwaysTemplate))
    private let locationLabel = MortyLabel(fontSize: 16, weight: .medium, color: Colors.text)
    private let originIcon = UIImageView(image: UIImage(named: "origin")?.withRenderingMode(.alwaysTemplate))
    private let originLabel = MortyLabel(fontSize: 16, weight: .medium, color: Colors.text)

    init(characterId: Int) {
        self.characterId = characterId
        
        super.init(nibName: nil, bundle: nil)
        
        characterVM.clearCharacterDetail(id: characterId)
        characterVM.fetchCharacterDetail(id: characterId)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        bindViewModel()
        configureUI()
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

            [self.characterImageView, 
             self.imageOverlay,
             self.nameLabel,
             self.statusBullet,
             self.statusLabel,
             self.genderLabel,
             self.locationLabel,
             self.originLabel].forEach { $0.flex.markDirty() }
            
            view.setNeedsLayout()
        }).disposed(by: disposeBag)
    }
    
    
    private func configureUI() {
        [genderIcon, locationIcon, originIcon].forEach {
            $0.tintColor = Colors.text
        }
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 30
        characterImageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        view.flex.define { flex in
            flex.addItem().size(view.frame.width).define { flex in
                flex.addItem(characterImageView).grow(1)
                flex.addItem(imageOverlay)
                    .position(.absolute).horizontally(0).vertically(0).backgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.33))
            }
            
            flex.addItem().grow(1).padding(25).define { flex in
                flex.addItem(nameLabel)
                flex.addItem().direction(.row).alignItems(.center).paddingVertical(15).gap(8).define { flex in
                    flex.addItem(statusBullet).size(10).cornerRadius(5)
                    flex.addItem(statusLabel)
                }
                flex.addItem().direction(.row).alignItems(.center).paddingVertical(15).gap(10).define { flex in
                    flex.addItem(genderIcon)
                    flex.addItem(genderLabel)
                }
                flex.addItem().direction(.row).alignItems(.center).paddingVertical(15).gap(10).define { flex in
                    flex.addItem(locationIcon)
                    flex.addItem(locationLabel)
                }
                flex.addItem().direction(.row).alignItems(.center).paddingVertical(15).gap(10).define { flex in
                    flex.addItem(originIcon)
                    flex.addItem(originLabel)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.pin.all()
        view.flex.layout()
    }
}
