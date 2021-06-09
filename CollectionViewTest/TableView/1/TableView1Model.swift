//
//  TableView1Model.swift
//  CollectionViewTest
//
//  Created by moonkyoochoi on 2021/06/08.
//

import Foundation

protocol TableView1Model {
//    associatedtype T
//    var items:[T] { get }
}

struct ContentModel: TableView1Model {
    var name: String
}

struct ImageModel: TableView1Model {
    var items: [String]
}

struct ReplyModel: TableView1Model {
    var items: [Int]
}
