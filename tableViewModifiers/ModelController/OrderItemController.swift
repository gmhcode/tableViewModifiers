//
//  OrderItemController.swift
//  tableViewModifiers
//
//  Created by Greg Hughes on 5/21/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class OrderItemController{
    
    static let shared = OrderItemController()
    
    var orders : [OrderItem] = []
    var currentOrderItem : OrderItem?
}

