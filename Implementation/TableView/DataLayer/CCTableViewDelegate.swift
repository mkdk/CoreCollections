//
//  CCTableViewDelegate.swift
//  Vezu
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import UIKit

protocol CCTableViewDelegateOutputProtocol: class {
    func didSelect(indexPath: IndexPath, id: String?)
}

protocol CCTableViewDelegateProtocol: class {
    
}

class CCTableViewDelegate: CCDelegate, CCTableViewDelegateProtocol, UITableViewDelegate {
    
    //  MARK: Properties

    private weak var output:            CCTableViewDelegateOutputProtocol?
    
    init(sectionsExecutor: CCDataSourceExecuteViewModelsSectionsProtocol?, cellsExecutor: CCDataSourceExecuteViewModelsCellsProtocol?, output: CCTableViewDelegateOutputProtocol?) {
        self.output = output
        super.init(sectionsExecutor: sectionsExecutor, cellsExecutor: cellsExecutor)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = self.cellsExecutor?.cell(at: indexPath) {
            self.output?.didSelect(indexPath: indexPath, id: cell.modelId)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = cellsExecutor?.cell(at: indexPath) {
            return CGFloat(cell.height)
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let item = self.sectionsExecutor?.item(at: section)
        
        //  Иницализация view для секции
        
        switch item?.header?.nibType {
//        case .reusebleId?:  cell?.inject(view: tableView.dequeueReusableCell(withIdentifier: viewModelSection!.nibId, for: indexPath) as? CCViewProtocol); break;
        case .nibName?: item?.header?.inject(view: self.nibSection(nameNib: item!.header!.nibId) as? CCTableViewSection); break;
        default:break;
        }
        
        item?.header?.updateView()
        
        return item?.header?.getView as? UIView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = self.sectionsExecutor?.item(at: section)
        return CGFloat(item?.header?.height ?? .zero)
    }
    
}

extension CCTableViewDelegate {
    
    func nibSection<T: UIView>(nameNib: String) -> T {
        return Bundle.main.loadNibNamed(String(describing: nameNib), owner: nil, options: nil)![0] as! T
    }
    
}
