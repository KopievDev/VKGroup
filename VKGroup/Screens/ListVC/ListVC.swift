//
//  ListVC.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

final class ListVC: UIViewController, Storyboarded {
    //MARK: - Properties -
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loader: UIActivityIndicatorView!
    private var dataSource: Listable!
    private var apiManager: API!
    private lazy var refreshControl = UIRefreshControl(text: "Pull to refresh".localized, target: self, action: #selector(refresh))

    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadData()
    }

    //MARK: - IBAction -
    @IBAction private func didTapOnService(button: UIButton) {
        guard let link = button.accessibilityLabel else { return }
        UIApplication.open(urlString: link)
    }
    
    //MARK: - Helpers -
    private func setUp() {
        tableView.addSubview(refreshControl)
        dataSource.set(tableView: tableView)
    }
    
    func set(dataSource: Listable, network: API) {
        self.dataSource = dataSource
        self.apiManager = network
    }
    
    private func loadData() {
        loader.startAnimating()
        apiManager.getServices { [weak self] services in
            guard let services = services else { self?.showError(); return }
            self?.set(services: services)
        }
    }
    
    private func set(services: [[String:Any]]) {
        var cache = services
        cache.append([.reuse:CollectionCell.reuseId,
                      .data: ["items": [[:],[:],[:],[:],[:],[:]] ] ])
        cache.append([.reuse:CollectionCell.reuseId,
                      .data: ["items": [[:],[:],[:]] ] ])
        
        dataSource.set(data: cache)
        loader.stopAnimating()
        refreshControl.endRefreshing()
    }
    
    private func showError() {
        UIAlertController.show(title: "Ops..🙃".localized,
                               message: "Error loading data".localized,
                               buttonTitles: ["Repeat".localized, "Cancel".localized],
                               style: .alert) { selected in
            switch selected {
            case 0: self.loadData()
            default: self.loader.stopAnimating()
            }
        }
    }
    
    //MARK: - Selectors -
    @objc func refresh() {
       loadData()
    }
}
