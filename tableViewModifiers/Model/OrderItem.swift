//
//  OrderItem.swift
//  tableViewModifiers
//
//  Created by Greg Hughes on 5/21/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit
class OrderItem{
    
    
    //    var uuid : UUID?
    var modifiers : [Modifier] = []

    var uuid : String
    let name : String
    var text : String = ""
    var isMainOrder = true
    var totalMods : [Modifier] = []
    var price : Double
    
    var stackView: UIStackView?
    
    init(name: String, uuid : String = UUID().uuidString, isMainOrder: Bool, price: Double) {
        self.name = name
        self.uuid = uuid
        self.isMainOrder = isMainOrder
        self.price = price
        self.text = uuid
    }
}


//func populateTotalMods





extension OrderItem: Equatable {
    static func == (lhs: OrderItem, rhs: OrderItem) -> Bool {
        
        return lhs.uuid == rhs.uuid
            && lhs.name == rhs.name
            && lhs.modifiers == rhs.modifiers
            && lhs.uuid == rhs.uuid
            && lhs.text == rhs.text
            && lhs.price == rhs.price
    }
}
extension OrderItem: Hashable
{
    var hashValue: Int {
        return uuid.hashValue
    }
}
