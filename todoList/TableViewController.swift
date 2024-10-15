//
//  TableViewController.swift
//  todoList
//
//  Created by Olzhas Akhmetov on 22.09.2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    var contacts:[Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addContact()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addContact()
        tableView.reloadData()
        }
//        if let taskArray = UserDefaults.standard.array(forKey: "taskArray") as? [String] {
//            array = taskArray
//            tableView.reloadData()
//        }
        
    func addContact() {
        do {
            if let data = UserDefaults.standard.data(forKey: "contactsArray") {
                contacts = try JSONDecoder().decode([Contact].self, from: data)
            }
        } catch {
            print("Unable to decode contacts: \(error)")
        }
    }
    
//    func saveTasks() {
//        do {
//            
//            let encodedata = try JSONEncoder().encode(contacts)
//            
//            UserDefaults.standard.set(encodedata, forKey: "taskItemArray")
//            
//        } catch {
//            print("unable to encode \(error)")
//        }
//        
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        // Configure the cell...
                
        let contact = contacts[indexPath.row]
          cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"
          cell.detailTextLabel?.text = contact.phoneNumber

          return cell
      }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            saveContacts()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contacts[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let editContactVC = storyboard.instantiateViewController(withIdentifier: "PersonViewController") as? PersonViewController {
            editContactVC.contact = selectedContact
            navigationController?.pushViewController(editContactVC, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            
//            contacts.remove(at: indexPath.row)
//            
//            saveTasks()
//            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
    
    func saveContacts() {
        do {
            let encodedData = try JSONEncoder().encode(contacts)
            UserDefaults.standard.set(encodedData, forKey: "contactsArray")
        } catch {
            print("Unable to encode contacts: \(error)")
        }
    }
}

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

