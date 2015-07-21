//
//  ViewController.swift
//  TFT Performance
//
//  Created by dyx on 15/6/15.
//  Copyright (c) 2015年 dyx. All rights reserved.
//

import UIKit


class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Ids1: UITextField!
    @IBOutlet weak var Vgs1: UITextField!
    @IBOutlet weak var Ids2: UITextField!
    @IBOutlet weak var Vgs2: UITextField!
    @IBOutlet weak var Width: UITextField!
    @IBOutlet weak var Length: UITextField!
    @IBOutlet weak var Ion: UITextField!
    @IBOutlet weak var Ioff: UITextField!
    @IBOutlet weak var Capacity: UITextField!

    
    let performance = PerformanceCalculator()
    var result: Result?
    var today: NSDate = NSDate()
    
    func stringFromDate(day: NSDate) -> String {
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var dateString = formatter.stringFromDate(day)
        return dateString
    }
    
    func convertion(input: String) -> Double {
        return NSNumberFormatter().numberFromString(input)!.doubleValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSThread.sleepForTimeInterval(3.0)//启动画面3秒延时
        Ids1.delegate = self
        Vgs1.delegate = self
        Ids2.delegate = self
        Vgs2.delegate = self
        Width.delegate = self
        Length.delegate = self
        Ion.delegate = self
        Ioff.delegate = self
        Capacity.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func OKTap(sender: UIButton) {
        let Gradient = performance.sqrtGradient(self.convertion(Ids1.text), cu2: self.convertion(Ids2.text), voltage1: self.convertion(Vgs1.text), voltage2: self.convertion(Vgs2.text))
        println("\(Gradient)")
        let vth = performance.thresholdVoltage(self.convertion(Ids1.text), voltage1: self.convertion(Vgs1.text), gradient: Gradient!)!
        println("\(vth)")
        let mobily = performance.mobility(self.convertion(Length.text), width: self.convertion(Width.text), capacity: self.convertion(Capacity.text), gradient: Gradient!)!
        println("\(mobily)")
        let onOff = performance.onOffRatio(self.convertion(Ion.text), Ioff: self.convertion(Ioff.text))
        println("\(onOff)")
        let SS = performance.thresholdSwing(self.convertion(Ids1.text), cu2: self.convertion(Ids2.text), voltage1: self.convertion(Vgs1.text), voltage2: self.convertion(Vgs2.text))!
        println("\(SS)")
        
        if result == nil {
            var result = Result(Vth: vth, monilities: mobily, onOffRatio: onOff, SS: SS, daypiker: self.stringFromDate(today))
            println("\(result)")
            data.append(result)
        }
        else {
            result?.Vth = vth
            result?.monilities = mobily
            result?.onOffRatio = onOff
            result?.SS = SS
            result?.daypiker = self.stringFromDate(today)
        }
    }

    //避免键盘遮挡输入框
    
    let offsetForKeyboard = 40 as CGFloat
    
    func setViewMoveup(moveup: Bool) {
        UIView.beginAnimations("AddView", context: nil)
        UIView.setAnimationDuration(0.3)
        var rect: CGRect = self.view.frame
        
        if moveup {
            rect.origin.y -= offsetForKeyboard
            rect.size.height += offsetForKeyboard
        }
        else {
            rect.origin.y += offsetForKeyboard
            rect.size.height -= offsetForKeyboard
        }
        self.view.frame = rect
        UIView.commitAnimations()
    }
    
    func keyboardWillShow() {
        if self.view.frame.origin.y >= 0 {
            self.setViewMoveup(true)
        }
        else {
            self.setViewMoveup(false)
        }
    }
    
    func keyboardWillHide() {
        if self.view.frame.origin.y >= 0 {
            self.setViewMoveup(true)
        }
        else {
            self.setViewMoveup(false)
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.frame.origin.y > self.view.frame.height - 220.0 {
            if self.view.frame.origin.y >= 0 {
                self.setViewMoveup(true)
            }
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }


    //触摸屏幕键盘退出
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        Ids1.resignFirstResponder()
        Ids2.resignFirstResponder()
        Vgs1.resignFirstResponder()
        Vgs2.resignFirstResponder()
        Width.resignFirstResponder()
        Length.resignFirstResponder()
        Ion.resignFirstResponder()
        Ioff.resignFirstResponder()
        Capacity.resignFirstResponder()
    }
    
    //按下回车使键盘弹回
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //编辑完成后使视图恢复到原始状态



}

