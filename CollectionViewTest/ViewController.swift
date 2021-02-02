//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/02/02.
//

import UIKit

enum MAIN_TYPE {
    case collectionView
    case tableView
}

class ViewController: UIViewController {
    
    var listItems: [Int] = [1]
    let margin: CGFloat = 10
    var cellItemCount: CGFloat = 3
    
    var collectionView: UICollectionView!
    let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "xx"
        
        self.view.tintColor = .white
        self.view.backgroundColor = .yellow
        
        let bt = UIBarButtonItem(title: "Change", style: .done, target: self, action: #selector(self.change))
        self.navigationItem.rightBarButtonItems = [bt]
        
        addData2()
        
        flowLayout.scrollDirection = .vertical
        
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin) // CollectionView 의 전체 마진
        flowLayout.minimumLineSpacing = margin // 셀 아이템간의 라인 마진
        flowLayout.minimumInteritemSpacing = margin // 셀 아이템간의 측면 마진
        
        setType(.collectionView)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        
        // 셀 등록
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "stCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
    
    
    @objc func change() {
        
        if cellItemCount == 3 {
            setType(.tableView)
        } else {
            setType(.collectionView)
        }
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
        
        
        flowLayout.itemSize.width = floor((UIScreen.main.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - ((cellItemCount - 1) * flowLayout.minimumInteritemSpacing)) / cellItemCount)
        flowLayout.itemSize.height = flowLayout.itemSize.width
        
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


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stCell", for: indexPath) as UICollectionViewCell
        
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        cell.largeContentTitle = "row \(listItems[(indexPath as NSIndexPath).row])"
        return cell
    }
    
    
}
