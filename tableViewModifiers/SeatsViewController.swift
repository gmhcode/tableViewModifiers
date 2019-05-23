//
//  SeatsViewController.swift
//  tableViewModifiers
//
//  Created by Greg Hughes on 5/22/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class SeatsViewController: UIViewController {

    
    var steak = OrderItem(name: "steak", isMainOrder: true, price: 10.00)
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
    lazy var defaultCellHeight = view.bounds.width * 0.10
    var orders : [OrderItem] {
        get{
            return OrderItemController.shared.orders
        }
    }
    
    
    var dict : [String : OrderItem] {
        get{
            return ModifierController.shared.modDictionary
        }
    }
    
    
    
    var selectedSeat : Seat? 
    var selectedCell = UITableViewCell()
    var selectedOrder : OrderItem?
    /*
     selectedRows gets populated whenever an item is select, gets depopulated by delesecting items or running the assignOrderTo() function
     */
    var ordersToMove : [OrderItem] = []
    
    /*
     seats have an array of orders inside of them.
     the number and name of sections is determined by the amount of seats in this list
     the number of rows per section and name of the orders is determined by the orderlist in each seat
     */
    
//    var seats : [Seat] = []
//        // Seat(seatnumber: 1), Seat(seatnumber: 2)
//        {
//        didSet{
//            tableView.reloadData()
//        }
//    }
    
    
    
    
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
        setSeats()
        
    }
    
    func addNewItem(name: String, price: Double){
        
        if seats == [] {
            createNewSeat()
        }
        
//        if self.seats.last?.orders == nil {
//            self.seats.last?.orders = [OrderItem(name: name, isMainOrder: true, price: price)]
//        }
//        else {
        SeatsController.shared.seats.last?.orders.append(OrderItem(name: name, isMainOrder: true, price: price))
//        }
        tableView.reloadData()
    }
    
    
    
    @IBAction func addChicken(_ sender: Any) {
        addNewItem(name: "cat", price: 10.00)
    }
    
    @IBAction func addDrink(_ sender: Any) {
        addNewItem(name: "Drink", price: 1.00)
    }
    
    
    @IBAction func newSeatButtonTapped(_ sender: Any) {
        createNewSeat()
        tableView.reloadData()
    }
    
    
    
    @IBAction func newOrderButtonTapped(_ sender: Any) {
        guard let selectedSeat = selectedSeat else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        
        let food = OrderItem(name: "food \(orders.count)", isMainOrder: true, price: 10.00)
        OrderItemController.shared.orders.append(food)
        selectedSeat.orders.append(food)
        
        steak2 = Modifier(name: "steak", isModifierFor: food, mainOrder: food, price: steak2!.price, uuid:  steak2!.uuid)
        potato = Modifier(name: "potato", isModifierFor: food, mainOrder: food, price: potato!.price, uuid:  potato!.uuid)
        cheese = Modifier(name: "cheese", isModifierFor: potato!, mainOrder: food, price: cheese!.price, uuid: cheese!.uuid)
        baked = Modifier(name: "baked", isModifierFor: cheese!, mainOrder: food, price: baked!.price, uuid:  baked!.uuid)
        burned = Modifier(name: "burned", isModifierFor: baked!, mainOrder: food, price: burned!.price, uuid:  burned!.uuid)
        potato4 = Modifier(name: "fries", isModifierFor: burned!, mainOrder: food, price: potato4!.price, uuid:  potato4!.uuid)
        potato3 = Modifier(name: "sauce", isModifierFor: steak2!, mainOrder: food, price: potato3!.price, uuid: potato3!.uuid)
        
        
        ModifierController.shared.addModifierToOrder(modifier: steak2!, isModifierFor: food, mainOrder: food, seat: selectedSeat)
        ModifierController.shared.addModifierToOrder(modifier: potato!, isModifierFor: food, mainOrder: food, seat: selectedSeat)
        ModifierController.shared.addModifierToOrder(modifier: cheese!, isModifierFor: potato!, mainOrder: food, seat: selectedSeat)
        ModifierController.shared.addModifierToOrder(modifier: baked!, isModifierFor: cheese!, mainOrder: food, seat: selectedSeat)
        ModifierController.shared.addModifierToOrder(modifier: burned!, isModifierFor: baked!, mainOrder: food, seat: selectedSeat)
        ModifierController.shared.addModifierToOrder(modifier: potato4!, isModifierFor: burned!, mainOrder: food, seat: selectedSeat)
        ModifierController.shared.addModifierToOrder(modifier: potato3!, isModifierFor: steak2!, mainOrder: food, seat: selectedSeat)
        
        
        
//        let indexPath = IndexPath(row: orders.count - 1, section: 0)
//        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        
        tableView.reloadData()
//        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    @IBAction func mod1ButtonTapped(_ sender: Any) {
        
        cheese = Modifier(name: "cheese", isModifierFor: dict[selectedOrder!.name + potato!.uuid]!, mainOrder: selectedOrder!, price: 0.39, uuid: cheese!.uuid)
        
        ModifierController.shared.addModifierToOrder(modifier: cheese!, isModifierFor: dict[selectedOrder!.name + potato!.uuid]!, mainOrder: selectedOrder!, seat: selectedSeat!)
        
        tableView.reloadData()
    }
    
    
    @IBAction func mod2ButtonTapped(_ sender: Any) {
        
        baked = Modifier(name: "baked", isModifierFor: dict[selectedOrder!.name + potato!.uuid]!, mainOrder: selectedOrder!, price: 0.39, uuid: baked!.uuid)
        
        ModifierController.shared.addModifierToOrder(modifier: baked!, isModifierFor: dict[selectedOrder!.name + potato!.uuid]!, mainOrder: selectedOrder!, seat: selectedSeat!)
        
        tableView.reloadData()
    }
    
    @IBAction func mod3ButtonTapped(_ sender: Any)
    {
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//orderMoving
extension SeatsViewController {
 
    
    
    
    func createNewSeat(){
//        seats.append(Seat(seatnumber: seats.count + 1))
        SeatsController.shared.seats.append(Seat(seatnumber: seats.count + 1))
//        tableView.reloadData()
    }
    
    
    
    @objc func assignOrderTo(_ seat:UIButton){
        selectedSeat = seats[seat.tag]
        guard ordersToMove != [] else {return}
        /*
         //        guard let allRows = tableView.indexPathsForSelectedRows else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
         //        for i in allRows {
         //
         //            print("Row: \(i.row)")
         //            print("Row Count: \(allRows.count)")
         //            print("section orders: \(seats[i.section].orders)")
         //            guard let item = seats[i.section].orders?[i.row], seats.count - 1 >= seat.tag else {continue}
         //
         //
         //
         //
         //
         //            if seats[seat.tag].orders == nil {
         //                seats[seat.tag].orders = [item]
         //            }else{
         //                seats[seat.tag].orders?.append(item)
         //            }
         //        }
         if the first item that is to be deleted comes after the previously selected item in the seats.orders array it belongs to, MAKE IT the last item in the array to be        deleted
         */
        
        //loop through seats and look for items in the selected rows array
        
        /*
         here we loop through all the seat's orders and if the selectedRow's list contains those orders, they will be deleted from both the seat.orders they belong to and the selected rows array
         
         then they will be apended to the seat.orders that was selected
         */
        for seatObject in seats {
            
            
            guard seatObject.orders.count != 0,
                let seatIndex = seats.firstIndex(of: seatObject) else {continue}
            
            
            for order in seatObject.orders {
                
                if ordersToMove.contains(order){
                    
                    SeatsController.shared.seats[seatIndex].orders.removeAll(where: {$0.text == order.text})
                    ordersToMove.removeAll(where: {$0.text == order.text})
                    
//                    if seats[seat.tag].orders == nil {
//                        seats[seat.tag].orders = [order]
//                    }else{
                    SeatsController.shared.seats[seat.tag].orders.append(order)
//                    }
                }
            }
        }
        
        
        /*
         //                for i in allRows {
         //
         //                    guard let item = seats[i.section].orders?[i.row] else {return}
         //                    print("Row: \(i.row)")
         //                    print("Row Count: \(allRows.count)")
         //                    print("section orders: \(seats[i.section].orders)")
         //                    seats[i.section].orders?.removeAll(where: {$0.uuid == item.uuid})
         //
         //
         //
         //                }
         
         //        for i in selectedRows {
         //                    if orderList.contains(where: {$0.uuid == i.uuid}){
         //                        print("✴️yes")
         //                        orderList.removeAll(where: {$0.uuid == i.uuid})
         //                    }
         //                }
         */
        
        ordersToMove = []
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
        
        guard seats[section].orders.count != 0 else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return 0
        }
        let orders = seats[section].orders
        return orders.count
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let addButton = UIButton()
        addButton.setTitle("Seat \(seats[section].seatNumber)", for: .normal)
        addButton.backgroundColor = .red
        addButton.tag = section
        
        addButton.addTarget(self, action: #selector(assignOrderTo(_:)), for: .touchUpInside)
        
        return addButton
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        let currentOrder = seats[indexPath.section].orders[indexPath.row]
        guard seats[indexPath.section].orders.count != 0 else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return cell }
        
        switch currentOrder.isMainOrder {
            
        case true:
            cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
            cell.textLabel?.text = seats[indexPath.section].orders[indexPath.row].name
            cell.detailTextLabel?.text = "\(seats[indexPath.section].orders[indexPath.row].price)"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
            cell.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 20.0)
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "modifierCell", for: indexPath) as! ModifierTableViewCell
            
            
            if seats[indexPath.section].orders[indexPath.row] == seats[indexPath.section].orders[indexPath.row] as? Modifier {
                let mod = seats[indexPath.section].orders[indexPath.row] as! Modifier
                
                cell.textLabel?.text = "    " + mod.name + " is Modifier for \(mod.isModifierFor.name) main is \(mod.mainOrder.name)"
                cell.detailTextLabel?.text = "\(seats[indexPath.section].orders[indexPath.row].price)"
                cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
                cell.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
            }
        }

        
