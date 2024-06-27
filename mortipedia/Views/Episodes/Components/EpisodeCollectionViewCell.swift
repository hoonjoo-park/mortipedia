//
//  EpisodeCollectionViewCell.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 6/22/24.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    static let reuseId = "EpisodeCollectionViewCell"
    
    private let indexLabel = MortyLabel(fontSize: 16, weight: .semibold, color: .text)
    private let titleLabel = MortyLabel(fontSize: 16, weight: .semibold, color: .text)
    private let airDateLabel = MortyLabel(fontSize: 14, weight: .medium, color: .text)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
    }

    fileprivate func layout() {
        contentView.flex.layout(mode: .fitContainer)
    }


    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.size(size)

        layout()

        // Return the flex container new size
        return contentView.frame.size
    }
    
    
    func setCell(episode: Episode) {
        indexLabel.text = String(episode.id)
        titleLabel.text = episode.name
        titleLabel.numberOfLines = 1
        airDateLabel.text = episode.air_date
        
        [indexLabel, titleLabel, airDateLabel].forEach { $0.flex.markDirty() }
    }
    
    
    private func configureUI() {
        contentView.flex.paddingHorizontal(25).define { flex in
            flex.addItem().gap(10).direction(.row).alignItems(.center).paddingHorizontal(15).paddingVertical(10).backgroundColor(.gray4).cornerRadius(14).define { flex in
                flex.addItem().size(30).cornerRadius(8).backgroundColor(.accent).alignItems(.center).justifyContent(.center).define { flex in
                    flex.addItem(indexLabel)
                }
                flex.addItem().define { flex in
                    flex.addItem(titleLabel)
                    flex.addItem(airDateLabel)
                }
            }
        }
    }
}
