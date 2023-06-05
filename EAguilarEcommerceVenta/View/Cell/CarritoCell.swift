//
//  CarritoCell.swift
//  EAguilarEcommerceVenta
//
//  Created by MacBookMBA17 on 30/05/23.
//

import UIKit
import SwipeCellKit

class CarritoCell: SwipeTableViewCell  {
    @IBOutlet weak var UIImageOutlet: UIImageView!
    
    @IBOutlet weak var lblSubtotalOutlet: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var lblPrecioOutlet: UILabel!
    @IBOutlet weak var lblCantidadOutlet: UILabel!
    @IBOutlet weak var lblNombreOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
