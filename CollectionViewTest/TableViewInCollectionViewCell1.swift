//
//  TableViewInCollectionViewCell1.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/06/07.
//

import UIKit

let COLLECTIONVIEW_CELL_ITEM_COUNT: CGFloat = 3
let COLLECTIONVIEW_CELL_MARGIN: CGFloat = 5

class TableViewInCollectionViewCell1: UITableViewCell {
    
    lazy var layout: UICollectionViewFlowLayout = {
        let fl = UICollectionViewFlowLayout()

        // fl.sectionInset = UIEdgeInsets.zero

        fl.sectionInset = UIEdgeInsets(top: COLLECTIONVIEW_CELL_MARGIN, left: COLLECTIONVIEW_CELL_MARGIN, bottom: COLLECTIONVIEW_CELL_MARGIN, right: COLLECTIONVIEW_CELL_MARGIN) // CollectionView 의 전체 마진
        fl.minimumLineSpacing = COLLECTIONVIEW_CELL_MARGIN // 셀 아이템간의 라인 마진
        fl.minimumInteritemSpacing = COLLECTIONVIEW_CELL_MARGIN // 셀 아이템간의 측면 마진

        let spacing = (COLLECTIONVIEW_CELL_ITEM_COUNT - 1) * fl.minimumInteritemSpacing

        fl.itemSize.width =
            floor(
                (UIScreen.main.bounds.width - fl.sectionInset.left - fl.sectionInset.right - spacing)
                    / COLLECTIONVIEW_CELL_ITEM_COUNT
            )
        fl.itemSize.height = fl.itemSize.width

        return fl
    }() { didSet {
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
    }}
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) {
        didSet {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            selectionStyle = .none
        }
    }
    
    
    var items: [String] = (1 ... 4).map { "\($0)"}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        collectionView.register(Cell1.self, forCellWithReuseIdentifier: Cell1.reusableIdentifier)
        collectionView.isScrollEnabled = false
        
        self.contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
             collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
             collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
             collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
        
        
        collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//
//        self.layoutIfNeeded()
//
//        self.collectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width, height: CGFloat(MAXFLOAT))
//        self.collectionView.layoutIfNeeded()
//
//        return self.collectionView.collectionViewLayout.collectionViewContentSize
//    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0 ... 1),
                       green: .random(in: 0 ... 1),
                       blue: .random(in: 0 ... 1),
                       alpha: 1.0)
    }
}

extension TableViewInCollectionViewCell1: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell1.reusableIdentifier, for: indexPath) as! Cell1
        
        cell.label.text = items[indexPath.row]
        cell.backgroundColor = .random
        
        
        
    
        return cell
    }
    
    
}


class Cell1: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
             label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
             label.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
             label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

