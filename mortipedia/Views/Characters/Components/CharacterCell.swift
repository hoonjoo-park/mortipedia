import UIKit
import FlexLayout
import PinLayout

class CharacterCell: UICollectionViewCell {
    static let reuseId = "CharacterCell"
    let rootView = UIView()
    let image = UIImageView()
    let name = MortiLabel(fontSize: 14, weight: .semibold, color: Colors.text)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with character: Character) {
        name.text = character.name
    }
    
    
    private func configureUI() {
        addSubview(rootView)
        
        rootView.backgroundColor = Colors.gray3
        
        rootView.flex.direction(.column).padding(12).cornerRadius(12).define { flex in
            flex.addItem(image).cornerRadius(12)
            flex.addItem(name)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootView.flex.layout(mode: .fitContainer)
        rootView.pin.all()
    }
}
