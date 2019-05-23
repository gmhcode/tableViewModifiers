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
    
    
    
    
    func removeMod(uuid: String, fromModifier: Modifier){
        var orderToRemove = OrderItem(name: "hold", isMainOrder: true, price: 0.00)
        var modToRemove = Modifier(name: "a", isModifierFor: orderToRemove, mainOrder: orderToRemove, price: 0.00)
        
        
        
        if fromModifier.isMainOrder == false && fromModifier.modifiers.count > 0 {
            
            
            
            for i in fromModifier.modifiers {
                
                if i.uuid == uuid {
                    modToRemove = i
                    let index = fromModifier.modifiers.firstIndex(of: modToRemove)!
                    fromModifier.modifiers.remove(at: index)
                    
                    if fromModifier.mainOrder.totalMods.contains(modToRemove){
                        let totalIndex = fromModifier.mainOrder.totalMods.firstIndex(of: modToRemove)!
                        fromModifier.mainOrder.totalMods.remove(at: totalIndex)
                    }
                    
                    if OrderItemController.shared.orders.contains(modToRemove){
                        let ordersIndex = OrderItemController.shared.orders.firstIndex(of: modToRemove)!
                        OrderItemController.shared.orders.remove(at: ordersIndex)
                    }
                    break
                    
                }
            }
        }
    }
    
    
    func seatForLoop(modifier: OrderItem, isModifierFor: OrderItem, mainOrder: OrderItem, seat: Seat) {
        if !mainOrder.totalMods.isEmpty {
            for i in seat.orders {
                if i == isModifierFor {
                    let index2 = seat.orders.firstIndex(of: isModifierFor as! Modifier)!
                    if isModifierFor.modifiers.count > 0 {
                        seat.orders.insert(modifier as! Modifier, at: index2 + isModifierFor.modifiers.count )
                    } else {
                        seat.orders.insert(modifier as! Modifier, at: index2)
                        seat.orders.remove(at: index2 + 1)
                        seat.orders.insert(isModifierFor, at: index2)
                        print("🔴\(i.name)")
                    }
                }
            }
        }
    }
    func seatForLoopModIsMain(modifier: OrderItem, isModifierFor: OrderItem, mainOrder: OrderItem, seat: Seat) {
        if !mainOrder.totalMods.isEmpty {
            for i in seat.orders {
                if i == isModifierFor {
                    
                    let index2 = seat.orders.firstIndex(of: isModifierFor)!
                    
                    if isModifierFor.modifiers.count > 0 {
                        seat.orders.insert(modifier as! Modifier, at: index2 + isModifierFor.modifiers.count )
                    } else {
                        seat.orders.insert(modifier as! Modifier, at: index2)
                        seat.orders.remove(at: index2 + 1)
                        seat.orders.insert(isModifierFor, at: index2)
                        print("🔴\(seat.seatNumber)")
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    func addModifierToOrder(modifier: OrderItem, isModifierFor: OrderItem, mainOrder: OrderItem, seat: Seat){
        
        
        
        
        isModifierFor.modifiers.append(modifier as! Modifier)
        
        
        if isModifierFor != mainOrder {
            if !mainOrder.totalMods.isEmpty {
                for i in mainOrder.totalMods {
                    
                    if i == isModifierFor {
                        let index = mainOrder.totalMods.firstIndex(of: isModifierFor as! Modifier)!
//                        mainOrder.totalMods.insert(modifier as! Modifier, at: index)
//                        mainOrder.totalMods.remove(at: index + 1)
//                        mainOrder.totalMods.insert(isModifierFor as! Modifier, at: index)
                        mainOrder.totalMods.append(modifier as! Modifier)
                        
                        
                        print("🔵\(i.name)")
//                        print("🔵\(index2)      \(index)")
                        
                    }
                }
                
                if !mainOrder.totalMods.isEmpty {
                    for i in OrderItemController.shared.orders {
                        if i == isModifierFor {
                            let index2 = OrderItemController.shared.orders.firstIndex(of: isModifierFor)!
                            
                            if isModifierFor.modifiers.count > 0 {
                                OrderItemController.shared.orders.insert(modifier as! Modifier, at: index2 + isModifierFor.modifiers.count )
                            }
                            else {
                                OrderItemController.shared.orders.insert(modifier as! Modifier, at: index2)
                                OrderItemController.shared.orders.remove(at: index2 + 1)
                                OrderItemController.shared.orders.insert(isModifierFor, at: index2)
                                print("🔴\(i.name)")
                            }
                        }
                    }
                }
            }
            
            
            
            
            
            seatForLoop(modifier: modifier, isModifierFor: isModifierFor, mainOrder: mainOrder, seat: seat)
            
            
            
            
            
            
            
            
            
            
            
            
        } else {
            mainOrder.totalMods.append(modifier as! Modifier)

            for i in OrderItemController.shared.orders {
                if i == isModifierFor {
                    
                    let index2 = OrderItemController.shared.orders.firstIndex(of: isModifierFor)!
                    
                    if isModifierFor.totalMods.count > 0 {
                        OrderItemController.shared.orders.insert(modifier as! Modifier, at: index2 + isModifierFor.totalMods.count )
                    } else {
                        OrderItemController.shared.orders.insert(modifier as! Modifier, at: index2)
                        OrderItemController.shared.orders.remove(at: index2 + 1)
                        OrderItemController.shared.orders.insert(isModifierFor, at: index2)
                        print("🔴\(i.name)")
                    }
                }
            }
            
            seatForLoopModIsMain(modifier: modifier, isModifierFor: isModifierFor, mainOrder: mainOrder, seat: seat)
            
            
            
        }
    }
}
