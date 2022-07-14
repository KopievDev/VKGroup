//
//  ListVC.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

class ListVC: UIViewController, Storyboarded {

    @IBOutlet private var tableView: UITableView!
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
        apiManager.getServices { [weak self] services in
            self?.dataSource.set(data: services)
            self?.tableView.reloadData()
        }
    }
    
    func set(dataSource: Listable, network: API) {
        self.dataSource = dataSource
        self.apiManager = network
    }

}

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = dataSource.data(for: indexPath)[d: .data][s: .link]
        UIApplication.open(urlString: link)
    }
}
