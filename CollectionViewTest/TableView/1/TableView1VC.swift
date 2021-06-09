//
//  TableView1VC.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/06/07.
//

import UIKit

class TableView1VC: UIViewController {
    
    lazy var tableView: UITableView = UITableView(frame: .zero) {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension // 유동적인 셀 높이 설정
            tableView.estimatedRowHeight = 300 // 최소 셀 높이 설정
        }
    }
    
    lazy var input: UITextField = UITextField()
    
    var items: [TableView1Model?] = [TableView1Model]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        view.addSubview(input)
        input.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [input.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
             input.heightAnchor.constraint(equalToConstant: 50),
             input.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
             input.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
        
        input.backgroundColor = .yellow
                
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
             tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
             tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: input.topAnchor)])
        
        tableView.backgroundColor = .red
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // 섹션에 대한 헤더
        // tableView.register(UINib(nibName: StoryDetailHeaderCell.reusableIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: StoryDetailHeaderCell.reusableIdentifier)
        
        tableView.register(UINib(nibName: ContentTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: ContentTableViewCell.reusableIdentifier)
        tableView.register(UINib(nibName: ContentImagesTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: ContentImagesTableViewCell.reusableIdentifier)
        tableView.register(UINib(nibName: ReplyTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: ReplyTableViewCell.reusableIdentifier)
        
        // 테이블 뷰 전체에 대한 헤더
        setHeader()
        
        items.append(ContentModel(name: "first man"))
        items.append(ImageModel(items: ["1", "2", "3"]))
        items.append(ReplyModel(items: [1,2,3,4,5,6]))
        
        tableView.reloadData()
        
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let btnDoneBar = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.didClick(_:)))
        toolBarKeyboard.items = [btnDoneBar]
        
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.2980392157, green: 0.6862745098, blue: 0.3137254902, alpha: 1)
        
        input.inputAccessoryView = toolBarKeyboard
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ sender: Notification) {
        
//        guard let keyboardFrame = sender.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//        tableView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
        
        
        print("keyboard was shown")
        guard let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        //tableView.scrollIndicatorInsets = tableView.contentInset

    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        //tableView.contentInset.bottom = 0
        
        
        print("keyboard will be hidden")
        tableView.contentInset = UIEdgeInsets.zero
        //tableView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @IBAction func didClick(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    func setHeader() {
        guard let header = UINib(nibName: StoryDetailHeaderCell.reusableIdentifier, bundle: nil)
                .instantiate(withOwner: self, options: [:])[0] as? StoryDetailHeaderCell
        else { fatalError() }
        
        header.name.text = "hi roo"
        header.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        
        tableView.tableHeaderView = header
    }
}

extension TableView1VC: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: StoryDetailHeaderCell.reusableIdentifier) as? StoryDetailHeaderCell
//        else { fatalError() }
//
//        header.name.text = "hi yo"
//
//        return header
//    }
}
extension TableView1VC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = items[section] as? ContentModel {
            return 1
        }
        else if let imageModel = items[section] as? ImageModel {
            return imageModel.items.count
        }
        else if let replyModel = items[section] as? ReplyModel {
            return replyModel.items.count
        } else {
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.reusableIdentifier) as? ContentTableViewCell,
                  let contentModel = items[indexPath.section] as? ContentModel
            else { fatalError() }
            
            cell.test.text = contentModel.name
            cell.backgroundColor = .random
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentImagesTableViewCell.reusableIdentifier) as? ContentImagesTableViewCell,
                  let imageModel = items[indexPath.section] as? ImageModel
            else { fatalError() }
            
            cell.picture.image = UIImage(named: imageModel.items[indexPath.row])
            cell.backgroundColor = .random
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReplyTableViewCell.reusableIdentifier) as? ReplyTableViewCell,
                  let replyModel = items[indexPath.section] as? ReplyModel
            else { fatalError() }
            
            cell.name.text = "\(replyModel.items[indexPath.row])"
            
            var text = "asdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjklasdfghjk"
            
            for _ in 0 ..< indexPath.row {
                text += text
            }
            
            if indexPath.row % 2 == 0 {
                cell.emoticonView.isHidden = true
            } else {
                cell.emoticonView.isHidden = false
            }
            cell.contents.text = text
            cell.backgroundColor = .random
            return cell
        }
    }
}

class StoryDetailHeaderCell: UITableViewHeaderFooterView {
    
    /*
     
      [header]
      profile - flag - name ----------------- time
      
     */
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    
}

class StoryDetailFooterCell: UITableViewCell {
    /*
     
     
     like-reply-------------translate
     
     */
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var tranlateButton: UIButton!
    
}

class ContentTableViewCell: UITableViewCell {
    /*
     
     pictures (tableview)
     
     likes & comments
     
     contents
     */
    @IBOutlet weak var test: UILabel!
}


class ContentImagesTableViewCell: UITableViewCell {
    @IBOutlet weak var picture: UIImageView!
}

extension ContentImagesTableViewCell: UIScrollViewDelegate {
    
    @available(iOS 2.0, *)
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.picture
    }
}

class ReplyTableViewCell: UITableViewCell {
    
    /*
     profile - flag - name ---- time
     (name for reply) content-----------tranlate
     */
    
    @IBOutlet weak var profile: UIButton!
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var nameForReply: UILabel!
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var emoticonView: UIView!
    
}
