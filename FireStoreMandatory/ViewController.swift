//
//  ViewController.swift
//  FireStoreMandatory
//
//  Created by Sebastian Christiansen on 12/03/2019.
//  Copyright © 2019 Sebastian Christiansen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore

let fR = FirebaseRepo()
class ViewController: UIViewController, UITableViewController {

	@IBOutlet weak var textView: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(fR.getStatus())
		
		fR.viewController = self
	}
	
	func reloadTableSomething()
	{
		print("Reloading here")
	}
	
	
	@IBAction func logoutPressed(_ sender: Any)
	{
		do
		{
			try Auth.auth().signOut()
			print("User logged out succesfully")
			self.performSegue(withIdentifier: "logoutSegue", sender: self)
		}
		catch
		{
			print("Error signing out \(error.localizedDescription)")
		}
		
	}
	
	@IBAction func saveButtonPressed(_ sender: Any)
	{
		if let txt = textView.text
		{
			fR.notesCollection.document().setData(["text" : txt])
			{
				error in
				if(error != nil)
				{
					print("Error saving to Firebase \(error.debugDescription)")
				}
			}
		}
		
		fR.notesCollection.document().delete()
		
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		textView.resignFirstResponder()
	}
	
}

