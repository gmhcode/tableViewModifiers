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
        self.uuid = uuid
        //        self.uuid = uuid
        
//        mainOrder.totalMods.append(self)
        
        
        self.text.append("\n\(name) is modifier for \(String(describing: isModifierFor.name)) \n")
        
    }
}
