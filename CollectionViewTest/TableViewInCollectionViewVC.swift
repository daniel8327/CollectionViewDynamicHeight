//
//  TableViewInCollectionView.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/06/07.
//

import UIKit

class TableViewInCollectionViewVC: UIViewController {
    
    var tableView = UITableView(frame: .zero) {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension // 유동적인 셀 높이 설정
            tableView.estimatedRowHeight = 300 // 최소 셀 높이 설정
        }
    }
    
    var items: [String] = (1...2).map { "\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
             tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
             tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
        
        tableView.backgroundColor = .red
        
        tableView.dataSource = self
        
        tableView.register(TableViewInCollectionViewCell1.self, forCellReuseIdentifier: TableViewInCollectionViewCell1.reusableIdentifier)
        
    }
}

extension TableViewInCollectionViewVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//        cell.textLabel?.text = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewInCollectionViewCell1.reusableIdentifier) as! TableViewInCollectionViewCell1
        
        
        return cell
    }
    
    
}

extension TableViewInCollectionViewVC: UITableViewDelegate {
    
}
