//
//  ServicePersonClient.swift
//  MVVMefc
//
//  Created by eduardo fulgencio on 04/01/2020.
//  Copyright © 2020 Eduardo Fulgencio Comendeiro. All rights reserved.
//

import Foundation
import Parse

class ServicePersonClient {

    enum GetPersonsFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }

    typealias GetPersonsResult = Result<[Person], GetPersonsFailureReason>
    typealias GetPersonsCompletion = (_ result: GetPersonsResult) -> Void

    func getPersons(completion: @escaping GetPersonsCompletion) {
              let query2 = PFQuery(className: "Clase")
              query2.cachePolicy = PFCachePolicy.networkElseCache
              
              query2.findObjectsInBackground { (objects, error) -> Void in
                  
                  if let error = error {
                      print("Error: \(error) \(error.localizedDescription)")
                      return
                  }
                  
                  if let objects = objects {
                      var persons = [Person]()
                      for (index, object) in objects.enumerated() {
                          // Convert PFObject into Trip object
                          let person = Person(pfObject: object)
                          persons.append(person)
                      }
                      completion(.success(payload: persons))
                  } else {
                      completion(.failure(nil))
                  }
              }

    }

}
