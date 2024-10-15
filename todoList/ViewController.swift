//
//  ViewController.swift
//  todoList
//
//  Created by Olzhas Akhmetov on 22.09.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addTask(_ sender: Any) {
        guard let firstName = nameTextField.text, !firstName.isEmpty,
              let lastName = surnameTextField.text, !lastName.isEmpty,
              let phoneNumber = numberTextField.text, !phoneNumber.isEmpty else {
            return
        }
        
        let newContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        
        do {
            if let data = UserDefaults.standard.data(forKey: "contactsArray") {
                var array = try JSONDecoder().decode([Contact].self, from: data)
                array.append(newContact)
                
                let encodedData = try JSONEncoder().encode(array)
                UserDefaults.standard.set(encodedData, forKey: "contactsArray")
            } else {
                let encodedData = try JSONEncoder().encode([newContact])
                UserDefaults.standard.set(encodedData, forKey: "contactsArray")
            }
        } catch {
            print("Unable to encode or decode: \(error)")
        }
        
            
            //        let name = textfield.text!
            //        let surname = textfield.text!
            //        let phone = textfield.text!
            //
            //
            //        var newContact = TaskItem(name: task, isComplete: false)
            //
            //        do {
            //            if let data = UserDefaults.standard.data(forKey: "taskItemArray") {
            //
            //                var array = try JSONDecoder().decode([TaskItem].self, from: data)
            //
            //                array.append(newTask)
            //
            //                let encodedata = try JSONEncoder().encode(array)
            //
            //                UserDefaults.standard.set(encodedata, forKey: "taskItemArray")
            //            } else {
            //
            //                let encodedata = try JSONEncoder().encode([newTask])
            //
            //                UserDefaults.standard.set(encodedata, forKey: "taskItemArray")
            //            }
            //
            //
            //        } catch {
            //            print("unable to encode \(error)")
            //        }
            
            //        if let taskArray = UserDefaults.standard.array(forKey: "taskArray") as? [String] {
            //           var array = taskArray
            //
            //            array.append(task)
            //
            //            UserDefaults.standard.setValue(array, forKey: "taskArray")
            //
            //        } else {
            //            UserDefaults.standard.setValue([task], forKey: "taskArray")
            //        }}
        
            nameTextField.text = ""
            surnameTextField.text = ""
            numberTextField.text = ""
        }
        
        
    }
