//
//  TableViewController.swift
//  FireStoreMandatory
//
//  Created by Sebastian Christiansen on 15/03/2019.
//  Copyright © 2019 Sebastian Christiansen. All rights reserved.
//

import UIKit
import FirebaseAuth

let fR = FirebaseRepo()

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	override func viewWillAppear(_ animated: Bool)
	{
		tableView.reloadData()
	}
	
	@IBAction func refreshPressed(_ sender: Any)
	{
		tableView.reloadData()
	}
	@IBAction func addNotePressed(_ sender: Any)
	{
		fR.notes.append(Note(text : "New note"))
		
		fR.notesCollection.document().setData(["text" : "New note"])
		{
			error in
			if(error != nil)
			{
				print("Error saving to Firebase \(error.debugDescription)")
			}
		}
		
		tableView.reloadData()
	}
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fR.notes.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
		
		cell.textLabel?.text = fR.notes[indexPath.row].text

        return cell
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let viewController = segue.destination as? DetailViewController
		{
			viewController.currentIndex = tableView.indexPathForSelectedRow?.row ?? -1
		}
	}
	

	
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
	

	
    // Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
			
			fR.notesCollection.document(fR.notes[indexPath.row].id).delete()
			
			fR.notes.remove(at: indexPath.row)
			
            tableView.deleteRows(at: [indexPath], with: .fade)
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

}
