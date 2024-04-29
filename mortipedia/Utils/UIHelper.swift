import Foundation
import UIKit

enum CollectionViewHelper {
    static func createCharactersFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let viewWidth = view.bounds.width
        let padding: CGFloat = 25
        let itemSpacing: CGFloat = 20
        let itemWidth = viewWidth - (padding * 2)
        
        flowLayout.sectionInset = UIEdgeInsets(top: itemSpacing, left: 0, bottom: itemSpacing, right: 0)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 200)
        
        return flowLayout
    }
}
