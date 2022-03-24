//  Calculator - ViewController.swift
//  Created by quokka.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputFormulaLabel: UILabel!
    @IBOutlet weak var inputOperatorLabel: UILabel!
    @IBOutlet var operandBtns: [UIButton]!
    @IBOutlet var operatorBtns: [UIButton]!
    
    @IBOutlet weak var allClearBtn: UIButton!
    @IBOutlet weak var clearEntryBtn: UIButton!
    @IBOutlet weak var plusAndMinusBtn: UIButton!
    @IBOutlet weak var calculationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputFormulaLabel.text = ""
        inputOperatorLabel.text = ""
        removeOperatorLabelTextAtInputValueIsZero()
    }
    
    @IBAction func appendOperandToInputFormulaLabel(_ sender: UIButton) {
        guard let operand = operandBtns[sender.tag].titleLabel?.text,
              let inputValue = inputFormulaLabel.text else { return }
        inputFormulaLabel.text = inputValue+operand
    }
    
    @IBAction func appendOperatorToInputFormulaLabel(_ sender: UIButton) {
        guard let operatorValue = operatorBtns[sender.tag].titleLabel?.text else { return }
        inputOperatorLabel.text = operatorValue
    }
    
    @IBAction func touchUpEntryClearToInputFormulaLabel() {
        if inputOperatorLabel.text?.isEmpty == true {
            inputFormulaLabel.text?.removeLast()
            inputFormulaLabel.text = "0"
        }
    }
    
    @IBAction func touchUpAllClearToInputFormulaLabel() {
        inputFormulaLabel.text?.removeAll()
        inputOperatorLabel.text?.removeAll()
        inputFormulaLabel.text = "0"
    }
    
    @IBAction func switchPlusAndMinusToInputOperatorLabel() {
        if inputOperatorLabel.text == "➕" {
            inputOperatorLabel.text = "➖"
        } else {
            inputOperatorLabel.text = "➕"
        }
    }
    
    func removeOperatorLabelTextAtInputValueIsZero() {
        if inputFormulaLabel.text == "0" {
            inputOperatorLabel.text?.removeAll()
        }
    }
}
