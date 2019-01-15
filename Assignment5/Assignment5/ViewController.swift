//
//  ViewController.swift
//  Assignment5
//
//  Created by Rishavgupta on 1/11/19.
//  Copyright © 2019 Nuclei. All rights reserved.
//

import UIKit

class ViewController: UIViewController{


    var personInfo: [PersonInfo]? = []
    
    @IBOutlet weak var noContactsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRightBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
       
        self.tableView.reloadData()
        
        showAndSortData()
    }
    
    @objc func addContactButton(){
        if let addViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddViewController") as? AddViewController{
            self.navigationController?.pushViewController(addViewController, animated: true)
            addViewController.addPersonDelegate = self
            addViewController.allPersons = personInfo
        }
    }
    
    func showAndSortData(){
        if var personInfo: [PersonInfo] = personInfo{
            personInfo.sort(by: {($0.name)! > ($1.name)! })
        }
        if personInfo?.count != 0{
            tableView.isHidden = false
            self.noContactsLabel.text = ""
        }else{
            tableView.isHidden = true
            self.noContactsLabel.text = "No contacts found"
        }
    }
    
    func addRightBarButton(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButton))
        self.navigationItem.rightBarButtonItem = addButton
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }
}
extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let personInfo = personInfo{
            return personInfo.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! CustomTableViewCell
        
        if let personInfo = personInfo{
            let text = personInfo[indexPath.row].name
            cell.label.text = text
        }
        
        return cell
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let editViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditViewController") as? EditViewController{
            self.navigationController?.pushViewController(editViewController, animated: true)
            if let personInfo = personInfo{
                editViewController.nameAndNum = personInfo
                editViewController.indexOfContact = indexPath.row
            }
        }
        
    }
}

extension ViewController: AddPersonDelegateProtocol{
    func addPerson(personObject: PersonInfo){
        personInfo?.append(personObject)
    }
}



