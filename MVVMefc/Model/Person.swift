//
//  Person.swift
//  MVVMefc
//
//  Created by eduardo fulgencio on 04/01/2020.
//  Copyright © 2020 Eduardo Fulgencio Comendeiro. All rights reserved.
//

import UIKit
import Parse

struct Person {
    var personId = ""
    var personName = ""
    var age = 0
    
    init(personId: String, name: String, age: Int) {
        self.personId = personId
        self.personName = name
        self.age = age
    }
    
    init(pfObject: PFObject) {
        self.personId = pfObject.objectId!
        self.personName = pfObject["nombre"] as! String
        self.age = pfObject["edad"] as? Int ?? 0
    }
    
    func toPFObject() -> PFObject {
        let tripObject = PFObject(className: "Clase")
        tripObject.objectId = personId
        tripObject["nombre"] = personName
        tripObject["edad"] = age
        return tripObject
    }
}


