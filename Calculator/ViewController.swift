//
//  ViewController.swift
//  Calculator
//
//  Created by Huang Yinan on 7/24/16.
//  Copyright © 2016 Huang Yinan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var allowInputPoint = true
    
    @IBAction func operation(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "✖️":
            performOperation { $0 * $1 }
        case "➗":
            if operandStack.last!.isZero {
        display.text = "+∞"
            }else {
                performOperation { $1 / $0 }
            }
        case "➕":
            performOperation { $0 + $1 }
        case "➖":
            performOperation { $1 - $0 }
        case "√":
            performOperation { sqrt($0) }
        case "sin":
            performOperation { sin($0) }
        case "cos":
            performOperation { cos($0) }
        default:
            break
        }
        
    }
    
    func performOperation(operation: (Double,Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast() , operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        let pai = M_PI
        print("digit = \(digit)")
        if userIsInTheMiddleOfTypingANumber {
            if digit == "." && allowInputPoint {
                display.text = display.text! + digit
                allowInputPoint = false
            }else if digit != "." {
                display.text = display.text! + digit
            }else if digit == "π" {
                //code never go here
                print("pai = \(pai)")
                //display.text = NSString(format: "%f" , pai) as String
                //enter()
            }
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
            allowInputPoint = true
        }
        
    }
    
    var operandStack = Array<Double>()

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }

    var displayValue: Double {
        get {
            return display.text != "π" ? NSNumberFormatter().numberFromString(display.text!)!.doubleValue :M_PI
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