//        cell.textLabel?.text = seats[indexPath.section].orders[indexPath.row].name
//
//        cell.detailTextLabel?.text = "\(String(describing: seats[indexPath.section].orders[indexPath.row].price))"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard seats[indexPath.section].orders.count != 0 else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return }
        
        let orderItem = seats[indexPath.section].orders[indexPath.row]
        
//        vv this removes the deselected orders from orderToMove
        if ordersToMove.contains(orderItem) {
            ordersToMove.removeAll(where: {$0.uuid == orderItem.uuid})
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView.cellForRow(at: indexPath) != nil {
//            deSelectAllButSelectedCells(indexPath: indexPath)
//        }
        guard seats[indexPath.section].orders.count != 0 else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        let currentOrder = seats[indexPath.section].orders[indexPath.row]

        if ordersToMove.contains(currentOrder) == false {
//            ordersToMove.append(currentOrder)
//            ordersToMove.append(contentsOf: currentOrder.totalMods)


        }
        
        switch currentOrder.isMainOrder {
        case true:
            ordersToMove.append(currentOrder)
            ordersToMove.append(contentsOf: currentOrder.totalMods)
            let totalMods = seats[indexPath.section].orders[indexPath.row].totalMods
            
//            print("🌹\(totalMods.count)")
            if totalMods.count > 0 {
                
                for i in totalMods {
                    if totalMods.contains(i){
                        
                        let orderIndex = orders.firstIndex(of: currentOrder)
                        
                        let index = seats[indexPath.section].orders.firstIndex(of: i)!
                        
                        
                        print("🌹\(orderIndex)")
                        print("🅰️\(index)")
                        
                        tableView.selectRow(at: IndexPath(row: index, section: indexPath.section), animated: false, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
                    }
                }
            }
        default:
            
            print("🅰️\(orders[indexPath.row].name)")
            print("🌹\(orders[indexPath.row].totalMods.count)")
            tableView.deselectRow(at: indexPath, animated: false)
            
        }
        
        selectedOrder = seats[indexPath.section].orders[indexPath.row]
        
        
        
        
        //printing for tests

//        for i in ordersToMove {
//            print("🅿️\(i.name)")
//        }
//        print("🈸\(ordersToMove)")
    }
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if tableView.cellForRow(at: indexPath) != nil {
//            deSelectAllButSelectedCells(indexPath: indexPath)
//        }
//
//        let currentOrder = seats[indexPath.section].orders[indexPath.row]
//
//        switch currentOrder.isMainOrder {
//        case true:
//            let totalMods = seats[indexPath.section].orders[indexPath.row].totalMods
//
//            print("🌹\(totalMods.count)")
//            if totalMods.count > 0 {
//
//                for i in totalMods {
//                    if totalMods.contains(i){
//                        let orderIndex = orders.firstIndex(of: seats[indexPath.section].orders[indexPath.row])
//                        let index = totalMods.firstIndex(of: i)!
//
//                        //                    orderIndex! +
//                        tableView.selectRow(at: IndexPath(row: orderIndex! + index + 1, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
//                    }
//                }
//            }
//        default:
//            print("🌹\(orders[indexPath.row].uuid)")
//            print("🅰️\(orders[indexPath.row].name)")
//            print("🌹\(orders[indexPath.row].totalMods.count)")
//            tableView.deselectRow(at: indexPath, animated: false)
//
//        }
//
//        selectedOrder = orders[indexPath.row]
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func deSelectAllButSelectedCells(indexPath: IndexPath){
        if selectedCell != tableView.cellForRow(at: indexPath) {
            self.tableView?.indexPathsForSelectedRows?.forEach(
                {
                    if tableView.cellForRow(at: $0) != tableView.cellForRow(at: indexPath){
                        self.tableView.deselectRow(at: $0, animated: true)
                    }})
        }
        selectedCell = tableView.cellForRow(at: indexPath)!
    }
    
    
    
}

//var cell = UITableViewCell()
//
//let currentOrder = orders[indexPath.row]
//
//switch currentOrder.isMainOrder {
//case true:
//    cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
//    cell.textLabel?.text = orders[indexPath.row].name
//    cell.detailTextLabel?.text = "\(orders[indexPath.row].price)"
//    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
//    cell.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 20.0)
//
//default:
//    cell = tableView.dequeueReusableCell(withIdentifier: "modifierCell", for: indexPath) as! ModifierTableViewCell
//
//
//    if orders[indexPath.row] == orders[indexPath.row] as? Modifier {
//        let mod = orders[indexPath.row] as! Modifier
//
//        cell.textLabel?.text = "    " + mod.name + " is Modifier for \(mod.isModifierFor.name)"
//        cell.detailTextLabel?.text = "\(orders[indexPath.row].price)"
//        cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
//        cell.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
//    }
//}
//return cell












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
                
                    SeatsController.shared.seats.last?.orders.append(OrderItem(name: textField.text!, isMainOrder: true, price: price))
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

