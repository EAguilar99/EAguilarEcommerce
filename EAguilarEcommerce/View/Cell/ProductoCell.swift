//
//  ProductoCell.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 17/05/23.
//

import UIKit
import SwipeCellKit

class ProductoCell: SwipeTableViewCell {
    @IBOutlet weak var lblNombreOUtlet: UILabel!
    
    @IBOutlet weak var lblPrecioUnitarioOutlet: UILabel!
    @IBOutlet weak var lblDescripcionOutlet: UILabel!
    @IBOutlet weak var lblDepartamentoOutlet: UILabel!
    @IBOutlet weak var UIImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnRecuperarImagen(_ sender: UIButton) {
    }
    
    
}
