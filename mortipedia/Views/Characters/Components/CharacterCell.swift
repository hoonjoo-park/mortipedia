import UIKit
import FlexLayout
import PinLayout
import Kingfisher

class CharacterCell: UICollectionViewCell {
    static let reuseId = "CharacterCell"
    
    let characterImage = UIImageView()
    let nameLabel = MortiLabel(fontSize: 14, weight: .semibold, color: Colors.text)
    let statusBullet = UIView()
    let statusLabel = MortiLabel(fontSize: 10, weight: .semibold, color: Colors.text)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        
        let imageUrl = URL(string: character.image)
        characterImage.kf.setImage(with: imageUrl)
        characterImage.clipsToBounds = true
        
        let status: CharacterStatus = CharacterStatus(rawValue: character.status) ?? .Alive
        let species = character.species
        
        statusBullet.backgroundColor = {
            switch status {
            case .Alive:
                return Colors.accent
            case .Dead:
                return Colors.negative
            default:
                return Colors.yellow
            }
        }()
        statusLabel.text = "\(status) - \(species)"
        
        [nameLabel, characterImage, statusBullet, statusLabel].forEach {
            $0.flex.markDirty()
        }
        
        setNeedsLayout()
    }
    
    
    private func configureUI() {
        contentView.flex.padding(12).cornerRadius(12).gap(10).backgroundColor(Colors.gray3).define { flex in
            flex.addItem(characterImage).size(135).cornerRadius(12)
            flex.addItem().gap(8).grow(1).define { flex in
                flex.addItem(nameLabel)
                flex.addItem().direction(.row).grow(1).gap(4).alignItems(.center).define { flex in
                    flex.addItem(statusBullet).size(5).cornerRadius(2.5)
                    flex.addItem(statusLabel).grow(1)
                }
            }
        }
    }
    
    
    private func layout() {
        contentView.flex.layout(mode: .fitContainer)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
    }
    
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.size(size)
        layout()
        
        return contentView.frame.size
    }
}
