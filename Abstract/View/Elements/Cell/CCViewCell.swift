//
//  CCViewCell.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCViewCellProtocol: CCViewProtocol {
    var output: CCViewModelCellOutputProtocol? { get set }
}

protocol CCViewHighlightedCellProtocol {
    func highlight()
    func unhiglight()
}
