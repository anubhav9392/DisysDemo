//
//  HomeViewController.swift
//  DisysDemo
//
//  Created by Vinculum on 31/8/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class HomeViewController: UIViewController {

    var viewModel: NewsListViewModel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    let refreshControl = UIRefreshControl()
    let cellIdentifier = "NewsCell"
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsListViewModel(service: APIService())
        self.title = "NewsList"
        tableView.delegate = nil
        tableView.dataSource = nil
        refreshControl.addTarget(self, action: #selector(refreshNewsData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        bindViewModel()
        // Do any additional setup after loading the view.
    }
    @objc private func refreshNewsData(_ sender: Any) {
        // Fetch News feed Data
        viewModel.fetchNews()
    }
    
    func bindViewModel() {
           viewModel.showLoader
                .bind(to: refreshControl.rx.isRefreshing)
                .disposed(by: disposeBag)
            viewModel.newsList
                .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) {(index, newsObj, cell) in
                    if let cell = cell as? NewsTableViewCell {
                        cell.name.text = newsObj.title
                        cell.lbldescription.text = newsObj.description
                        cell.lblDate.text = newsObj.date ?? ""
                        cell.imgView.kf.setImage(with: URL(string:newsObj.image ?? ""))
                    }
            }
            .disposed(by: disposeBag)
        }

}
