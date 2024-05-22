//
//  ViewController.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-03.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var viewModel: ViewModel!
    private var news = [News]()
    
    lazy var feedsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.refreshControl = refreshControl
        return table
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        return indicator
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(didStartRefreshing), for: .valueChanged)
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        let loadFeedUseCase = LoadFeedsUseCase(feedsRepository: FeedRepository())
        viewModel = ViewModel(loadFeedUseCase: loadFeedUseCase)
        loadNews()
    }

    private func setUpUI() {
        navigationItem.title = "Latest News"
        navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(feedsTable)
        view.addSubview(activityIndicator)
        
        feedsTable.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func loadNews() {
        Task {
            activityIndicator.startAnimating()
            let result = await viewModel.loadFeed()
            activityIndicator.stopAnimating()
            refreshControl.endRefreshing()
            switch (result) {
                case .success(let news):
                    self.news = news
                    self.feedsTable.reloadData()
                case .failure( _):
                    UtilFunctions.showAlertMessage(viewController: self, title: "Something went wrong", message: "Pull to refresh")
            }
        }
    }
    
    @objc private func didStartRefreshing() {
        loadNews()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        let newsItem = news[indexPath.row]
        cell.configure(with: newsItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = news[indexPath.row].link
        
        // Open link in browser window
        UIApplication.shared.open(URL(string: link)!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

