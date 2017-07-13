//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Azat IOS on 12.07.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!

    var btnSound: AVAudioPlayer!

    // MARK: This is created enum called Operation: and describe all of the operator cases
    enum Operation: String {
        case Divide   = "/"
        case Add      = "+"
        case Equal    = "="
        case Multiply = "*"
        case Subtract = "-"
        case Empty    = "Empty"
    }

    //MARK: variable initialized as Empty
    var currentOperation = Operation.Empty
    var runningNumber    = ""
    var leftValStr       = ""
    var rightValStr      = ""
    var result           = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        outputLbl.text = "0"
        // MARK: This is path to our sounds (when buttons are pressed)
        let path     = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)

        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        // MARK: Each time we press the button it depends to variable named "runningNumber"
        // -> which is output of output Label
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    







    @IBAction func onDividePressed (sender: AnyObject) {
        processOperation(operation: .Divide)
    }

    @IBAction func onMultiplyPressed (sender: AnyObject) {
        processOperation(operation: .Multiply)
    }

    @IBAction func onSubtractPressed (sender: AnyObject) {
        processOperation(operation: .Subtract)
    }

    @IBAction func onAddPressed (sender: AnyObject) {
        processOperation(operation: .Add)
    }

    @IBAction func onEqualPressed (sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    @IBAction func clearBtnPrsd(_ sender: Any) {
        allClear()
    }

    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    // MARK: a method named processOperation and pass into this method an operation
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {

            // MARK: A user selected operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr   = runningNumber
                runningNumber = ""

                if currentOperation == Operation.Multiply {
                    result = "\(Int(leftValStr)! * Int(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Int(leftValStr)! / Int(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Int(leftValStr)! - Int(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Int(leftValStr)! + Int(rightValStr)!)"
                }
                leftValStr     = result
                outputLbl.text = result
            }
            currentOperation   = operation
        }
            else {
                // MARK: This is the first time an operator first time pressed
            leftValStr       = runningNumber
            runningNumber    = ""
            currentOperation = operation
            }
        }
        func allClear()  {
        leftValStr     = ""
        rightValStr    = ""
        runningNumber  = ""
        result         = ""
        outputLbl.text = "0"
    }
}
