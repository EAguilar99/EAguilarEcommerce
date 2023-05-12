//
//  Usuario.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 28/04/23.
//

import Foundation
import SQLite3

class Usuario
{
    var IdUsuario : Int? = nil
    var Username : String? = nil
    var Nombre : String? = nil
    var ApellidoPaterno : String? = nil
    var ApellidoMaterno : String? = nil
    var FechaNacimiento : String? = nil
    var Password : String? = nil
    var Rol : Rol? = nil
}
