//
//  DetailViewController.swift
//  FireStoreMandatory
//
//  Created by Sebastian Christiansen on 15/03/2019.
//  Copyright © 2019 Sebastian Christiansen. All rights reserved.
//

import UIKit
import FirebaseAuth

class DetailViewController: UIViewController {

	var currentIndex = -1
	@IBOutlet weak var textView: UITextView!
	override func viewDidLoad()
	{
        super.viewDidLoad()
		
		print(fR.getStatus())
		
		fR.viewController = self
    }
	
	override func viewWillAppear(_ animated: Bool)
	{
		if currentIndex > -1
		{
			textView.text = fR.notes[currentIndex].text
		}
		else
		{
			textView.text = "Error"
		}
	}
    
	@IBAction func savePressed(_ sender: Any)
	{
		let txt = textView.text
		
		fR.notesCollection.document(fR.notes[self.currentIndex].id).setData(["text" : txt!])
		fR.notes[self.currentIndex] = Note(text : txt!, id : fR.notes[self.currentIndex].id)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		textView.resignFirstResponder()
	}
}
