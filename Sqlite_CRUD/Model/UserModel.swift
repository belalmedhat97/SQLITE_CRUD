//
//  UserModel.swift
//  Sqlite_CRUD
//
//  Created by belal medhat on 09/05/2021.
//

import Foundation
class UserModel {
    
    var name: String?
    var employeeId: Int?
    
    init(name: String, employeeId: Int) {
        self.name = name
        self.employeeId = employeeId
    }
}
