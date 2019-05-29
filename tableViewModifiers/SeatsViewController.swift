//
//  SeatsViewController.swift
//  tableViewModifiers
//
//  Created by Greg Hughes on 5/22/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class SeatsViewController: UIViewController {
    
    
    var steak = OrderItem(name: "steak", isMainOrder: true, price: 10.00, seat: nil)
    var potato : Modifier?
    var cheese : Modifier?
    var baked : Modifier?
    var burned : Modifier?
    var steak2 : Modifier?
    var potato2 : Modifier?
    var potato3 : Modifier?
    var potato4 : Modifier?
    var potato5 : Modifier?
    
    
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var selectedColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    lazy var defaultCellHeight = view.bounds.width * 0.10
    var orders : [OrderItem] {
        get{
            return OrderItemController.shared.orders
        }
    }
    
    
    var dict : [String : Modifier] {
        get{
            return ModifierController.shared.modDictionary
        }
    }
    
    
    
    var selectedSeat : Seat? {
        willSet {
            
        }
        didSet {
            
        }
    }
    var selectedCell = UITableViewCell()
    var selectedOrder : OrderItem?
    /*
     selectedRows gets populated whenever an item is select, gets depopulated by delesecting items or running the assignOrderTo() function
     */
    
    
    /*
     seats have an array of orders inside of them.
     the number and name of sections is determined by the amount of seats in this list
     the number of rows per section and name of the orders is determined by the orderlist in each seat
     */
    
    
    
    
    
    var seats : [Seat]
        // Seat(seatnumber: 1), Seat(seatnumber: 2)
        {
        get {
            return SeatsController.shared.seats
        }
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        //        prevents bouncing on reload data
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        setSeats()
        
    }
    
    func addNewItem(name: String, price: Double){
        
        if seats == [] {
            createNewSeat()
        }
        
        
        SeatsController.shared.seats.last?.orders.append(OrderItem(name: name, isMainOrder: true, price: price, seat: SeatsController.shared.seats.last))
        
        tableView.reloadData()
    }
    
    
    
    @IBAction func addChicken(_ sender: Any) {
        addNewItem(name: "cat", price: 10.00)
    }
    
    @IBAction func addDrink(_ sender: Any) {
        addNewItem(name: "Drink", price: 1.00)
    }
    
    
    @IBAction func newSeatButtonTapped(_ sender: Any) {
        
        
        let newSeat = Seat(seatnumber: seats.count + 1)
        //        seats.count > 0 ? newSeat.seatNumber = seats[seats.count - 1].seatNumber + 1 : (newSeat.seatNumber = seats.count + 1)
        
        SeatsController.shared.seats.append(newSeat)
        //        selectedSeat = newSeat
        
        tableView.reloadData()
        
        tableView.scrollToRow(at: IndexPath(row: NSNotFound, section: seats.count - 1), at: .bottom, animated: false)
        
    }
    
    
    
    @IBAction func newOrderButtonTapped(_ sender: Any) {
        var selectedSeat = seats[seats.count - 1]
        if self.selectedSeat != nil {
            selectedSeat = self.selectedSeat!
        }
        
        
        
        let food = OrderItem(name: "food \(orders.count)", isMainOrder: true, price: 10.00, seat: selectedSeat)
        OrderItemController.shared.orders.append(food)
        selectedSeat.orders.append(food)
        
        //        steak2 = Modifier(name: "steak", isModifierFor: food, mainOrder: food, price: steak2!.price, uuid:  steak2!.uuid)
        //        potato = Modifier(name: "potato", isModifierFor: food, mainOrder: food, price: potato!.price, uuid:  potato!.uuid)
        //        cheese = Modifier(name: "cheese", isModifierFor: potato!, mainOrder: food, price: cheese!.price, uuid: cheese!.uuid)
        //        baked = Modifier(name: "baked", isModifierFor: cheese!, mainOrder: food, price: baked!.price, uuid:  baked!.uuid)
        //        burned = Modifier(name: "burned", isModifierFor: baked!, mainOrder: food, price: burned!.price, uuid:  burned!.uuid)
        //        potato4 = Modifier(name: "fries", isModifierFor: burned!, mainOrder: food, price: potato4!.price, uuid:  potato4!.uuid)
        //        potato3 = Modifier(name: "sauce", isModifierFor: steak2!, mainOrder: food, price: potato3!.price, uuid: potato3!.uuid)
        
        
        //        ModifierController.shared.addModifierToOrder(modifier: steak2!, isModifierFor: food, mainOrder: food, seat: selectedSeat)
        //        ModifierController.shared.addModifierToOrder(modifier: potato!, isModifierFor: food, mainOrder: food, seat: selectedSeat)
        //        ModifierController.shared.addModifierToOrder(modifier: cheese!, isModifierFor: potato!, mainOrder: food, seat: selectedSeat)
        //        ModifierController.shared.addModifierToOrder(modifier: baked!, isModifierFor: cheese!, mainOrder: food, seat: selectedSeat)
        //        ModifierController.shared.addModifierToOrder(modifier: burned!, isModifierFor: baked!, mainOrder: food, seat: selectedSeat)
        //        ModifierController.shared.addModifierToOrder(modifier: potato4!, isModifierFor: burned!, mainOrder: food, seat: selectedSeat)
        //        ModifierController.shared.addModifierToOrder(modifier: potato3!, isModifierFor: steak2!, mainOrder: food, seat: selectedSeat)
        
        
        
        
        let section = seats.firstIndex(of: selectedSeat)!
        let indexPath = IndexPath(row: selectedSeat.orders.count - 1, section: section)
        
        selectedOrder = food
        self.selectedSeat == nil ? (self.selectedSeat = selectedOrder!.seat!) : (self.selectedSeat = selectedSeat)
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
        #warning("selectedSeat is randomley being set to nil here")
    }
    
    @IBAction func mod1ButtonTapped(_ sender: Any) {
        selectedSeat == nil ? (selectedSeat = selectedOrder?.seat) : (selectedSeat = selectedSeat)
        guard selectedSeat != nil && potato != nil && selectedOrder != nil else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        potato = Modifier(name: "potato", isModifierFor: selectedOrder!, mainOrder: selectedOrder!, price: 0.39, uuid: potato!.uuid)
        
        
        
        
        ModifierController.shared.addModifierToOrder(modifier: potato!, isModifierFor: selectedOrder!, mainOrder: selectedOrder!, seat: selectedSeat!)
        
        ModifierController.shared.ordersToMove = []
        
        print("🧠Blah 1")
        reloadAndScroll()
    }
    
    
    
    
    @IBAction func button3Tapped(_ sender: Any) {
        guard  selectedOrder != nil && dict[selectedOrder!.uuid + potato!.uuid] != nil && selectedSeat != nil else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        cheese = Modifier(name: "cheese", isModifierFor: dict[selectedOrder!.uuid + potato!.uuid]!, mainOrder: selectedOrder!, price: 0.39, uuid: cheese!.uuid)
        
        ModifierController.shared.addModifierToOrder(modifier: cheese!, isModifierFor: dict[selectedOrder!.uuid + potato!.uuid]!, mainOrder: selectedOrder!, seat: selectedSeat!)
        
        ModifierController.shared.ordersToMove = []
        //        ModifierController.shared.ordersToMove.append(selectedOrder!)
        //        ModifierController.shared.ordersToMove.append(contentsOf: selectedOrder!.totalMods)
        
        print("🧠Blah 2")
        reloadAndScroll()
        
    }
    
    
    
    @IBAction func mod2ButtonTapped(_ sender: Any) {
        guard  dict[selectedOrder!.uuid + cheese!.uuid] != nil && selectedOrder != nil && selectedSeat != nil else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        baked = Modifier(name: "baked", isModifierFor: dict[selectedOrder!.uuid + cheese!.uuid]!, mainOrder: selectedOrder!, price: 0.39, uuid: baked!.uuid)
        
        ModifierController.shared.addModifierToOrder(modifier: baked!, isModifierFor: dict[selectedOrder!.uuid + cheese!.uuid]!, mainOrder: selectedOrder!, seat: selectedSeat!)
        
//        we need to set ordersToMove to nothing here or when something is moving it will leave some mods behind
        ModifierController.shared.ordersToMove = []
     
        print("🧠Blah 3")
        reloadAndScroll()
    }
    
    
    
    
    @IBAction func button4tapped(_ sender: Any) {
        selectedSeat == nil ? (selectedSeat = selectedOrder?.seat) : (selectedSeat = selectedSeat)
        guard selectedSeat != nil && potato3 != nil && selectedOrder != nil else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        potato3 = Modifier(name: "sauce", isModifierFor: selectedOrder!, mainOrder: selectedOrder!, price: potato3!.price, uuid: potato3!.uuid)
        
        
        
        ModifierController.shared.addModifierToOrder(modifier: potato3!, isModifierFor: selectedOrder!, mainOrder: selectedOrder!, seat: selectedSeat!)
        
        ModifierController.shared.ordersToMove = []
        
        print("🧠Blah 1")
        reloadAndScroll()
    }
    
    
    
    
    @IBAction func button5Tapped(_ sender: Any) {
        selectedSeat == nil ? (selectedSeat = selectedOrder?.seat) : (selectedSeat = selectedSeat)
        guard selectedSeat != nil && potato3 != nil && selectedOrder != nil else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        
        potato4 = Modifier(name: "fries", isModifierFor: dict[selectedOrder!.uuid + cheese!.uuid]!, mainOrder: selectedOrder!, price: potato4!.price, uuid:  potato4!.uuid)
        
        
        
        ModifierController.shared.addModifierToOrder(modifier: potato4!, isModifierFor: dict[selectedOrder!.uuid + cheese!.uuid]!, mainOrder: selectedOrder!, seat: selectedSeat!)
        
        ModifierController.shared.ordersToMove = []
        
        print("🧠Blah 1")
        reloadAndScroll()
        
        
        
    }
    
    
    @IBAction func button6Tapped(_ sender: Any) {
        selectedSeat == nil ? (selectedSeat = selectedOrder?.seat) : (selectedSeat = selectedSeat)
        guard selectedSeat != nil && potato3 != nil && selectedOrder != nil else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        
        
        burned = Modifier(name: "burned", isModifierFor: dict[selectedOrder!.uuid + potato4!.uuid]!, mainOrder: selectedOrder!, price: burned!.price, uuid:  burned!.uuid)
        
        
        ModifierController.shared.addModifierToOrder(modifier: burned!, isModifierFor: dict[selectedOrder!.uuid + potato4!.uuid]!, mainOrder: selectedOrder!, seat: selectedSeat!)
        
        ModifierController.shared.ordersToMove = []
        
        print("🧠Blah 1")
        reloadAndScroll()
        
        
        
        
        
        
    }
    
    
    @IBAction func removeSeat(_ sender: Any) {
        guard let selectedSeat = selectedSeat else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return}
        let index = seats.firstIndex(of: selectedSeat)!
        //        ModifierController.shared.ord
        ModifierController.shared.removeSeat(seat: selectedSeat)
        
        
        
        
        self.selectedSeat = nil
        
        
        if seats.count >= index - 1 {
            //            seats.compactMap({$0.seatNumber = seats.firstIndex(of: $0)! + 1})
            if index - 1 <= 0 {
                tableView.reloadData()
            } else {
                tableView.reloadData()
                tableView.scrollToRow(at: IndexPath(row: NSNotFound, section: index - 1), at: .bottom, animated: false)
            }
            
            
        } else {
            tableView.reloadData()
        }
    }
    
    
    
    @IBAction func removeOrder(_ sender: Any) {
        guard let selectedOrder = selectedOrder, let selectedSeat = selectedSeat else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        ModifierController.shared.removeOrderFromSeat(order: selectedOrder)
        ModifierController.shared.ordersToMove = []
        let section = seats.firstIndex(of: selectedSeat)!
        
        var indexPath = IndexPath()
        if selectedSeat.orders.count > 0 {
            indexPath = IndexPath(row: selectedSeat.orders.count - 1, section: section)
        } else {
            indexPath = IndexPath(row: NSNotFound, section: section)
        }
        
        
        //selectedOrder == nil ? (selectedOrder = food) : (selectedOrder = selectedOrder)
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
        self.selectedOrder = nil
        
    }
    
    
    
    
    @IBAction func removeMod(_ sender: Any) {
        guard selectedOrder != nil && selectedOrder!.totalMods.count != 0 else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return }
        ModifierController.shared.removeModFromOrder(modifierUUID: potato!.uuid, fromModifier: selectedOrder! )
        //        ModifierController.shared.removeMod(uuid: cheese!.uuid, fromModifier: dict[selectedOrder!.uuid + potato!.uuid]! as! Modifier)
        print("🧠Blah delete")
        reloadAndScroll()
    }
    
    
    
    
    func reloadAndScroll(){
        guard let selectedOrder = selectedOrder else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return }
        
        tableView.reloadData()
        
        
        let section = seats.firstIndex(of: selectedOrder.seat!)!
        let index = seats[section].orders.firstIndex(of: (selectedOrder))!
        
        let indexPath = IndexPath(row: index + (selectedOrder.totalMods.count), section: section)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
    }
    
    
    
    
}
//orderMoving
extension SeatsViewController {
    
    
    
    
    func createNewSeat(){
        //        seats.append(Seat(seatnumber: seats.count + 1))
        let newSeat = Seat(seatnumber: seats.count + 1)
        print("🤚\(newSeat.seatNumber)")
        SeatsController.shared.seats.append(newSeat)
        selectedSeat = newSeat
        
    }
    
    
    
