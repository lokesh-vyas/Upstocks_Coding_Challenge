//
//  HoldingCell.swift
//  UpstoxCoding
//
//  Created by Lokesh Vyas on 03/03/22.
//

import UIKit

class HoldingCell: UITableViewCell {
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblPLRuppes: UILabel!
    @IBOutlet weak var lblLTPRuppes: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var cellData : Datum? {
        didSet {
            if let model = self.cellData {
                DispatchQueue.main.async {
                    self.lblSymbol?.text = model.symbol
                    self.lblQuantity.text = String(model.quantity)
                    self.lblLTPRuppes.text = "₹\(model.ltp)"
                }
            }
        }
    }
    
    var setPLData: String? {
        didSet {
                if let _setPLData = self.setPLData {
                    self.lblPLRuppes.text = "₹\(_setPLData)"
                }
        }
    }

}
