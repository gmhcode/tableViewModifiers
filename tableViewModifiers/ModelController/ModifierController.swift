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
    var modDictionary: [String : Modifier] = [:]
    var ordersToMove : [OrderItem] = []
    
    
    
    
    
    func removeModFromOrder(modifierUUID: String, fromModifier: OrderItem){
        
        guard let modifier = findModifierWith(uuid: modifierUUID, fromModifier: fromModifier) else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        //remove modifier first or it will not be removed in some instances
        removeModFromOrderMods(modifier: modifier, fromModifier: fromModifier)
        removeModFromTotalMods(modifier: modifier, fromModifier: fromModifier)
        removeModFromSeat(modifier: modifier, fromModifier: fromModifier)
        
        if modifier.modifiers.count > 0 {
            for i in modifier.modifiers {
                // remove need to remove from order mods and total mods because they cant share info
                removeModFromOrderMods(modifier: i, fromModifier: fromModifier)
                removeModFromTotalMods(modifier: i, fromModifier: fromModifier)
                //if we dont remove from seat then they will remain
                removeModFromSeat(modifier: i, fromModifier: fromModifier)
            }
        }
    }
    
    func removeOrderFromSeat(order: OrderItem){
        guard let seat = order.seat else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        for seatOrder in seat.orders {
            if seatOrder == order {
                for modifier in seatOrder.modifiers {
                    seat.orders.removeAll(where: {$0 == modifier})
                }
            }
            seat.orders.removeAll(where: {$0 == order})
        }
        
    }
    
    func removeSeat(seat: Seat){
        
        SeatsController.shared.seats.removeAll(where: {$0 == seat})
        
        
        
    }
    
    
    fileprivate func findModifierWith(uuid: String, fromModifier: OrderItem)-> Modifier? {
        
        for i in fromModifier.modifiers {
            
            if i.uuid == uuid {
                
               
                return i
                
                
            }
        }
        return nil
    }

    fileprivate func removeModFromOrderMods(modifier: Modifier, fromModifier: OrderItem){
        
        if fromModifier.modifiers.isEmpty == false {
            
            for i in fromModifier.modifiers{
                removeModFromOrderMods(modifier: modifier, fromModifier: i)
                
            }
            if (fromModifier.modifiers.contains(modifier))
            {
                fromModifier.modifiers.removeAll(where: {$0 == modifier || $0 == modifier.isModifierFor})
            }
        }
    }
    
    
    fileprivate func removeModFromTotalMods(modifier: Modifier, fromModifier: OrderItem){
        
        if fromModifier == fromModifier as? Modifier {
            let mod = fromModifier as! Modifier
            for i in mod.mainOrder.totalMods{
                
                if i == modifier {
                    mod.mainOrder.totalMods.removeAll(where: {$0 == i || $0 == i.isModifierFor})
                }
            }
        }
        else{
            for i in fromModifier.totalMods{
                
                if i == modifier {
                    fromModifier.totalMods.removeAll(where: {$0 == i})
                }
            }
        }
        
        
        
        
        
        
    }
    
   fileprivate func removeModFromSeat(modifier: Modifier, fromModifier: OrderItem){
        
        if fromModifier == fromModifier as? Modifier {
            let mod = fromModifier as! Modifier
            
            for i in mod.mainOrder.seat!.orders {
                
                if i == modifier && i == i as? Modifier {
                    
                    mod.mainOrder.seat!.orders.removeAll(where: {$0 == i || $0 == (i as! Modifier).isModifierFor})
                }
            }
        }
        else {
           
            
            for _ in fromModifier.seat!.orders {
                fromModifier.seat!.orders.removeAll(where: {$0 == modifier})
                }
            }
    }
    
    
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    fileprivate func seatForLoop(modifier: OrderItem, isModifierFor: OrderItem, mainOrder: OrderItem, seat: Seat) {
        if !mainOrder.totalMods.isEmpty {
            for i in seat.orders {
                if i == isModifierFor {
                    let index2 = seat.orders.firstIndex(of: isModifierFor as! Modifier)!
                    if isModifierFor.modifiers.count > 1 {
                        seat.orders.insert(modifier as! Modifier, at: index2 + isModifierFor.modifiers.count )
                    } else {
                        /*this inserts the modifier on top on the isModifierFor, then removes the isModifierFor and inserts it on top of the modifier. if we dont do this, all the modifiers will appear on top of the ismodifiers */
                        seat.orders.insert(modifier as! Modifier, at: index2)
                        seat.orders.remove(at: index2 + 1)
                        seat.orders.insert(isModifierFor, at: index2)
                        print("🔴\(i.name)")
                    }
                }
            }
        }
    }
    
    fileprivate func seatForLoopModIsMain(modifier: OrderItem, isModifierFor: OrderItem, mainOrder: OrderItem, seat: Seat) {
        if !mainOrder.totalMods.isEmpty {
            for i in seat.orders {
                if i == isModifierFor {
                    
                    let index2 = seat.orders.firstIndex(of: isModifierFor)!
                    
                    if isModifierFor.modifiers.count > 0
                    {
                        seat.orders.insert(modifier as! Modifier, at: index2 + isModifierFor.modifiers.count)
                    }
                    else
                    {
                        //might not need this
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
//                        let index = mainOrder.totalMods.firstIndex(of: isModifierFor as! Modifier)!

                        mainOrder.totalMods.append(modifier as! Modifier)
                        //need to break here or we will get duplicates
                        break
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
        //we need to set ordersToMove to nothing here or when something is moving it will leave some mods behind

        ordersToMove = []
    }
}
