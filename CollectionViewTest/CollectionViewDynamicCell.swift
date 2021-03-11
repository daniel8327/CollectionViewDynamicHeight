//
//  CollectionViewDynamicCell.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/03/11.
//

import UIKit

class CollectionViewDynamicCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
         super.awakeFromNib()
         
         contentView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             contentView.leftAnchor.constraint(equalTo: leftAnchor),
             contentView.rightAnchor.constraint(equalTo: rightAnchor),
             contentView.topAnchor.constraint(equalTo: topAnchor),
             contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
         ])
     }
    // Note: must be strong // 스토리보드에서 Constraints 를 equal 로 주면 왼쪽 정렬되고, width equals <= 50(Less than or Equal) 으로하면 가운데 정렬
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
        didSet {
            maxWidthConstraint.isActive = false
        }
    }
    
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
}
