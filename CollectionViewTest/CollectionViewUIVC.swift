//
//  CollectionViewUIVC.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/03/11.
//

import UIKit

class CollectionViewUIVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var listItems: [Int] = [1]
    let margin: CGFloat = 20
    var cellItemCount: CGFloat = 3
    
    //let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "UI"
        
        let bt = UIBarButtonItem(title: "Change", style: .done, target: self, action: #selector(self.change))
        self.navigationItem.rightBarButtonItems = [bt]
        
        addData2()
        
        setType(.collectionView)
        
        setupFlowLayout()
        
        // 셀 등록
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "stCell")
        
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(collectionView)
    }
    
    @objc func change() {
        
        if cellItemCount == 3 {
            setType(.tableView)
        } else {
            setType(.collectionView)
        }
        
        setupFlowLayout()
    }
    
    func addData2() {
        
        let startIdx = listItems.last! + 1
        
        if startIdx > 300 {
            return
        }
        let endIdx = startIdx + 20
        for idx in startIdx ..< endIdx {
            listItems.append(idx)
        }
    }
    
    func setType(_ type: MAIN_TYPE) {
        
        switch type {
        case .collectionView:
            cellItemCount = 3
        default:
            cellItemCount = 1
        }
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        //flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin) // CollectionView 의 전체 마진
        flowLayout.minimumLineSpacing = 10 // 셀 아이템간의 라인 마진
        flowLayout.minimumInteritemSpacing = 4 // 셀 아이템간의 측면 마진

        flowLayout.itemSize.width = floor((UIScreen.main.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - ((cellItemCount - 1) * flowLayout.minimumInteritemSpacing)) / cellItemCount)
        flowLayout.itemSize.height = flowLayout.itemSize.width
        
        self.collectionView.collectionViewLayout = flowLayout
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.height
        let contentSizeHeight = scrollView.contentSize.height
        let offset = scrollView.contentOffset.y
        print("scrollViewDidScroll offset: \(offset) height: \(height) contentSizeHeight: \(contentSizeHeight)")
        let reachedBottom = (offset + 200 + height >= contentSizeHeight)
        if reachedBottom {
            print("scrollViewDidScroll reached to bottom")
            let current = listItems.count
            addData2()
            //tableView.scrollToRow(at: IndexPath(row: current, section: 0), at: .top, animated: true)
            
            collectionView.reloadData()
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.tableView.setContentOffset(CGPoint(x: 0, y: -104), animated: true)
//            }
            
        }
    }

}


extension CollectionViewUIVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stCell", for: indexPath) as UICollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        cell.label.text = "row \(listItems[(indexPath as NSIndexPath).row])"
        return cell
    }
}