    @objc func assignOrderTo(_ seat:UIButton){
        selectedSeat = seats[seat.tag]
        print("seat number \(seat.tag) tapped")
        //fixes bug. if a new seat is selected that the selected order does not belong to, then a mod is added to that order it will crash. vv this fixes that
        (selectedSeat?.orders.count)! > 0 ? selectedOrder = selectedOrder : (selectedOrder = nil)
        if ModifierController.shared.ordersToMove != [] {
            
            
            
            
            //loop through seats and look for items in the selected rows array
            
            /*
             here we loop through all the seat's orders and if the selectedRow's list contains those orders, they will be deleted from both the seat.orders they belong to and the selected rows array
             
             then they will be apended to the seat.orders that was selected
             */
            for seatObject in seats {
                
                
                guard seatObject.orders.count != 0,
                    let seatIndex = seats.firstIndex(of: seatObject) else {continue}
                
                
                for order in seatObject.orders {
                    
                    if ModifierController.shared.ordersToMove.contains(order){
                        
                        
                        order.seat = SeatsController.shared.seats[seat.tag]
                        
                        SeatsController.shared.seats[seatIndex].orders.removeAll(where: {$0.text == order.text})
                        ModifierController.shared.ordersToMove.removeAll(where: {$0.text == order.text})
                        
                        SeatsController.shared.seats[seat.tag].orders.append(order)
                        
                    }
                }
            }
            ModifierController.shared.ordersToMove = []
        }
        
        tableView.reloadData()
        
    }
    
}



