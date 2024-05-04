import UIKit

class MortyLabel: UILabel {

    convenience init(fontSize: CGFloat, weight: UIFont.Weight, color: UIColor?) {
        self.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = color ?? Colors.text
        lineBreakMode = .byTruncatingTail
    }

}
