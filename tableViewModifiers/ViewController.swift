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
        } set {
            OrderItemController.shared.orders.append(contentsOf: newValue)
        }
    }
    
    var steak = OrderItem(name: "steak", isMainOrder: true)
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
        steak2 = Modifier(name: "steak", isModifierFor: steak, mainOrder: steak)
        potato = Modifier(name: "potato", isModifierFor: steak, mainOrder: steak)
        cheese = Modifier(name: "cheese", isModifierFor: potato!, mainOrder: steak)
        baked = Modifier(name: "baked", isModifierFor: cheese!, mainOrder: steak)
        burned = Modifier(name: "burned", isModifierFor: baked!, mainOrder: steak)
        potato2 = Modifier(name: "super", isModifierFor: potato!, mainOrder: steak)
        potato3 = Modifier(name: "sauce", isModifierFor: steak, mainOrder: steak)
        potato4 = Modifier(name: "fries", isModifierFor: steak, mainOrder: steak)
        potato5 = Modifier(name: "cheese fries", isModifierFor: steak, mainOrder: steak)
        
        
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
    }

    
    
    
    
    
    @IBAction func mainOrderButtonTapped(_ sender: Any)
    {
        
        let food = OrderItem(name: "food \(orders.count)", isMainOrder: true)
        OrderItemController.shared.orders.append(food)
        
        steak2 = Modifier(name: "steak", isModifierFor: food, mainOrder: food, uuid:  steak2!.uuid)
        potato = Modifier(name: "potato", isModifierFor: food, mainOrder: food, uuid:  potato!.uuid)
        cheese = Modifier(name: "cheese", isModifierFor: potato!, mainOrder: food, uuid: cheese!.uuid)
        baked = Modifier(name: "baked", isModifierFor: cheese!, mainOrder: food, uuid:  baked!.uuid)
        burned = Modifier(name: "burned", isModifierFor: baked!, mainOrder: food, uuid:  burned!.uuid)
        potato4 = Modifier(name: "fries", isModifierFor: burned!, mainOrder: food, uuid:  potato4!.uuid)
//        potato3 = Modifier(name: "sauce", isModifierFor: potato4!, mainOrder: food)
        
        
        
        ModifierController.shared.addModifierToOrder(modifier: steak2!, isModifierFor: food, mainOrder: food)
        ModifierController.shared.addModifierToOrder(modifier: potato!, isModifierFor: food, mainOrder: food)
        ModifierController.shared.addModifierToOrder(modifier: cheese!, isModifierFor: potato!, mainOrder: food)
        ModifierController.shared.addModifierToOrder(modifier: baked!, isModifierFor: cheese!, mainOrder: food)
        ModifierController.shared.addModifierToOrder(modifier: burned!, isModifierFor: baked!, mainOrder: food)
        ModifierController.shared.addModifierToOrder(modifier: potato4!, isModifierFor: burned!, mainOrder: food)
//        ModifierController.shared.addModifierToOrder(modifier: potato3!, isModifierFor: potato4!, mainOrder: food)
        
        let indexPath = IndexPath(row: orders.count - 1, section: 0)
//        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    
    
    @IBAction func modForPotatoTapped(_ sender: Any) {
        guard let selectedOrder = selectedOrder else {print("🔥❇️>>>\(#file) \(#line): guard ket failed<<<"); return  }
//        print("🎢\(cheese!.name) \(selectedOrder.uuid)  +++    + \(cheese!.uuid)")
        print("🎢\(ModifierController.shared.modDictionary.values.count)")
//        ModifierController.shared.modDictionary[selectedOrder.name + potato4!.uuid]
        potato2 = Modifier(name: "super", isModifierFor: ModifierController.shared.modDictionary[selectedOrder.name + potato4!.uuid]!, mainOrder: selectedOrder)
        ModifierController.shared.addModifierToOrder(modifier: potato2!, isModifierFor: ModifierController.shared.modDictionary[selectedOrder.name + potato4!.uuid]!, mainOrder: selectedOrder)
        tableView.reloadData()
        
        let index = orders.firstIndex(of: selectedOrder)!
        let indexPath = IndexPath(row: index, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        
        
        
    }
    
    @IBAction func modForPotato2Tapped(_ sender: Any) {
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
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "modifierCell", for: indexPath) as! ModifierTableViewCell
            
            
            if orders[indexPath.row] == orders[indexPath.row] as? Modifier {
                let mod = orders[indexPath.row] as! Modifier
                
                cell.textLabel?.text = "    " + mod.name + " is Modifier for \(mod.isModifierFor.name)"
                cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
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
        
        
        if totalMods.count > 0 {

            for i in totalMods {
                if totalMods.contains(i){
                    let orderIndex = orders.firstIndex(of: orders[indexPath.row])
                    let index = totalMods.firstIndex(of: i)!

                    
                    tableView.selectRow(at: IndexPath(row: orderIndex! + index + 1, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
                }
            }
        }
        
        
            
        default:
            
            
             print("🌹\(orders[indexPath.row].uuid)")
             print("🅰️\(orders[indexPath.row].name)")
             print("🌹\(orders[indexPath.row].totalMods.count)")
            tableView.deselectRow(at: indexPath, animated: false)
//            if orders.contains(orders[indexPath.row]){
//                let index = orders.firstIndex(of: orders[indexPath.row])!
//
//                tableView.selectRow(at: IndexPath(row: index + 1, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
//            }
            
            
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



