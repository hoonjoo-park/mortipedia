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
        // collectionView's content container inset
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        // collectionView's each item's size (if row has enough space, it will show more items than one in a row, otherwise 1 item in a row)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 45)
        // space between items in a row
        flowLayout.minimumLineSpacing = itemSpacing
        
        return flowLayout
    }
    
    static func createEpisodesFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let viewWidth = view.bounds.width
        let padding: CGFloat = 25
        let gap: CGFloat = 15
        let itemWidth = viewWidth
        
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 58)
        flowLayout.minimumLineSpacing = gap
        
        return flowLayout
    }
}
