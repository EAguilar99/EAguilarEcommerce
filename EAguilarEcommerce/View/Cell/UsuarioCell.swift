//
//  UsuarioCell.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 03/05/23.
//

import UIKit
import SwipeCellKit

class UsuarioCell: SwipeTableViewCell {
    @IBOutlet weak var txtNombre: UILabel!
    
    @IBOutlet weak var txtApellidoPaterno: UILabel!
   
    @IBOutlet weak var txtApellidoMaterno: UILabel!
    
    @IBOutlet weak var txtUserName: UILabel!
    
    @IBOutlet weak var txtFechaNacimiento: UILabel!
    @IBOutlet weak var txtPassword: UILabel!
    @IBOutlet weak var txtRol: UILabel!
}
