//
//  FirebaseRepo.swift
//  FireStoreMandatory
//
//  Created by Sebastian Christiansen on 12/03/2019.
//  Copyright © 2019 Sebastian Christiansen. All rights reserved.
//

import Foundation
import Firebase

class FirebaseRepo
{
	var count = 0
	var notes = [Note]()
	let notesCollection = Firestore.firestore().collection("notes")
	public var viewController : DetailViewController?
	
	init()
	{
		startNoteListener()
	}

	func startNoteListener()
	{
		notesCollection.addSnapshotListener
		{
			(snapshot, error) in
			// Code here will be executed whenever there is a change in the service
			
			print("Snapshot has run: \(self.count)")
			
			//print("Received new snapshot")
			
			self.notes.removeAll()
			
			for document in snapshot!.documents
			{
				if let text = document.data()["text"] as? String
				{
					let note = Note(text: text, id : document.documentID)
					self.notes.append(note)
					
				}
			}
			
		}
	}
	
	func getStatus() -> String
	{
		return notesCollection.collectionID
	}
}
