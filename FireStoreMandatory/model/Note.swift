//
//  Note.swift
//  FireStoreMandatory
//
//  Created by Sebastian Christiansen on 12/03/2019.
//  Copyright © 2019 Sebastian Christiansen. All rights reserved.
//

import Foundation

class Note
{
	var text : String
	var id : String
	
	init(text : String, id : String)
	{
		self.text = text
		self.id = id
	}
	
	init(text : String)
	{
		self.text = text
		self.id = ""
	}
}
