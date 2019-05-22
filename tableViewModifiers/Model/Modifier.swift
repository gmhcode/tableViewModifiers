//
//  Modifier.swift
//  tableViewModifiers
//
//  Created by Greg Hughes on 5/21/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//


import UIKit
class Modifier: OrderItem {
    
    var isModifierFor : OrderItem
    var mainOrder : OrderItem
    
    init(name: String, isModifierFor: OrderItem, mainOrder: OrderItem, uuid : String = UUID().uuidString )
    {
        self.isModifierFor = isModifierFor
        self.mainOrder = mainOrder
        super.init(name: name, isMainOrder: false)
        // vv doing this for equatable purposes only
        
        self.uuid = uuid
        self.text = mainOrder.uuid + isModifierFor.uuid + self.uuid

        ModifierController.shared.modDictionary[mainOrder.name + self.uuid] = self
//        mainOrder.totalMods.append(self)
        
        
        self.text.append("\n\(name) is modifier for \(String(describing: isModifierFor.name)) \n")
        
    }
    
}

