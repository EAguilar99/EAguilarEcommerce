//
//  ProductoCollectionCell.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 24/05/23.
//

import UIKit

class ProductoCollectionCell: UICollectionViewCell {
    @IBOutlet weak var UIImagenOutlet: UIImageView!
    @IBOutlet weak var lblNombreOutlet: UILabel!
    @IBOutlet weak var lblDescripcionOutlet: UILabel!
    @IBOutlet weak var lblPrecioOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnAgregarCarritoAction(_ sender: Any) {
    }
}
