//
//  CCModelSection.swift
//  CoreCollection
//
//  Created by Пользователь on 24/04/2019.
//  Copyright © 2019 com.skibinalexander.ru. All rights reserved.
//

import Foundation

protocol CCModelSectionProtocol: CCModelProtocol {
    var cells: [CCModelCellProtocol]   { get set }
}
