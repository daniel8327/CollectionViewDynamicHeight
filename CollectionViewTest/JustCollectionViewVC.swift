//
//  JustCollectionViewVC.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/06/07.
//

import UIKit

class JustCollectionViewVC: UIViewController {
    
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
        }
    }
    
    
    var items: [String] = (1 ... 100).map { "\($0)"}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.register(Cell1.self, forCellWithReuseIdentifier: Cell1.reusableIdentifier)
        
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
             collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
             collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
             collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
        
        
        collectionView.dataSource = self
        
    }
}

extension JustCollectionViewVC: UICollectionViewDataSource {
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
