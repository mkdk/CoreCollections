//
//  CCTableViewManager.swift
//  Vezu
//
//  Created by Пользователь on 07/06/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class CCTableViewManager<T: CCTemplateViewModels>: CCManager<T> {
    
    init(delegateOutput: CCTableViewDelegateOutputProtocol, cellOutput: CCViewModelCellOutputProtocol?) {
        super.init()
        
        self.template   = T(handler: self, output: cellOutput, dataSource: self)
        
        if let template = self.template {
            self.dataSource = CCTableViewDataSource(template: template)
            self.dataHandler = CCTableViewDelegate(output: delegateOutput, template: template)
        } else {
            assertionFailure()
        }
    }
    
}
