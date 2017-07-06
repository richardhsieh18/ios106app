//
//  MyTableViewController.swift
//  myOwnTableView
//
//  Created by chang on 2017/7/6.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    var arrList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrList.append("爬山")
        arrList.append("滑雪")
        arrList.append("潛水")
        
        arrList.append("看書")
        arrList.append("睡覺")
        arrList.append("下棋")
        
        //進入編輯模式，才可以移動儲存格，但不能滑動儲存
        //self.tableView.isEditing = true
        
    }
    // MARK: tableView data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arrList[indexPath.row]
        //Text置中
        cell.textLabel?.textAlignment = .center
        //視Cell style才會顯示
        //cell.detailTextLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    //MARK: tableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(arrList[indexPath.row])被選定")
        //---> 爬山被選定
        
        //print("\(tableView.indexPathForSelectedRow)被選定")
        // ---> Optional([0, 1])被選定
    }
    
    //允許移動儲存格
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //實際移動儲存格
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(arrList) //移動前
        let tmp = arrList[sourceIndexPath.row]
        arrList.remove(at: sourceIndexPath.row)
        arrList.insert(tmp, at: destinationIndexPath.row)
        print(arrList) //移動後
    }
    //設定特定儲存格不能刪除
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        
//        return .none
//    }
    //刪除tableView的cell元件
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //1.移除陣列中的元素
            arrList.remove(at: indexPath.row)
            //2.刪除資料庫中的資料
            
            //3.移除tableview的row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }else if editingStyle == .insert {
            
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "拉拉刪"
    }
    
    

}
