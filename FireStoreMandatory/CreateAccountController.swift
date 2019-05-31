//
//  CreateAccountController.swift
//  FireStoreMandatory
//
//  Created by Sebastian Christiansen on 21/03/2019.
//  Copyright © 2019 Sebastian Christiansen. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountController: UIViewController {

	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var username: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func createAccountPressed(_ sender: Any)
	{
		let username = self.username.text
		let password = self.password.text
		
		Auth.auth().createUser(withEmail: username!, password: password!, completion: { (user, error) in
			
		})
		self.navigationController?.navigationBar.isHidden = true
		performSegue(withIdentifier: "accountCreatedSegue", sender: self)
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
