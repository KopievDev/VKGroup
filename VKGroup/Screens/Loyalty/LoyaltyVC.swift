//
//  LoyaltyVC.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 27.08.2022.
//

import UIKit

class LoyaltyVC: UIViewController, Storyboarded {
    //MARK: - Properties -
    @IBOutlet private var tableView: UITableView!
    private lazy var dataSource: Listable = DataSource(tableView: tableView)
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.set(data: DataBuilder(data: [:]).getLoyaltyProgram())
    }
    //MARK: - IBAction -
    @IBAction func didTapClose(Button: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapFullTerms(Button: UIButton) {
        print(#function)
    }
}

struct DataBuilder {
    var data: [String:Any]
    func getLoyaltyProgram() -> [[String:Any]] {
        var cache: [[String:Any]] = []
        cache.append([.reuse:NavCell.reuseId, .data: ["name": "Програма лояльности"]])
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
        return cache
    }
}

