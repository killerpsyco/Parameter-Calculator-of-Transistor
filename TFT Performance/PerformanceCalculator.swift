//
//  PerformanceCalculator.swift
//  TFT Performance
//
//  Created by dyx on 15/6/16.
//  Copyright (c) 2015年 dyx. All rights reserved.
//

import Foundation

class PerformanceCalculator {
    
    func sqrtGradient(cu1: Double, cu2: Double, voltage1: Double, voltage2: Double) -> Double? {
        let sqrtCu1 = sqrt(cu1)
        let sqrtCu2 = sqrt(cu2)
        return (sqrtCu2 - sqrtCu1) / (voltage2 - voltage1)
    }
    
    
    func thresholdVoltage(cu1: Double, voltage1: Double, gradient: Double) -> Double? {
        let sqrtCu1 = sqrt(cu1)
        let intercept = sqrtCu1 - gradient * voltage1
        if gradient != 0 {
            let thVoltage = -(intercept / gradient)
            println("\(thVoltage)")
            return thVoltage
        }
        else {
            return 0.0
        }
    }
    
    func mobility(length: Double, width: Double, capacity: Double, gradient: Double) -> Double? {
        return 2 * (length * 1e-6) * (gradient * gradient * 1e-6) * 1e4 / (width * 1e-2 * capacity * 1e-5)
    }
    
    func onOffRatio(Ion: Double, Ioff: Double) -> Double {
        return Ion / Ioff
    }
    
    func thresholdSwing(cu1: Double, cu2: Double, voltage1: Double, voltage2: Double) -> Double? {
        let log1 = log10(cu1)
        let log2 = log10(cu2)
        return (voltage1 - voltage2) / (log1 - log2)
    }
    
}
