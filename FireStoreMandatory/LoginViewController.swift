//
//  LoginViewController.swift
//  FireStoreMandatory
//
//  Created by Sebastian Christiansen on 15/03/2019.
//  Copyright © 2019 Sebastian Christiansen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: UIViewController, FUIAuthDelegate, FBSDKLoginButtonDelegate
{
	@IBOutlet weak var loggedInLabel: UILabel!
	@IBOutlet weak var username: UITextField!
	@IBOutlet weak var password: UITextField!
	
	var authUI : FUIAuth?
	
	override func viewDidLoad()
	{
        super.viewDidLoad()
		
		let facebookLoginButton = FBSDKLoginButton()
		facebookLoginButton.delegate = self
		
		facebookLoginButton.center = view.center
		
		self.view.addSubview(facebookLoginButton)
		
		checkFaceBook()
		
		authUI = FUIAuth.defaultAuthUI()
		authUI?.delegate = self
		
		let providers : [FUIAuthProvider] = [FUIGoogleAuth()]
		authUI?.providers = providers
		
		self.navigationController?.navigationBar.isHidden = true
    }
	
	override func viewWillAppear(_ animated: Bool)
	{
		checkFaceBook()
	}
	
	func checkFaceBook()
	{
		if(FBSDKAccessToken.current() != nil)
		{
			print("\n\n\n\nLogged in\n\n\n\n")
			loggedInLabel.text = "Logged in with facebook"
		}
		else
		{
			print("\n\n\n\nLogged out\n\n\n\n")
			loggedInLabel.text = "Not logged in with facebook"
		}
	}
	
	func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
	{
		print("\n\n\n\n\n-------------Facebook button pressed----------\n\n\n\n\n\n")
		
		if error != nil
		{
			print(error.localizedDescription)
		}
		else if(result.isCancelled)
		{
			print("Login cancelled")
		}
		else
		{
			print("You're logged in")
			DispatchQueue.main.async
			{
				self.loggedInLabel.text = "Logged in with facebook"
			}
		}
	}
	
	func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
	{
		print("\n\n\n\nLogged out\n\n\n\n")
		checkFaceBook()
	}
	
	func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?)
	{
	}

	@IBAction func loginPressed(_ sender: Any)
	{
		if let usr = username.text, let pwd = password.text
		{
			Auth.auth().signIn(withEmail: usr, password: pwd)
			{
				(result, error) in
				if(error == nil)
				{
					print("User logged in")
					
					self.performSegue(withIdentifier: "loginSegue", sender: self)
				}
				else
				{
					print("Some error during login \(error.debugDescription)")
				}
			}
		}
	}
	
	@IBAction func createAccountPressed(_ sender: Any)
	{
		performSegue(withIdentifier: "createAccountSegue", sender: self)
	}
	
	@IBAction func googleLoginPressed(_ sender: Any)
	{
		if let authVC = authUI?.authViewController()
		{
			present(authVC, animated : true, completion: nil)
		}
		performSegue(withIdentifier: "loginSegue", sender: nil)
	}
	
}
