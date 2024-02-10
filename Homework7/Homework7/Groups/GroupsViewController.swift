//
//  GroupsViewController.swift
//  Homework1. UIKit
//
//  Created by Максим Бобков on 19.01.2024.
//

import UIKit

protocol GroupsViewControllerProtocol {
    
    func getGroups()
    func showAlert()
}

final class GroupsViewController: UITableViewController, GroupsViewControllerProtocol {

    private let networkService = NetworkService()
    
    private var coreDataService = CoreDataService()
    
    private var model: [Group] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        
        title = "Groups"
        
        // Для возможности переиспользовать ячейки
        tableView.register(GroupCell.self, forCellReuseIdentifier: "cell")
        
        // Запрашиваем список групп. Без параметров. Просто чтобы вывести данные в консоль.
        //NetworkService.getGroups()
        
        getGroups()
    }
    
    func getGroups() {
        
        // Передаём в ф-ю getGroups замыкание, которое в самой ф-и обозначим как @escaping, чтобы после выполнения ф-и сюда вернулся массив, который мы сможем положить в model.
        networkService.getGroups { [weak self] result in

            switch result {
                
            case .success(let groups):
                
                self?.model = groups
                self?.coreDataService.saveGroups(groups: groups)
                
                // Поскольку при запросе к другому серверу система переключается на другую очередь, то вручную переводим на основную очередь.
                DispatchQueue.main.async {
                    
                    // Перезагружаем таблицу
                    self?.tableView.reloadData()
                }
                
            case .failure(_):
                self?.model = self?.coreDataService.getGroups() ?? []
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.reloadData()
    }
    
    // Определяем количество ячеек в каждом разделе
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //5
        model.count
    }
    
    // Саму ячеку определяем в отдельном классе FriendsCell в отдельном файле
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Если без переиспользования ячеек:
        //GroupCell()
        
        // Проверяем, а точно ли ячейка, полученная через dequeueReusableCell, имеет нужный нам тип - GroupCell.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        
        cell.updateCell(group: model[indexPath.row])
        
        return cell
    }
    
    
    
    func showAlert() {
        
        let date = DateHelper.getDate(date: coreDataService.getGroupsDate())
        let alert = UIAlertController(
            title: "Не удалось получить данные",
            message: "Данные актуальны на \(date)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

