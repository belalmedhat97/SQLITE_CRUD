//
//  VCPresenter.swift
//  Sqlite_CRUD
//
//  Created by belal medhat on 09/05/2021.
//

import Foundation
import SQLite3
class VCViewPresenter:VCPresenterProtocols{
  
    
    var view: VCViewProtocols?
    
    var db: OpaquePointer? // the pointer to table location

    init(view:VCViewProtocols){
        self.view = view
    }
    
    func openDatabase(){ // intialize NeuroleapDatabase
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NeuroLeapDatabase.sqlite") // create the database
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK { // open database
            print("error opening database")
        }
        createTable()
    }
    func createTable(){ // create Table inside database
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS NeuroLeapDatabase (ID INTEGER PRIMARY KEY, NAME TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }

    }

    func createRecord(id: String, name: String) {
        
        //creating a statement
         var stmt: OpaquePointer?
  
         //the insert query
         let queryString = "INSERT INTO NeuroLeapDatabase (name, id) VALUES (?,?)"
  
         //preparing the query
         if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
             let errmsg = String(cString: sqlite3_errmsg(db)!)
             print("error preparing insert: \(errmsg)")
             return
         }
  
         //binding the parameters
         if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
             let errmsg = String(cString: sqlite3_errmsg(db)!)
             print("failure binding name: \(errmsg)")
             return
         }
  
        if sqlite3_bind_int(stmt, 2, (id as NSString).intValue) != SQLITE_OK{
             let errmsg = String(cString: sqlite3_errmsg(db)!)
             print("failure binding name: \(errmsg)")
             return
         }
  
         //executing the query to insert values
         if sqlite3_step(stmt) != SQLITE_DONE {
             let errmsg = String(cString: sqlite3_errmsg(db)!)
             print("failure inserting NeuroleapDatabase: \(errmsg)")
             return
         }
  
        self.view?.clearTextfield()
  
         readRecord()
  
         //displaying a success message
         print("NeuroleapDatabase saved successfully")
    }
    
    func readRecord() {
        
               //first empty the list of NueroleapDatabase
        self.view?.deleteDataModel()

    
               //statement pointer
               var stmt:OpaquePointer?
        
               //preparing the query
               if sqlite3_prepare(db, "SELECT * FROM NeuroLeapDatabase", -1, &stmt, nil) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("error preparing insert: \(errmsg)")
                   return
               }
        
               //traversing through all the records
               while(sqlite3_step(stmt) == SQLITE_ROW){
                   let id = sqlite3_column_int(stmt, 0)
                   let name = String(cString: sqlite3_column_text(stmt, 1))
        
                   //adding values to list
                self.view?.appendUsers(UsersData: UserModel(name: String(describing: name), employeeId: Int(id)))
               }
        self.view?.refreshSqlTable()
        

    }
    
    func updateRecord(name: String,id:String) {
        var updateStatement: OpaquePointer?
         if sqlite3_prepare_v2(db, "UPDATE NeuroLeapDatabase SET NAME = '\(name)' WHERE ID = '\(id)'", -1, &updateStatement, nil) ==
             SQLITE_OK {
           if sqlite3_step(updateStatement) == SQLITE_DONE {
             print("\nSuccessfully updated row.")
           } else {
             print("\nCould not update row.")
           }
         } else {
           print("\nUPDATE statement is not prepared")
         }
         sqlite3_finalize(updateStatement)
        readRecord()

    }
    
    func deleteRecord(id:String) {
        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, "DELETE FROM NeuroleapDatabase WHERE ID = \(id)", -1, &deleteStatement, nil) ==
            SQLITE_OK {
          if sqlite3_step(deleteStatement) == SQLITE_DONE {
            print("\nSuccessfully deleted row.")
          } else {
            print("\nCould not delete row.")
          }
        } else {
          print("\nDELETE statement could not be prepared")
        }
        
        sqlite3_finalize(deleteStatement)
        readRecord()
      }
 
    
}
