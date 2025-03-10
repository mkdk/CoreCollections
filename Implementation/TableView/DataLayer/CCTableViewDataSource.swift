//
//  CCTableViewDataSource.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewDataSourceProtocol: CCDataSourceProtocol {
    
}

class CCTableViewDataSource: CCDataSource, CCTableViewDataSourceProtocol, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.template?.viewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.template?.viewModels[section].cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.template?.viewModels[indexPath.section].cells[indexPath.row] else {
            fatalError("Cell is Nil")
        }
        
        //  Иницализация view для ячейки
        
        switch cell.nibType {
        case .reusebleId: cell.inject(view: tableView.dequeueReusableCell(withIdentifier: cell.nibId, for: indexPath) as? CCTableViewCell)
        case .nibName: cell.inject(view: self.nibCell(nameNib: cell.nibId) as? CCTableViewCell)
        }
        
        guard let viewCell = cell.getView as? UITableViewCell & CCViewCellProtocol else {
            fatalError("CCTableViewDataSource: view for id ViewModel \(String(describing: type(of: cell))) not initialization!")
        }
        
        cell.updateView()
        
        return viewCell
    }
    
}

extension CCTableViewDataSource {
    
    func nibCell<T: UIView>(nameNib: String) -> T? {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as? T
    }
    
}
