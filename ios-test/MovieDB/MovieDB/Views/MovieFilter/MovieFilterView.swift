////
////  MovieFilterView.swift
////  MovieDB
////
////  Created by Eddwin Paz on 9/10/19.
////  Copyright © 2019 acme dot inc. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class MovieFilterView: UIView {
//
//    var filterDelegate: FilterSelectionDelegate!
//    var controller: MovieFilterController!
//    var tableView = UITableView()
//    var dataSource = [FilterRows]()
//    let cell_filter_id = "cell_filter_id"
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        createSubviews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        createSubviews()
//    }
//
//    func createSubviews() {
//        backgroundColor = .white
//    }
//
//    let applyFilterButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.backgroundColor = UIColor(red: 0.967, green: 0.806, blue: 0.357, alpha: 1.0)
//        btn.setTitle("Apply Filter", for: .normal)
//        btn.tintColor = .black
//        btn.layer.cornerRadius = 5
//        btn.clipsToBounds = true
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.addTarget(self, action: #selector(applyFilterAction), for: .touchUpInside)
//        return btn
//    }()
//
//    @objc func applyFilterAction() {
//        filterDelegate.searchWithFilter(year: self.dataSource[0].value,
//                                        genre: self.dataSource[1].value)
//        controller.navigationController?.popViewController(animated: true)
//    }
//}
//
