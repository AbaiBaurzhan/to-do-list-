//
//  PersonViewController.swift
//  todoList
//
//  Created by Абай Бауржан on 14.10.2024.
//

import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var secondNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
        
        var contact: Contact?

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Заполняем текстовые поля данными контакта, если они есть
            if let contact = contact {
                firstNameTextField.text = contact.firstName
                secondNameTextField.text = contact.lastName
                phoneNumberTextField.text = contact.phoneNumber
            }
        }
        
        @IBAction func contactChanges(_ sender: Any) {
            // Проверяем, что текстовые поля не пустые
            guard let firstName = firstNameTextField.text, !firstName.isEmpty,
                  let lastName = secondNameTextField.text, !lastName.isEmpty,
                  let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty
            else {
                return
            }

            // Создаем обновленный контакт
            let updatedContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
            
            // Загружаем контакты
            var contacts = loadContacts()
            
            // Находим индекс существующего контакта и обновляем его
            if let index = contacts.firstIndex(where: { $0.phoneNumber == contact?.phoneNumber }) {
                contacts[index] = updatedContact
                saveContacts(contacts)
            }
            
            // Возвращаемся на предыдущий экран
            navigationController?.popViewController(animated: true)
        }

        func loadContacts() -> [Contact] {
            do {
                if let data = UserDefaults.standard.data(forKey: "contactsArray") {
                    return try JSONDecoder().decode([Contact].self, from: data)
                }
            } catch {
                print("Unable to decode contacts: \(error)")
            }
            return []
        }

        func saveContacts(_ contacts: [Contact]) {
            do {
                let encodedData = try JSONEncoder().encode(contacts)
                UserDefaults.standard.set(encodedData, forKey: "contactsArray")
            } catch {
                print("Unable to encode contacts: \(error)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


