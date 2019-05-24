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
    
    init(name: String, isModifierFor: OrderItem, mainOrder: OrderItem, price: Double, uuid : String = UUID().uuidString )
    {
        self.isModifierFor = isModifierFor
        self.mainOrder = mainOrder
        super.init(name: name, isMainOrder: false, price: price, seat: mainOrder.seat)
        self.uuid = uuid
        
        // vv doing this for equatable purposes only
        self.text = "\(mainOrder.name)    " + mainOrder.uuid + isModifierFor.uuid + self.uuid + "\(isModifierFor.modifiers.count) + mainCount \(mainOrder.totalMods.count)"

        ModifierController.shared.modDictionary[mainOrder.uuid + self.uuid] = self
        
        
        
        self.text.append("\n\(name) is modifier for \(String(describing: isModifierFor.name)) \n")
        
    }
    
    
    
    override var modifiers: [Modifier] {
        
        willSet
        {
            //doing this will allow us to remove mods from the isModifiedFor.modifiers when we remove mods from self
            for i in modifiers {
                if isModifierFor.modifiers.contains(i) {
                    let index = isModifierFor.modifiers.firstIndex(of: i)!
                    isModifierFor.modifiers.remove(at: index)
                }

            }
            
            
        }
        didSet
        {
            //in willSet we removed all mods that were the same, now we add all out modifiers to isModifierFor mods, we need this for when we remove mods. if we dont do this, the modifiers will not align with isModifierFor
            isModifierFor.modifiers += modifiers
//            mainOrder.totalMods += modifiers
        }
    }
    
    
    
    override var seat: Seat? {
        didSet {
            
        }
    }
    
    
    
}


