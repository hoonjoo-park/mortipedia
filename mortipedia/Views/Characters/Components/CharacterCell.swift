import UIKit

class CharacterCell: UICollectionViewCell {
    static let reuseId = "CharacterCell"
    let image = UIImageView()
    let name = MortiLabel(fontSize: 14, weight: .semibold, color: Colors.text)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with character: Character) {
        name.text = character.name
    }
}
