//
//  SelectViewController.swift
//  FireStoreMandatory
//
//  Created by Sebastian Christiansen on 21/03/2019.
//  Copyright © 2019 Sebastian Christiansen. All rights reserved.
//

import UIKit
import FirebaseAuth

class SelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func imagesButtonPressed(_ sender: Any)
	{
		performSegue(withIdentifier: "imagesSegue", sender: self)
	}
	
	@IBAction func notesButtonPressed(_ sender: Any)
	{
		performSegue(withIdentifier: "notesSegue", sender: self)
	}
	
	@IBAction func logOutPressed(_ sender: Any)
	{
		do
		{
			try Auth.auth().signOut()
			navigationController?.navigationBar.isHidden = true
			performSegue(withIdentifier: "logoutSegue", sender: self)
		}
		catch
		{
			print("Logout unsuccesful")
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

}
