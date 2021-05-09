//
//  ViewController.swift
//  Sqlite_CRUD
//
//  Created by belal medhat on 09/05/2021.
//

import UIKit
import SQLite3
class VC: UIViewController,VCViewProtocols{
 
    
    var presenter: VCPresenterProtocols?

   private var Users = [UserModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.presenter = VCViewPresenter(view: self)
        Sqltable.delegate = self
        Sqltable.dataSource = self
        Sqltable.layer.cornerRadius = 10
        Sqltable.layer.borderWidth = 1
        Sqltable.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Sqltable.clipsToBounds = true
        //MARK: - create the database 

        self.presenter?.openDatabase()

    }

    @IBOutlet weak var Sqltable: UITableView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBAction func sqlCrud(_ sender: UIButton) {
        guard idField.text != "" && nameField.text != "" else {
            // create the alert
              let alert = UIAlertController(title: "EMPTY FIELDS", message: "Enter Data In Id And Name Field", preferredStyle: UIAlertController.Style.alert)

              // add an action (button)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

              // show the alert
              self.present(alert, animated: true, completion: nil)
            return
        }
        //getting values from textfields
        let id = idField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch sender.tag {
        case 0:
            self.presenter?.createRecord(id:id!,name:name!)
        case 1:
            self.presenter?.readRecord()
        case 2:
            self.presenter?.updateRecord(name: name!, id: id!)
        case 3:
            self.presenter?.deleteRecord(id:id!)

        default:
            ""
        }
    }
    //MARK: - refresh tableview after adding ,update or delete
    func refreshSqlTable() {
        DispatchQueue.main.async {
            self.Sqltable.reloadData()
        }
    }
    
    func clearTextfield(){
        //emptying the textfields
        DispatchQueue.main.async {
            self.idField.text=""
            self.nameField.text=""        }
    
 
    }
    //MARK: - clear users array from data

    func deleteDataModel(){
        self.Users.removeAll()
    }
    //MARK: - add users to users array

    func appendUsers(UsersData:UserModel){
        self.Users.append(UsersData)
    }
    

}
extension VC:UITableViewDelegate,UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.Users.count
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = Sqltable.dequeueReusableCell(withIdentifier: "SQLCELL", for: indexPath) as! SqlTableViewCell
    
    cell.IdLabelTable.text = "\(Users[indexPath.row].employeeId ?? 0)"
    cell.NameLabelTable.text = Users[indexPath.row].name ?? ""

    
           return cell
    
}

}
