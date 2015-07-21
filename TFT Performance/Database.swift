//
//  Database.swift
//  TFT Performance
//
//  Created by dyx on 15/6/16.
//  Copyright (c) 2015年 dyx. All rights reserved.
//

import Foundation

class Result: NSObject {
    var Vth: Double
    var monilities: Double
    var onOffRatio: Double
    var SS: Double
    var daypiker: String
    
    init(Vth: Double, monilities: Double, onOffRatio: Double, SS: Double, daypiker: String) {
        self.Vth = Vth
        self.monilities = monilities
        self.onOffRatio = onOffRatio
        self.SS = SS
        self.daypiker = daypiker
    }
    
    func clear() {
        
    }
}
