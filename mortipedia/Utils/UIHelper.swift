import Foundation
import UIKit

enum CollectionViewHelper {
    static func createCharactersFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
        let viewWidth = view.bounds.width
        let padding: CGFloat = 25
        let itemSpacing: CGFloat = 20
        let containerWidth = viewWidth - (padding * 2) - itemSpacing
        let itemWidth = containerWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 45)
        flowLayout.minimumLineSpacing = itemSpacing
        
        return flowLayout
    }
}
