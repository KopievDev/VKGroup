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
    let screenData = ScreenData()
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    //MARK: - IBAction -
    @IBAction func didTapClose(Button: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapFullTerms(Button: UIButton) {
        screenData.enumCells.forEach { $0.title = "its work" }
        update()
    }
    
    func update() {
        dataSource.set(data: screenData.getData())
    }
}

class ScreenData {
    class EnumeratedData {
        init(name: String, number: Int, id: String = UUID().uuidString) {
            self.name = name
            self.number = number
            self.id = id
        }
        
        var name: String
        var number: Int
        var id: String = UUID().uuidString
    }
    
    class EnumCell {
        init(title: String, array: [ScreenData.EnumeratedData] = []) {
            self.title = title
            self.array = array
        }
        
        var title: String
        var array: [EnumeratedData] = []
    }
    
    var enumCells: [EnumCell] = [
        EnumCell(title: "Как накопить бонусы?", array: [
            EnumeratedData(name: "За все потраченные рубли при заказе в интернет-витрине или покупке в винотеке вы получаете бонусы в размере 5%", number: 1),
            EnumeratedData(name: "Ваша скидка увеличивается на 5% при увеличении общей суммы покупок за год. Максимальная скидка 15%", number: 2)]),
        EnumCell(title: "Как накопить бонусы?", array: [
            EnumeratedData(name: "Бонусами можно оплатить до 50% стоимости покупки по курсу 1 бонус = 1 рубль", number: 1),
            EnumeratedData(name: "Бонусами нельзя оплатить дегустации и другие услуги", number: 2)]),
        EnumCell(title: "Кое-что еще", array: [
            EnumeratedData(name: "Бонусы начисляются уже с первого заказа или покупки", number: 1),
            EnumeratedData(name: "Начисленные бонусы активируются через 14 дней после начисления", number: 2),
            EnumeratedData(name: "Срок жизни бонусов – год со дня начисления. Торопитесь потратить!", number: 3)]),
    ]
    
    func getData() -> [[String:Any]] {
        var result = [[String:Any]]()
        result.append([.reuse:NavCell.reuseId, .data: ["name": "Програма лояльности"]])
        result.append([.reuse:CollectionCell.reuseId, .data: ["items": [[:],[:],[:],[:],[:],[:]] ] ])
        enumCells.forEach { cell in
            result.append([.reuse:TitleCell.reuseId, .data: ["name": cell.title]])
            cell.array.forEach { result.append([.reuse:EnumeratedCell.reuseId, .data: ["name": $0.name, "number": "\($0.number)"]]) }
        }
        result.append([.reuse:ButtonCell.reuseId, .data: ["name": "Полные условия программы"]])
        return result
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

