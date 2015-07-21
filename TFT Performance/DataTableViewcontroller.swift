//
//  DataTableViewcontroller.swift
//  TFT Performance
//
//  Created by dyx on 15/6/17.
//  Copyright (c) 2015年 dyx. All rights reserved.
//

import UIKit

var data = [Result]()
var filterData = [Result]()

class DataTableViewcontroller: UITableViewController, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate {
    
    @IBOutlet weak var tableView1: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.append(Result(Vth: 5, monilities: 4.5, onOffRatio: 1000, SS: 3.4, daypiker: "示例"))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editData" {
            var vc = segue.destinationViewController as! AddViewController
            var indexPath = tableView.indexPathForSelectedRow()
            if let index = indexPath {
                vc.result = data[index.row]
            }
        }
    }
    
    //searchDisplayController?.searchResultsTableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //定义可重用的cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("DataCell") as! UITableViewCell
        var result: Result
        //用tag绑定每个控件

        result = data[indexPath.row] as Result
        
        var mobility = cell.viewWithTag(1) as! UILabel
        var dateOfCreate = cell.viewWithTag(2) as! UILabel
        var VoltageTh = cell.viewWithTag(3) as! UILabel
        var OnOff = cell.viewWithTag(4) as! UILabel
        var SSwing = cell.viewWithTag(5) as! UILabel
        
        mobility.text = "迁移率 " + String(format: "%.2f", result.monilities)
        if result.monilities > 3.0 {
            mobility.textColor = UIColor.redColor()
        }
        dateOfCreate.text = result.daypiker
        VoltageTh.text = "阈值电压 " + String(format: "%.2f", result.Vth)
        OnOff.text = "开关比 " + String(format: "%.2g", result.onOffRatio)
        SSwing.text = "亚阈值摆幅 " + String(format: "%.2f", result.SS)
        
        return cell
        
    }
    
    //使搜索的cell高度保持一致
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    //删除cell
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            data.removeAtIndex(indexPath.row)
            //删除的动态效果
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
    //上下交换移动cell
    /*在editing模式下*/
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    /*通常情况下*/
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let result = data.removeAtIndex(sourceIndexPath.row)
        data.insert(result, atIndex: destinationIndexPath.row)
    }
    
    //navigate bar 编辑模式
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }

    
    //unwind 按下确定按钮后回传到主界面 在storyboard将button绑定到Exit
    @IBAction func close(segue: UIStoryboardSegue) {
        println("closed")
        tableView.reloadData()
    }
    
}
