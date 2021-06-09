//
//  MainVC.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/03/11.
//

import UIKit

class MainVC: UIViewController {

    lazy var tvc = UINib(nibName: TableView1VC.reusableIdentifier, bundle: nil).instantiate(withOwner: self, options: [:])[0] as! TableView1VC
    
    lazy var part = [("Code로 CollectionView", "CollectionViewCodeVC", nil),
                ("UI로 CollectionView", "CollectionViewUIVC", nil),
                ("Dynamic Cell CollectionView", "CollectionViewDynamicCellVC", nil),
                ("Dynamic Cell CollectionView2", "CollectionViewDynamicCell2VC", CollectionViewDynamicCell2VC()),
                ("Dynamic Cell CollectionView3", "CollectionViewDynamicCell3VC", CollectionViewDynamicCell3VC()),
                ("TableView In CollectionView", "TableViewInCollectionViewVC", TableViewInCollectionViewVC()),
                ("JustCollectionViewVC", "JustCollectionViewVC", JustCollectionViewVC()),
                ("TableView1VC", "TableView1VC", tvc)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTableView()
    }
    
    func setTableView() {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TVC")
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return part.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TVC")
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "\(indexPath.row). \(part[indexPath.row].0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = part[indexPath.row].2 {
            navigationController?.pushViewController(vc, animated: true)
        } else {
            guard let targetVC = storyboard?.instantiateViewController(withIdentifier: part[indexPath.row].1)  else { return }
            //targetVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            //self.present(targetVC, animated: true)
            
            //self.navigationController?.pushViewController(targetVC, animated: true)
            navigationController?.pushViewController(targetVC, animated: true)
        }
    }
    
}

extension NSObject {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
