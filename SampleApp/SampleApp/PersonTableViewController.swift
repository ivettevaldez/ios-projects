//
//  PersonTableViewController.swift
//  SampleApp
//
//  Created by Silvia on 10/10/18.
//  Copyright © 2018 Silvia Valdez. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {

    // MARK: - Properties
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadSamplePeople()
    }
    
    //MARK: - Private methods
    
    private func loadSamplePeople() {
        let defaultPhoto = UIImage(named: "person1")
        
        guard let person1 = Person(name: "Silvia Valdez", profession: "Programmer", photo: defaultPhoto) else {
            fatalError("Unable to instantiate person1")
        }
        
        guard let person2 = Person(name: "Jorge Macías", profession: "Programmer", photo: defaultPhoto) else {
            fatalError("Unable to instantiate person2")
        }
        
        guard let person3 = Person(name: "Jesús Quintero", profession: "Electronic", photo: defaultPhoto) else {
            fatalError("Unable to instantiate person3")
        }
        
        guard let person4 = Person(name: "Fernando Carrizosa", profession: "Mechatronic", photo: defaultPhoto) else {
            fatalError("Unable to instantiate person4")
        }
        
        people += [person1, person2, person3, person4]
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PersonTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PersonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PersonTableViewCell.")
        }
        
        // Fetches the appropriate person for the data source layout.
        let person = people[indexPath.row]
        
        cell.nameLabel.text = person.name
        cell.professionLabel.text = person.profession
        cell.photoImageView.image = person.photo

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

}
