//
//  VCProtocols.swift
//  Sqlite_CRUD
//
//  Created by belal medhat on 09/05/2021.
//

import Foundation
protocol VCViewProtocols {
    var presenter:VCPresenterProtocols? {get set}
    func refreshSqlTable()
    func clearTextfield()
    func deleteDataModel()
    func appendUsers(UsersData:UserModel)

}
protocol VCPresenterProtocols {
    var view:VCViewProtocols? {get set}
    func openDatabase()
    func createTable()
    func createRecord(id:String,name:String)
    func readRecord()
    func updateRecord(name:String,id:String)
    func deleteRecord(id:String)
}
