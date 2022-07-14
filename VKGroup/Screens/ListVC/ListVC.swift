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
    private let refreshControl = UIRefreshControl()

    //MARK: - Livecycle -
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
        refreshControl.attributedTitle = NSAttributedString(string: "Потяните, чтобы обновить")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.dataSource = dataSource
    }
    func set(dataSource: Listable, network: API) {
        self.dataSource = dataSource
        self.apiManager = network
    }
    
    private func loadData() {
        loader.startAnimating()
        apiManager.getServices { [weak self] services in
            guard let services = services else {
                self?.showError()
                return
            }
            self?.dataSource.set(data: services)
            self?.tableView.reloadData()
            self?.loader.stopAnimating()
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func showError() {
        UIAlertController.show(title: "Упс..🙃",
                               message: "Ошибка при загрузке данных",
                               buttonTitles: ["Повторить", "Отмена"],
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
