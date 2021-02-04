//
//  Cell.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/02/02.
//

import UIKit

class Cell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.widthConstraint.constant = UIScreen.main.bounds.width
    }

    func setData(data: String) {
        self.label.text = data
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return contentView.systemLayoutSizeFitting(CGSize(width: self.bounds.size.width, height: 1))
    }

    
}