extension SeatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if seats[indexPath.section].orders[indexPath.row].isMainOrder == false{
            return 20
        }
        
        return defaultCellHeight
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seats.count
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard seats[section].orders.count > 0 else { return 0}
        
        let orders = seats[section].orders
        return orders.count
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //this will add a button to our section headers for us to send orders to
        let addButton = UIButton()
        
        addButton.setTitle("Seat \(seats[section].seatNumber)", for: .normal)
        
        //if the section is selected, it will turn brown
        addButton.backgroundColor = seats[section] == selectedSeat ? .brown : .red
        
        //the tag number will be the same number as the section number
        addButton.tag = section
        addButton.showsTouchWhenHighlighted = true
        addButton.addTarget(self, action: #selector(assignOrderTo(_:)), for: .touchUpInside)
        
        return addButton
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        guard seats[indexPath.section].orders.count != 0 else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return UITableViewCell() }

        var orderCell = UITableViewCell() as? OrderTableViewCell
        var modifierCell = UITableViewCell() as? ModifierTableViewCell
        let currentOrder = seats[indexPath.section].orders[indexPath.row]
        var currentCell = UITableViewCell()
        
        switch currentOrder.isMainOrder {
            
        case true:
            
            orderCell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrderTableViewCell
            orderCell?.textLabel?.text = seats[indexPath.section].orders[indexPath.row].name
            orderCell?.textLabel?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            orderCell?.detailTextLabel?.text = "\(seats[indexPath.section].orders[indexPath.row].price)"
            orderCell?.detailTextLabel?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            orderCell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
            orderCell?.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 20.0)
            orderCell?.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            orderCell?.layer.borderWidth = 0
            
            currentCell = orderCell!
            
        default:
            modifierCell = tableView.dequeueReusableCell(withIdentifier: "modifierCell", for: indexPath) as? ModifierTableViewCell
            
            
            if seats[indexPath.section].orders[indexPath.row] == seats[indexPath.section].orders[indexPath.row] as? Modifier {
                let mod = seats[indexPath.section].orders[indexPath.row] as! Modifier
                
                modifierCell?.textLabel?.text = "    " + mod.name + " is Modifier for \(mod.isModifierFor.name) main is \(mod.mainOrder.name)"
                modifierCell?.detailTextLabel?.text = "\(seats[indexPath.section].orders[indexPath.row].price)"
                modifierCell?.detailTextLabel?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                modifierCell?.textLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
                modifierCell?.textLabel?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                modifierCell?.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
                modifierCell?.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                modifierCell?.layer.borderWidth = 0
                
                currentCell = modifierCell!
               
            }
        }
        
        
        if selectedSeat != nil {
            currentCell.layer.backgroundColor = currentOrder.seat == selectedSeat ? #colorLiteral(red: 0.7588697672, green: 0.9315800667, blue: 0.9670193791, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
//            if currentOrder.seat == selectedSeat! {
////                currentCell.layer.borderWidth = 1
////                currentCell.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
//                currentCell.layer.backgroundColor = #colorLiteral(red: 0.7588697672, green: 0.9315800667, blue: 0.9670193791, alpha: 1)
//            } else {
////                currentCell.layer.borderWidth = 0
//                currentCell.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            }
        }
        
        
        
        
        
        
        
        
        if selectedOrder != nil {
            
            orderCell?.layer.borderWidth = currentOrder == selectedOrder ? 3 : 0
            
            
//            if currentOrder == selectedOrder {
//                orderCell?.layer.borderWidth = 3
                orderCell?.layer.borderColor = #colorLiteral(red: 0, green: 0.9339144826, blue: 0, alpha: 1)
//            } else {
//                orderCell?.layer.borderWidth = 0
                //orderCell?.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            }
            if currentOrder == currentOrder as? Modifier{
                let currentMod = currentOrder as! Modifier
                
                
                modifierCell?.layer.borderWidth = currentMod.mainOrder == selectedOrder ? 3 : 0
                
                
//                if currentMod.mainOrder == selectedOrder {
//                    modifierCell?.layer.borderWidth = 3
                    modifierCell?.layer.borderColor = #colorLiteral(red: 0, green: 0.9339144826, blue: 0, alpha: 1)
//                } else {
//                    modifierCell?.layer.borderWidth = 0
//                    //                    modifierCell?.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//                }
            }
            
        }
        
        if ModifierController.shared.ordersToMove.contains(seats[indexPath.section].orders[indexPath.row]){
            modifierCell?.layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            orderCell?.layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
        
        
    
        
        if currentOrder.isMainOrder == true {
            return orderCell!
        } else {
            return modifierCell!
        }
        
        
    }
    
    
    
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //
    //        guard seats[indexPath.section].orders.count != 0 && seats[indexPath.section].orders[indexPath.row] != seats[indexPath.section].orders[indexPath.row] as? Modifier else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return }
    //        print("🧠\(seats[indexPath.section].orders[indexPath.row].name)")
    //
    //
    //
    //        let deSelectedOrder = seats[indexPath.section].orders[indexPath.row]
    //
    //
    //
    //
    //
    //        let orderIndex = ModifierController.shared.ordersToMove.firstIndex(of: deSelectedOrder)!
    //
    //
    //        ModifierController.shared.ordersToMove.remove(at: orderIndex)
    //        switch deSelectedOrder.seat {
    //        case _ where deSelectedOrder.seat == selectedSeat:
    //            tableView.cellForRow(at: indexPath)?.layer.backgroundColor = #colorLiteral(red: 0.7588697672, green: 0.9315800667, blue: 0.9670193791, alpha: 1)
    //
    //        case _ where ModifierController.shared.ordersToMove.contains(deSelectedOrder):
    //            tableView.cellForRow(at: indexPath)?.layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    //
    //        default:
    //            tableView.cellForRow(at: indexPath)?.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    //        }
    //        //asd
    ////        vv this removes the deselected orders from orderToMove
    //        for mod in deSelectedOrder.totalMods {
    ////        if ModifierController.shared.ordersToMove.contains(i) {
    //
    //
    //            let modIndex = seats[indexPath.section].orders.firstIndex(of: mod)!
    //
    //            let modIndexPath = IndexPath(row: modIndex, section: indexPath.section)
    //
    //            tableView.deselectRow(at: modIndexPath, animated: true)
    //
    //
    //            ModifierController.shared.ordersToMove.removeAll(where: {$0 == mod || $0 == deSelectedOrder})
    //
    //
    //
    //            switch mod.seat {
    //            case _ where mod.seat == selectedSeat:
    //                tableView.cellForRow(at: modIndexPath)?.layer.backgroundColor = #colorLiteral(red: 0.7588697672, green: 0.9315800667, blue: 0.9670193791, alpha: 1)
    //
    //            case _ where ModifierController.shared.ordersToMove.contains(mod):
    //                tableView.cellForRow(at: modIndexPath)?.layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    //
    //            default:
    //                tableView.cellForRow(at: modIndexPath)?.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    //            }
    //        }
    //    }
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //      seats[indexPath.section].orders[indexPath.row] != seats[indexPath.section].orders[indexPath.row] as? Modifier
        
        guard seats[indexPath.section].orders.count != 0 else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        print("🧠\(seats[indexPath.section].orders[indexPath.row].name)")
        
        var currentOrder = seats[indexPath.section].orders[indexPath.row]
        
        if ModifierController.shared.ordersToMove.contains(currentOrder) == false {
            
            
            
            print("👈\(currentOrder)")
            
            
            switch currentOrder.isMainOrder {
            case true:
                selectedOrder = seats[indexPath.section].orders[indexPath.row]
                selectedSeat = selectedOrder?.seat
                
                ModifierController.shared.ordersToMove.append(currentOrder)
                ModifierController.shared.ordersToMove.append(contentsOf: currentOrder.totalMods)
                
                let index = seats[indexPath.section].orders.firstIndex(of: currentOrder)
                tableView.cellForRow(at: IndexPath(row: index!, section: indexPath.section))?.layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                
                //we need to highlight the total mods or it wont highlight any nested mods
                let totalMods = seats[indexPath.section].orders[indexPath.row].totalMods
                if totalMods.count > 0 {
                    
                    for i in totalMods {
                        if totalMods.contains(i){
                            
                            
                            let index = seats[indexPath.section].orders.firstIndex(of: i)!
                            let cellIndexPath = IndexPath(row: index, section: indexPath.section)
                            
                            tableView.cellForRow(at: cellIndexPath)?.layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                        }
                    }
                }
            // if they select a mod (small cell) then vv this will behave as though they selected a main order
            default:
                
                
                //                for i in seats[indexPath.section].orders {
                //                    if seats[indexPath.section].orders[indexPath.row] == seats[indexPath.section].orders[indexPath.row] as? Modifier {
                
                let selectedMod = seats[indexPath.section].orders[indexPath.row] as! Modifier
                if seats[indexPath.section].orders.contains(selectedMod.mainOrder){
                    
                    //                        let mainIndex = seats[indexPath.section].orders.firstIndex(of: selectedMod.mainOrder)
                    
                    //                        if i == selectedMod.mainOrder {
                    
                    
                    currentOrder = selectedMod.mainOrder
                    selectedOrder = currentOrder
                    selectedSeat = currentOrder.seat
                    
                    //need to append the current order seperate from the total mods loop since the current order is not in its own loop
                    ModifierController.shared.ordersToMove.append(currentOrder)
                    ModifierController.shared.ordersToMove.append(contentsOf: currentOrder.totalMods)
                    
                    let index = seats[indexPath.section].orders.firstIndex(of: currentOrder)
                    tableView.cellForRow(at: IndexPath(row: index!, section: indexPath.section))?.layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                    
                    //we need to highlight the total mods or it wont highlight any nested mods
                    let totalMods = seats[indexPath.section].orders[indexPath.row].totalMods
                    if totalMods.count > 0 {
                        
                        for i in totalMods {
                            if totalMods.contains(i){
                                
                                
                                let index = seats[indexPath.section].orders.firstIndex(of: i)!
                                let cellIndexPath = IndexPath(row: index, section: indexPath.section)
                                
                                tableView.cellForRow(at: cellIndexPath)?.layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                            }
                        }
                    }
                    //                        }
                }
                
                //                    }
                //                }
            }
            
        //deselects orders and removes them from ordersToMove
        } else if ModifierController.shared.ordersToMove.contains(currentOrder) == true{
            
            switch currentOrder.isMainOrder {
            case true:
                let deSelectedOrder = seats[indexPath.section].orders[indexPath.row]
                let deSelectedOrderIndex = ModifierController.shared.ordersToMove.firstIndex(of: deSelectedOrder)!
                
                ModifierController.shared.ordersToMove.remove(at: deSelectedOrderIndex)
                
                
                //vv this removes the deselected modifiers from orderToMove
                for mod in deSelectedOrder.totalMods {
                    
                    
                    let modIndex = seats[indexPath.section].orders.firstIndex(of: mod)!
                    let modIndexPath = IndexPath(row: modIndex, section: indexPath.section)
                    
                    tableView.deselectRow(at: modIndexPath, animated: true)
                    
                    
                    ModifierController.shared.ordersToMove.removeAll(where: {$0 == mod || $0 == deSelectedOrder})
                }
            default:
                //                for i in seats[indexPath.section].orders {
                if seats[indexPath.section].orders[indexPath.row] == seats[indexPath.section].orders[indexPath.row] as? Modifier {
                    
                    let selectedMod = seats[indexPath.section].orders[indexPath.row] as! Modifier
                    let deSelectedOrder = selectedMod.mainOrder
                    let deSelectedOrderIndex = ModifierController.shared.ordersToMove.firstIndex(of: deSelectedOrder)!
                    
                    ModifierController.shared.ordersToMove.remove(at: deSelectedOrderIndex)
                    
                    for mod in deSelectedOrder.totalMods {
                        
                        
                        let modIndex = seats[indexPath.section].orders.firstIndex(of: mod)!
                        let modIndexPath = IndexPath(row: modIndex, section: indexPath.section)
                        
                        tableView.deselectRow(at: modIndexPath, animated: true)
                        
                        
                        ModifierController.shared.ordersToMove.removeAll(where: {$0 == mod || $0 == deSelectedOrder})
                    }
                }
            }
        }
        tableView.reloadData()
    }
}













