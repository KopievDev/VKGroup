//
//  ListVC.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

class ListVC: UIViewController, Storyboarded {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loader: UIActivityIndicatorView!

    var dataSource: Listable!
    var apiManager: API!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadData()
    }

    func setUp() {
        tableView.dataSource = dataSource
    }
    
    func loadData() {
        loader.startAnimating()
        apiManager.getServices { [weak self] services in
            self?.dataSource.set(data: services)
            self?.tableView.reloadData()
            self?.loader.stopAnimating()
        }
    }
    
    func set(dataSource: Listable, network: API) {
        self.dataSource = dataSource
        self.apiManager = network
    }
    
    @IBAction func didTapOnService(button: UIButton) {
        guard let link = button.accessibilityLabel else { return }
        UIApplication.open(urlString: link)
    }
}
