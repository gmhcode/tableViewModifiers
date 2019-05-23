//
//  Seat.swift
//  tableViewModifiers
//
//  Created by Greg Hughes on 5/22/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit
class Seat {
    
    var orders : [OrderItem] = []
    var seatNumber : Int
    var uuid : String
    
    
    init(seatnumber: Int, uuid: String = UUID().uuidString) {
        self.seatNumber = seatnumber
        self.uuid = uuid
    }
    
    
    
}

extension Seat: Equatable {
    static func == (lhs: Seat, rhs: Seat) -> Bool {
        
        return lhs.uuid == rhs.uuid && lhs.seatNumber == rhs.seatNumber
    }
}
extension Date{
    var asString: String{
        let formatter = DateFormatter()
        
        formatter.dateStyle = .full
        return formatter.string(from: self)
    }
}

extension String {
    var asDouble : Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        return formatter.number(from: self) as! Double
        
    }
}
