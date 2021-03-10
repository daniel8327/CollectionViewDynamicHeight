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

let samuelQuotes = [
    "Normally, both your asses would be dead as fucking fried chicken, but you happen to pull this shit while I'm in a transitional period so I don't wanna kill you, I wanna help you. But I can't give you this case, it don't belong to me. Besides, I've already been through too much shit this morning over this case to hand it over to your dumb ass.",
    "Well, the way they make shows is, they make one show. That show's called a pilot.",
    "My money's in that office, right? If she start giving me some bullshit about it ain't there, and we got to go someplace else and get it, I'm gonna shoot you in the head then and there.",
    "The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men.",
    "And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.",
    "Well, the way they make shows is, they make one show. That show's called a pilot.",
    "My money's in that office, right? If she start giving me some bullshit about it ain't there, and we got to go someplace else and get it, I'm gonna shoot you in the head then and there.",
    "The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men.",
    "And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.",
    "Well, the way they make shows is, they make one show. That show's called a pilot.",
    "My money's in that office, right? If she start giving me some bullshit about it ain't there, and we got to go someplace else and get it, I'm gonna shoot you in the head then and there.",
    "The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men.",
    "And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.",
    "Well, the way they make shows is, they make one show. That show's called a pilot.",
    "My money's in that office, right? If she start giving me some bullshit about it ain't there, and we got to go someplace else and get it, I'm gonna shoot you in the head then and there.",
    "The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men.",
    "And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.",
    "Well, the way they make shows is, they make one show. That show's called a pilot.",
    "My money's in that office, right? If she start giving me some bullshit about it ain't there, and we got to go someplace else and get it, I'm gonna shoot you in the head then and there.",
    "The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men.",
    "And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.",
    "Well, the way they make shows is, they make one show. That show's called a pilot.",
    "My money's in that office, right? If she start giving me some bullshit about it ain't there, and we got to go someplace else and get it, I'm gonna shoot you in the head then and there.",
    "The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men.",
    "And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee."
]
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
        
        
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        
        
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .always
        
        // Setup Autolayout constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        if cellItemCount == 3 {
            setType(.collectionView)
        } else {
            setType(.tableView)
        }
        
        // 셀 등록
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//        collectionView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.register(UINib(nibName: "MultiCell", bundle: nil), forCellWithReuseIdentifier: "MultiCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    
    @objc func change() {
        
        if cellItemCount == 3 {
            setType(.tableView)
            
            flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin) // CollectionView 의 전체 마진
            flowLayout.minimumLineSpacing = margin // 셀 아이템간의 라인 마진
            flowLayout.minimumInteritemSpacing = margin // 셀 아이템간의 측면 마진
        } else {
            setType(.collectionView)
            
            collectionView.contentInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
            (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
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
            
            let width = floor((UIScreen.main.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - ((cellItemCount) * flowLayout.minimumInteritemSpacing)) / cellItemCount)
            flowLayout.estimatedItemSize = CGSize(width: width, height: width)
            flowLayout.itemSize.width  = width
            flowLayout.itemSize.height = width
        default:
            cellItemCount = 1
            //flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.estimatedItemSize     = UICollectionViewFlowLayout.automaticSize
            flowLayout.sectionInsetReference = .fromLayoutMargins
            
            
        }
        
        collectionView.reloadData()
        
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
        return samuelQuotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if cellItemCount == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                                                          
            cell.backgroundColor = .blue
            cell.layer.cornerRadius = 20
            return cell
        } else {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        //cell.setData(data: "row \(listItems[(indexPath as NSIndexPath).row])")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiCell", for: indexPath) as! MultiCell
            
//            cell.backgroundColor = .red
//            cell.layer.cornerRadius = 10
            cell.label.text = "row \(samuelQuotes[(indexPath as NSIndexPath).row])"
            return cell
        }
        
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {


    // MARK: - UICollectionViewDelegateFlowLayout -
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if cellItemCount == 3 {
            
            return CGSize(width: floor((UIScreen.main.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - ((cellItemCount - 1) * flowLayout.minimumInteritemSpacing)) / cellItemCount), height: floor((UIScreen.main.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - ((cellItemCount - 1) * flowLayout.minimumInteritemSpacing)) / cellItemCount))
            
        } else {
            
            let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
            let referenceHeight: CGFloat = 100 // Approximate height of your cell
            let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
                - sectionInset.left
                - sectionInset.right
                - collectionView.contentInset.left
                - collectionView.contentInset.right
            return CGSize(width: referenceWidth, height: referenceHeight)
        }
        
    }
}
