//
//  ViewController.swift
//  tableViewModifiers
//
//  Created by Greg Hughes on 5/21/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var selectedOrder : OrderItem?
    lazy var defaultCellHeight = view.bounds.width * 0.10
    var cellSizes : CGFloat?
    
    var selectedCell = UITableViewCell()
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
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
    var seat = Seat(seatnumber: 0, isCourse: false, name: "0")
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
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        steak2 = Modifier(name: "steak", isModifierFor: steak, mainOrder: steak, price: 10.00)
        potato = Modifier(name: "potato", isModifierFor: steak, mainOrder: steak, price: 5.00)
        cheese = Modifier(name: "cheese", isModifierFor: potato!, mainOrder: steak, price: 0.39)
        baked = Modifier(name: "baked", isModifierFor: cheese!, mainOrder: steak, price: 5.01)
        burned = Modifier(name: "burned", isModifierFor: baked!, mainOrder: steak, price: 5.01)
        potato2 = Modifier(name: "super", isModifierFor: potato!, mainOrder: steak, price: 5.00)
        potato3 = Modifier(name: "sauce", isModifierFor: steak, mainOrder: steak, price: 5.00)
        potato4 = Modifier(name: "fries", isModifierFor: steak, mainOrder: steak, price: 5.00)
        potato5 = Modifier(name: "cheese fries", isModifierFor: steak, mainOrder: steak, price: 5.00)
        
        
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
    }

    
    
    
    
    
    @IBAction func mainOrderButtonTapped(_ sender: Any)
    {
        var seat = Seat(seatnumber: 0, isCourse: false, name: "0")
        let food = OrderItem(name: "food \(orders.count)", isMainOrder: true, price: 10.00, seat: seat)
        OrderItemController.shared.orders.append(food)
        
        steak2 = Modifier(name: "steak", isModifierFor: food, mainOrder: food, price: steak2!.price, uuid:  steak2!.uuid)
        potato = Modifier(name: "potato", isModifierFor: food, mainOrder: food, price: potato!.price, uuid:  potato!.uuid)
        cheese = Modifier(name: "cheese", isModifierFor: potato!, mainOrder: food, price: cheese!.price, uuid: cheese!.uuid)
        baked = Modifier(name: "baked", isModifierFor: cheese!, mainOrder: food, price: baked!.price, uuid:  baked!.uuid)
        burned = Modifier(name: "burned", isModifierFor: baked!, mainOrder: food, price: burned!.price, uuid:  burned!.uuid)
        potato4 = Modifier(name: "fries", isModifierFor: burned!, mainOrder: food, price: potato4!.price, uuid:  potato4!.uuid)
//        potato3 = Modifier(name: "sauce", isModifierFor: potato4!, mainOrder: food)
        
        
        
        ModifierController.shared.addModifierToOrder(modifier: steak2!, isModifierFor: food, mainOrder: food, seat: seat)
        ModifierController.shared.addModifierToOrder(modifier: potato!, isModifierFor: food, mainOrder: food, seat: seat)
        ModifierController.shared.addModifierToOrder(modifier: cheese!, isModifierFor: potato!, mainOrder: food, seat: seat)
        ModifierController.shared.addModifierToOrder(modifier: baked!, isModifierFor: cheese!, mainOrder: food, seat: seat)
        ModifierController.shared.addModifierToOrder(modifier: burned!, isModifierFor: baked!, mainOrder: food, seat: seat)
        ModifierController.shared.addModifierToOrder(modifier: potato4!, isModifierFor: burned!, mainOrder: food, seat: seat)
        ModifierController.shared.addModifierToOrder(modifier: potato3!, isModifierFor: potato4!, mainOrder: food, seat: seat)
        
        
        
        let indexPath = IndexPath(row: orders.count - 1, section: 0)
//        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    @IBAction func modForMain(_ sender: Any) {
        potato = Modifier(name: "potato", isModifierFor: selectedOrder!, mainOrder: selectedOrder!, price: potato!.price, uuid:  potato!.uuid)
        ModifierController.shared.addModifierToOrder(modifier: potato!, isModifierFor: selectedOrder!, mainOrder: selectedOrder!, seat: seat)
        
        //
        reloadAndScroll2()
    }
    @IBAction func mod2ForMain(_ sender: Any) {
        steak2 = Modifier(name: "steak", isModifierFor: selectedOrder!, mainOrder: selectedOrder!, price: steak2!.price, uuid:  steak2!.uuid)
        ModifierController.shared.addModifierToOrder(modifier: steak2!, isModifierFor: selectedOrder!, mainOrder: selectedOrder!, seat: seat)
        
        //
        reloadAndScroll2()
    }
    
    
    
    
    
    @IBAction func modForPotatoTapped(_ sender: Any) {
        guard let selectedOrder = selectedOrder else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        print("🎢\(ModifierController.shared.modDictionary.values.count)")
        
        potato2 = Modifier(name: "super", isModifierFor: dict[selectedOrder.name + potato!.uuid]!, mainOrder: selectedOrder, price: 3.00, uuid: potato2!.uuid)
        
        ModifierController.shared.addModifierToOrder(modifier: potato2!, isModifierFor: dict[selectedOrder.name + potato!.uuid]!, mainOrder: selectedOrder, seat: seat)
        
        //
       reloadAndScroll2()
        
        
        
    }
    
    @IBAction func modForPotato2Tapped(_ sender: Any) {
         guard let selectedOrder = selectedOrder, let potato2 =  dict[selectedOrder.name + potato2!.uuid] else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        
        
        
        potato3 = Modifier(name: "sauce", isModifierFor: potato2, mainOrder: selectedOrder, price: 2.00, uuid: potato3!.uuid )
        ModifierController.shared.addModifierToOrder(modifier: potato3!, isModifierFor: potato2, mainOrder: selectedOrder, seat: seat)
        //
        reloadAndScroll2()
    }
    
    @IBAction func modifierForCheeseButtonTapped(_ sender: Any) {
        guard let selectedOrder = selectedOrder else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
        potato4 = Modifier(name: "nacho cheese", isModifierFor: dict[selectedOrder.name + potato3!.uuid]!, mainOrder: selectedOrder, price: 2.00)
        ModifierController.shared.addModifierToOrder(modifier: potato4!, isModifierFor: dict[selectedOrder.name + potato3!.uuid]!, mainOrder: selectedOrder, seat: seat)
        
        //
        reloadAndScroll2()
    }
    
    
    
    
    
    func reloadAndScroll2(){
        guard selectedOrder != nil && selectedOrder!.totalMods.count != 0 else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return }
        tableView.reloadData()
        let index = orders.firstIndex(of: (selectedOrder!))!
        let indexPath = IndexPath(row: index + ((selectedOrder!.totalMods.count) - 1), section: 0)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
    }
    
    
    
    
    @IBAction func removeModForMain(_ sender: Any) {
        ModifierController.shared.removeModFromOrder(modifierUUID: potato3!.uuid, fromModifier: dict[selectedOrder!.name + potato2!.uuid]!)
//        ModifierController.shared.removeMod(uuid: potato3!.uuid, fromModifier: dict[selectedOrder!.name + potato2!.uuid]! as! Modifier)
        reloadAndScroll2()
    }
    
    
    
    
    
    
    
    
    

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return orders.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell()

        let currentOrder = orders[indexPath.row]
        
        switch currentOrder.isMainOrder {
        case true:
            cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
            cell.textLabel?.text = orders[indexPath.row].name
            cell.detailTextLabel?.text = "\(orders[indexPath.row].price)"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
            cell.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 20.0)
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "modifierCell", for: indexPath) as! ModifierTableViewCell
            
            
            if orders[indexPath.row] == orders[indexPath.row] as? Modifier {
                let mod = orders[indexPath.row] as! Modifier
                
                cell.textLabel?.text = "    " + mod.name + " is Modifier for \(mod.isModifierFor.name)"
                cell.detailTextLabel?.text = "\(orders[indexPath.row].price)"
                cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
                cell.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
            }
        }
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
//        let cell = UITableViewCell()
        if orders[indexPath.row].isMainOrder == false{
            return 20
        }
        
        return defaultCellHeight
    }
    
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        if self.tableView?.indexPathsForSelectedRows != nil {
//
//            self.tableView?.indexPathsForSelectedRows?.forEach({self.tableView.deselectRow(at: $0, animated: true)})
//        }
//        return indexPath
//    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath) != nil {
            deSelectAllButSelectedCells(indexPath: indexPath)
        }
        
        let currentOrder = orders[indexPath.row]
        
        switch currentOrder.isMainOrder {
        case true:
        let totalMods = orders[indexPath.row].totalMods
        
        print("🌹\(totalMods.count)")
        if totalMods.count > 0 {

            for i in totalMods {
                if totalMods.contains(i){
                    let orderIndex = orders.firstIndex(of: orders[indexPath.row])
                    let index = totalMods.firstIndex(of: i)!

//                    orderIndex! +
                    tableView.selectRow(at: IndexPath(row: orderIndex! + index + 1, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
                }
            }
        }
        default:
            print("🌹\(orders[indexPath.row].uuid)")
             print("🅰️\(orders[indexPath.row].name)")
             print("🌹\(orders[indexPath.row].totalMods.count)")
            tableView.deselectRow(at: indexPath, animated: false)

        }
        
        
        
        
        
        selectedOrder = orders[indexPath.row]
    }
    
    
    
    
    
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



