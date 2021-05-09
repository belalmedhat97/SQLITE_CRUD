//
//  SqlTableViewCell.swift
//  Sqlite_CRUD
//
//  Created by belal medhat on 09/05/2021.
//

import UIKit

class SqlTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var IdLabelTable: UILabel!
    @IBOutlet weak var NameLabelTable: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
