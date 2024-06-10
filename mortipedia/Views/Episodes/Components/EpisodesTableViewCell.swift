//
//  EpisodesTableViewCell.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 6/9/24.
//

import UIKit
import FlexLayout

class EpisodesTableViewCell: UITableViewCell {
    static let reuseId = "EpisodesTableViewCell"
    
    private let indexLabel = MortyLabel(fontSize: 16, weight: .semibold, color: .text)
    private let titleLabel = MortyLabel(fontSize: 16, weight: .semibold, color: .text)
    private let airDateLabel = MortyLabel(fontSize: 14, weight: .medium, color: .text)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        airDateLabel.text = episode.air_date
        
        [indexLabel, titleLabel, airDateLabel].forEach { $0.flex.markDirty() }
    }
    
    
    private func configureUI() {
        contentView.flex.paddingHorizontal(25).define { flex in
            flex.addItem().gap(10).direction(.row).alignItems(.center).backgroundColor(.gray4).cornerRadius(14).define { flex in
                flex.addItem().size(30).cornerRadius(8).alignItems(.center).justifyContent(.center).define { flex in
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