//unused
//Mark: new order item Alert
extension SeatsViewController {
    @IBAction private func addNewOrderItemAlert(_ sender: Any) {
        addNewItemAlert()
    }
    
    func addNewItemAlert(){
        let alertController = UIAlertController(title: "add new item", message: nil, preferredStyle: .alert)
        
        var textField = UITextField()
        alertController.addTextField { (textField1) in
            textField1.placeholder = "new item"
            textField = textField1
        }
        var textFieldTwo = UITextField()
        alertController.addTextField { (textField2) in
            textField2.placeholder = "ONLY ENTER INT OR DOUBLE OR IT WILL CRASH"
            textFieldTwo = textField2
        }
        
        let okButton = UIAlertAction(title: "Ok", style: .default) { (okButtonHit) in
            
            var price = 0.00
            if textFieldTwo.text != "" {
                price  = Double(textFieldTwo.text!)!
                
            }
            
            if textField.text != "" {
                
                
                
                //if you dont do this, nothing will be appended to  seats.last?.orders because orders is empty
                //                if self.seats.last?.orders == nil {
                //                    self.seats.last?.orders = [OrderItem(name: textField.text!, isMainOrder: true, price: price)]
                //                }
                //                else {
                
                SeatsController.shared.seats.last?.orders.append(OrderItem(name: textField.text!, isMainOrder: true, price: price, seat: SeatsController.shared.seats.last))
                //                }
                
                self.tableView.reloadData()
            }
        }
        alertController.addAction(okButton)
        alertController.show()
    }
}



extension SeatsViewController {
    func setSeats(){
        steak2 = Modifier(name: "steak", isModifierFor: steak, mainOrder: steak, price: 10.00)
        potato = Modifier(name: "potato", isModifierFor: steak, mainOrder: steak, price: 5.00)
        cheese = Modifier(name: "cheese", isModifierFor: potato!, mainOrder: steak, price: 0.39)
        baked = Modifier(name: "baked", isModifierFor: cheese!, mainOrder: steak, price: 5.01)
        burned = Modifier(name: "burned", isModifierFor: baked!, mainOrder: steak, price: 5.01)
        potato2 = Modifier(name: "super", isModifierFor: potato!, mainOrder: steak, price: 5.00)
        potato3 = Modifier(name: "sauce", isModifierFor: steak, mainOrder: steak, price: 5.00)
        potato4 = Modifier(name: "fries", isModifierFor: steak, mainOrder: steak, price: 5.00)
        potato5 = Modifier(name: "cheese fries", isModifierFor: steak, mainOrder: steak, price: 5.00)
    }
}

