//
//  MultiCell.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/02/02.
//

import UIKit

class MultiCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        label.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}
