//
//  AddViewController.swift
//  Assignment5
//
//  Created by Rishavgupta on 1/13/19.
//  Copyright © 2019 Nuclei. All rights reserved.
//

import UIKit

protocol AddPersonDelegateProtocol{
    func addPerson(personObject: PersonInfo)
}

class AddViewController: UIViewController {

    var allPersons: [PersonInfo]?
    var addPersonDelegate: AddPersonDelegateProtocol?
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add"
    
    }
    
    @IBAction func onClickCreateButton(_ sender: Any) {
        let nameText = self.nameText.text
        let numberText = self.numberText.text
        
        if let name = nameText, let number = numberText{
            if name == "" || number == "" || !validate(value: number){
                let alert = UIAlertController(title: "Error", message: "Name/Number not entered or incorrect", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{

                var flag: Bool = true
                if let allPersons = allPersons{
                    for iteratePerson in allPersons{
                        if iteratePerson.name == name{
                            flag = false
                        }
                    }
                }
                if flag == false{
                    let alert = UIAlertController(title: "Error", message: "Name already exists", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                if let allPersons = allPersons{
                    for iteratePerson: PersonInfo in allPersons{
                        if iteratePerson.number == number{
                            flag = false
                        }
                    }
                }
        
                if flag == false{
                    let alert = UIAlertController(title: "Error", message: "Number already exists", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                if flag == true{
                    let personInfo: PersonInfo? = PersonInfo(name: name, number: number)
                    
                    if addPersonDelegate != nil, let personInfo = personInfo{
                        addPersonDelegate?.addPerson(personObject: personInfo)
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
}
