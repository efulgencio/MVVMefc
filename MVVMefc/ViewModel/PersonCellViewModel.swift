//
//  PersonCellViewModel.swift
//  MVVMefc
//
//  Created by eduardo fulgencio on 04/01/2020.
//  Copyright © 2020 Eduardo Fulgencio Comendeiro. All rights reserved.
//

import Foundation

protocol PersonCellViewModel {
    var personItem: Person { get }
    var nameModif: String { get }
    var ageText: String { get }
}

extension Person: PersonCellViewModel {
    var personItem: Person {
        return self
    }
    var nameModif: String {
        return "Nombre: " + personName
    }
    var ageText: String {
        return String(age)
    }
}
