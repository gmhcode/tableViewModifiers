//
//  ModifierController.swift
//  tableViewModifiers
//
//  Created by Greg Hughes on 5/21/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class ModifierController {
    
    static var shared = ModifierController()
    var totalMods : [Modifier] = []
    var modDictionary: [String : OrderItem] = [:]
    
    func addModifierToOrder(modifier: OrderItem, isModifierFor: OrderItem, mainOrder: OrderItem){
        
//        let newMod = Modifier(name: modifier.name, isModifierFor: toModifier, mainOrder: mainOrder)
        
        modDictionary[mainOrder.uuid + modifier.uuid] = modifier
        
//        modDictionary[mainOrder.uuid + modifier.uuid] = modifier
        //        ModifierController.shared.addModifierToOrder(modifier: steak2!, to: food, mainOrder: food)
        //
        //
        //        dictionary[food.uuid] = food
        //        dictionary[food.uuid + steak2!.uuid] = steak2
        
        
        
        
        
        
        //        let newMod = Modifier(name: modifier.name, isModifierFor: order, mainOrder: mainOrder, uuid: modifier.uuid)
        
        if isModifierFor.modifiers == nil {
            isModifierFor.modifiers = [modifier] as? [Modifier]
//                as? [Modifier]
        } else {
            isModifierFor.modifiers?.append(modifier as! Modifier)
        }
        
        
        if isModifierFor != mainOrder {
            if !mainOrder.totalMods.isEmpty {
                for i in mainOrder.totalMods {
                    
                    if i == isModifierFor {
                        let index = mainOrder.totalMods.firstIndex(of: isModifierFor as! Modifier)!
                        mainOrder.totalMods.insert(modifier as! Modifier, at: index + 1)
                        mainOrder.totalMods.remove(at: index)
                        mainOrder.totalMods.insert(isModifierFor as! Modifier, at: index + 1)
                        
                        
//                        print("🔵\(i.name)")
//                        print("🔵\(index2)      \(index)")
                        
                    }
                }
                
                if !mainOrder.totalMods.isEmpty {
                    for i in OrderItemController.shared.orders {
                        if i == isModifierFor {
                            var index2 = OrderItemController.shared.orders.firstIndex(of: isModifierFor as! Modifier)!
                            OrderItemController.shared.orders.insert(modifier as! Modifier, at: index2)
                            //                        index2 = OrderItemController.shared.orders.firstIndex(of: isModifierFor as! Modifier)!
                            OrderItemController.shared.orders.remove(at: index2 + 1)
                            OrderItemController.shared.orders.insert(isModifierFor, at: index2)
                            
                        }
                    }
                }
                
                
                
                
                
                
            }
        } else {
            mainOrder.totalMods.append(modifier as! Modifier)
            OrderItemController.shared.orders.append(modifier as! Modifier)
        }
        print("🔵\(modifier.name)      \(modifier.uuid)")
//        print("🔵\(index2)      \(index)")
        
//        totalMods.append(newMod)
    }
    
    
    
    
    
}
