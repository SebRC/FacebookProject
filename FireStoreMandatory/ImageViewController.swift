//
//  ImageViewController.swift
//  FireStoreMandatory
//
//  Created by Sebastian Christiansen on 21/03/2019.
//  Copyright © 2019 Sebastian Christiansen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var uploadButton: UIButton!
	@IBOutlet weak var imageView: UIImageView!
	var ref : DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
		
		ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		if(imageView.image == nil)
		{
			uploadButton.isHidden = true
		}
		else
		{
			uploadButton.isHidden = false
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

			imageView.contentMode = .scaleAspectFit

			//imageView.image = image.resizeImage(newWidth: 150)

			imageView.image = image
		} else {
			print("Error")
		}

		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func pickImagePressed(_ sender: Any)
	{
		let image = UIImagePickerController()
		image.delegate = self
		image.sourceType = UIImagePickerController.SourceType.photoLibrary
		
		self.present(image, animated: true)
	}
	
	@IBAction func uploadImagePressed(_ sender: Any)
	{
		let key = ref?.child("images/1").key
		let filename = "\(key!).png"
		let fileRef = Storage.storage().reference().child("\(filename)")
		let meta = StorageMetadata()
		meta.contentType = "image/png"
		fileRef.putData((imageView.image?.pngData())!, metadata: meta, completion: {(meta, error) in
			if(error == nil)
			{
				self.ref?.child("images/1/image").setValue(filename)
			}
		})
		
	}
}
