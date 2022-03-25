//  Calculator - ViewController.swift
//  Created by quokka.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var calculatingValueLabel: UILabel!
    @IBOutlet weak var inputFormulaLabel: UILabel!
    @IBOutlet weak var inputOperatorLabel: UILabel!
    @IBOutlet var operandBtns: [UIButton]!
    @IBOutlet var operatorBtns: [UIButton]!
    
    @IBOutlet weak var allClearBtn: UIButton!
    @IBOutlet weak var clearEntryBtn: UIButton!
    @IBOutlet weak var plusAndMinusBtn: UIButton!
    @IBOutlet weak var calculationBtn: UIButton!
    
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 20
        return numberFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputFormulaLabel.text = "0"
        inputOperatorLabel.text = ""
        removeOperatorLabelTextAtInputValueIsZero()
    }
    
    @IBAction func touchUpOperandBtns(_ sender: UIButton) {
        if inputFormulaLabel.text == "0" { inputOperatorLabel.text = "" }
        guard let inputOperandValue = operandBtns[sender.tag].titleLabel?.text,
              let enteredValue = inputFormulaLabel.text else { return }
        let resultValue = enteredValue+inputOperandValue
        inputFormulaLabel.text = convertDecimalValue(resultValue)
    }
    
    @IBAction func touchUpOperatorBtns(_ sender: UIButton) {
        if inputFormulaLabel.text == "0", inputOperatorLabel.text?.isEmpty == false { return }
        guard let inputOperatorValue = operatorBtns[sender.tag].titleLabel?.text,
              let enteredValue = inputFormulaLabel.text else { return }
        inputOperatorLabel.text = inputOperatorValue
        calculatingValueLabel.text = enteredValue
        inputFormulaLabel.text = "0"
    }
    
    func convertDecimalValue(_ operatorValue: String) -> String? {
        if let operandDoubleValue = Double(operatorValue) {
            return numberFormatter.string(from: operandDoubleValue as NSNumber)
        } else {
            let operandDoubleValue = operatorValue.split(separator: ",").reduce("", +)
            guard let operandDoubleValue = Double(operandDoubleValue) else { return ""}
            return numberFormatter.string(from: operandDoubleValue as NSNumber)
        }
    }
    
    @IBAction func touchUpEntryClear() {
        if let enteredValue = inputFormulaLabel.text,
           let inputLastValue = enteredValue.last,
           let _ = Int(inputLastValue.description) {
            inputFormulaLabel.text?.removeLast()
        } else if inputOperatorLabel.text?.isEmpty == false {
        } else {
            inputFormulaLabel.text?.removeLast()
        }
    }
    
    @IBAction func touchUpAllClear() {
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
