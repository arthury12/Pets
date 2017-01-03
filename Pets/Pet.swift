//
//  DogDB.swift
//  Pets
//
//  Created by Arthur Yu on 11/20/16.
//  Copyright © 2016 Arthur Yu. All rights reserved.
//

import Foundation

struct Pet {
    var name: String?
    var type: String?
    var breed: String?
    var sex: String?
    var age: String?
    var size: String?
    var description: String?
    var phone: String?
    var address: String?
    var email: String?
    var id: String?
    var imageURL: [String?] = []                      //photo id="1" size="x
    var additionalOptions: [String]?
}
