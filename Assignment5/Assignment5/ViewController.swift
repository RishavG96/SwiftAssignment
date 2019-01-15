//
//  ViewController.swift
//  Assignment5
//
//  Created by Rishavgupta on 1/11/19.
//  Copyright © 2019 Nuclei. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController{


    var personInfo: [PersonInfo]? = []
    var newContact: NSManagedObject?
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var noContactsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRightBarButton()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        initializeCoreData()
        
//        resetCoreData()
        
        personInfo = []
        fetchFromCoreData()
        
        showAndSortData()
        
        
        self.tableView.reloadData()
    }
    
    @objc func addContactButton(){
        if let addViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddViewController") as? AddViewController{
            self.navigationController?.pushViewController(addViewController, animated: true)
            addViewController.addPersonDelegate = self
            addViewController.allPersons = personInfo
        }
    }
    
    func resetCoreData(){
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    func initializeCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        if let context = context{
            let entity = NSEntityDescription.entity(forEntityName: "Contacts", in: context)
            newContact = NSManagedObject(entity: entity!, insertInto: context)
        }
    }
    
    func addToCoreData(personObject: PersonInfo){
        if let newContact = newContact{
            newContact.setValue(personObject.name, forKey: "name")
            newContact.setValue(personObject.number, forKey: "number")
        }
        saveToCoreData()
    }
    
    func saveToCoreData(){
        if let context = context{
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    
    func fetchFromCoreData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        if let context = context{
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    //print(data.value(forKey: "name") as? String as Any)
                    let name = data.value(forKey: "name") as? String
                    let number = data.value(forKey: "number") as? String
                    var flag = true
                    if let personInfo = personInfo{
                        for person in personInfo{
                            if person.name == name && person.number == number{
                                flag = false
                                break
                            }
                        }
                    }
                    if flag == true, let name = name, let number = number{
                        let personObject: PersonInfo? = PersonInfo(name: name, number: number)
                        if let personObject = personObject{
                            personInfo?.append(personObject)
                        }
                    }
                }
            } catch {
                print("Failed")
            }
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
                //editViewController.deletePersonDelegate = self
                editViewController.nameAndNum = personInfo
                editViewController.indexOfContact = indexPath.row
            }
        }
        
    }
}

extension ViewController: AddPersonDelegateProtocol{
    func addPerson(personObject: PersonInfo){
        personInfo?.append(personObject)
        addToCoreData(personObject: personObject)
    }
}



