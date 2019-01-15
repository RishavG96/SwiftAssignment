//
//  EditViewController.swift
//  Assignment5
//
//  Created by Rishavgupta on 1/13/19.
//  Copyright © 2019 Nuclei. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var nameAndNum: [PersonInfo]?
    var indexOfContact: Int?

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit"
        
        disableEdits()
        
        putChosenContact()
        
        addNavigationButtons()
        
    }
    
    @objc func editButtonFunc(){
        nameText.isUserInteractionEnabled = true
        numberText.isUserInteractionEnabled = true
    }

    @objc func deleteButtonFunc(){
        let alert = UIAlertController(title: "Error", message: "Are you really want to delete the records?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: deleteRecord))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func putChosenContact(){
        guard let nameAndNum = nameAndNum, let index = indexOfContact else{
            return
        }
        
        nameText.text = nameAndNum[index].name
        numberText.text = nameAndNum[index].number
    }
    
    func disableEdits(){
        nameText.isUserInteractionEnabled = false
        numberText.isUserInteractionEnabled = false
    }
    
    func addNavigationButtons(){
        
        navigationItem.leftItemsSupplementBackButton = true
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonFunc))
        self.navigationItem.leftBarButtonItem = editButton
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonFunc))
        self.navigationItem.rightBarButtonItem = deleteButton
    }
    
    func deleteRecord(alert: UIAlertAction!){
        guard var nameAndNum = nameAndNum, let indexOfContact = indexOfContact else{
            return
        }
        nameAndNum.remove(at: indexOfContact)
        self.navigationController?.popViewController(animated: true)
    }
    
    func validatePhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    @IBAction func updateButton(_ sender: Any) {
        
        guard let nameAndNum = nameAndNum else{
            return
        }
        
        let updatedName = nameText.text
        let updatedNumber = numberText.text
        guard let newName = updatedName, let newNumber = updatedNumber, let index = indexOfContact else{
            return
        }
        
        if newName == "" || newNumber == "" || !validatePhone(value: newNumber){
            let alert = UIAlertController(title: "Error", message: "Name/Number not entered or incorrect", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            var flagName: Bool = true
            var flagNumber: Bool = true
            for person in nameAndNum{
                if person.name == newName{
                    flagName = false
                }
                if person.number == newNumber{
                    flagNumber = false
                }
            }
            
            if flagName == false && flagNumber == false{
                let alert = UIAlertController(title: "Error", message: "Name/Number already exists", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if nameAndNum[index].name == newName && flagNumber == true{
                
                nameAndNum[index].number = newNumber
                
                self.navigationController?.popViewController(animated: true)
                
            }
            else if nameAndNum[index].number == newNumber && flagName == true{
                
                nameAndNum[index].name = newName
                
                self.navigationController?.popViewController(animated: true)
            }
            else if flagNumber == true && flagName == true{
                
                nameAndNum[index].name = newName
                nameAndNum[index].number = newNumber

                self.navigationController?.popViewController(animated: true)
            }
            else{
                
                let alert = UIAlertController(title: "Error", message: "Name/Number already exists", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
