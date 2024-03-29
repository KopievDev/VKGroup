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
    
    @IBAction private func openLoyalty(button: UIButton) {
        guard let vc = LoyaltyVC.instantiate() else { return }
        present(vc, animated: true)
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
        cache.append([.reuse:CollectionCell.reuseId, .data: ["items": [[:],[:],[:],[:],[:],[:]] ] ])
        cache.append([.reuse:TitleCell.reuseId, .data: ["name": "Как накопить бонусы?"]])
        cache.append([.reuse:EnumeratedCell.reuseId, .data: ["name": "За все потраченные рубли при заказе в интернет-витрине или покупке в винотеке вы получаете бонусы в размере 5%", "number": "1"]])
        cache.append([.reuse:EnumeratedCell.reuseId, .data: ["name": "Ваша скидка увеличивается на 5% при увеличении общей суммы покупок за год. Максимальная скидка 15%", "number": "2"]])
        
        cache.append([.reuse:TitleCell.reuseId, .data: ["name": "Как накопить бонусы?"]])
        cache.append([.reuse:EnumeratedCell.reuseId, .data: ["name": "Бонусами можно оплатить до 50% стоимости покупки по курсу 1 бонус = 1 рубль", "number": "1"]])
        cache.append([.reuse:EnumeratedCell.reuseId, .data: ["name": "Бонусами нельзя оплатить дегустации и другие услуги", "number": "2"]])
        
        cache.append([.reuse:TitleCell.reuseId, .data: ["name": "Кое-что еще"]])
        cache.append([.reuse:EnumeratedCell.reuseId, .data: ["name": "Бонусы начисляются уже с первого заказа или покупки", "number": "1"]])
        cache.append([.reuse:EnumeratedCell.reuseId, .data: ["name": "Начисленные бонусы активируются через 14 дней после начисления", "number": "2"]])
        cache.append([.reuse:EnumeratedCell.reuseId, .data: ["name": "Срок жизни бонусов – год со дня начисления. Торопитесь потратить!", "number": "3"]])
        cache.append([.reuse:ButtonCell.reuseId, .data: ["name": "Полные условия программы"]])

        
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
    
    @objc func test() {
        print(#function)
    }
}
