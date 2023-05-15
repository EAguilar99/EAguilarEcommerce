//
//  ViewController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 27/04/23.
//

import UIKit
import SQLite3
import SwipeCellKit
import iOSDropDown

class FormController: UIViewController {
    
    
    @IBOutlet weak var btnAgregarOutlet: UIButton!
    
    @IBOutlet weak var txtidUsuarioOutlet: UITextField!
    
    @IBOutlet weak var txtUserNameOutlet: UITextField!
    
    @IBOutlet weak var txtNombreOutlet: UITextField!
    
    @IBOutlet weak var txtApellidoPaternoOutlet: UITextField!
    
    @IBOutlet weak var txtApellidoMaternoOutlet: UITextField!
    
    @IBOutlet weak var dpFechaNacimientoOutlet : UIDatePicker!
    
    @IBOutlet weak var txtPasswordOutlet: UITextField!
    
    @IBOutlet weak var ddlRol: DropDown!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblApellidoPaterno: UILabel!
    
    @IBOutlet weak var lblApellidoMaterno: UILabel!
    
    @IBOutlet weak var lblPassword: UILabel!
    
    @IBOutlet weak var btnAction: UIButton!
    
    let dbManager = DBManager()
    
    var IdUsuario : Int = 0
    var IdRol : Int = 0
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        ddlRol.didSelect {selectedText , index , id in
            self.IdRol =  id
         }
        
        ddlRol.optionArray = []
        ddlRol.optionIds? = []
        
        let resultRol = RolViewModel.Getall()
        
        if resultRol.Correct!{
            for objrol in resultRol.Objects!{
                
                var roles = objrol as! Rol
                
                ddlRol.optionArray.append(roles.Nombre!)
                ddlRol.optionIds?.append(roles.IdRol!)
        }
            if IdUsuario != 0
            {
                RecuperarDatos(idUsuario: IdUsuario )
                btnAction.backgroundColor = UIColor.yellow
                btnAction.setTitle("Actualizar", for: .normal)
            }
            else
            {
                btnAction.backgroundColor = UIColor.green
                btnAction.setTitle("Agregar", for: .normal)
            }
        }
    }
        @IBAction func btnsAction(_ sender: UIButton)
        {
            let btnSeleccionado = sender.titleLabel?.text
            
            guard txtUserNameOutlet.text != "" else
            {
                lblUserName.text = "Campo requerido"
                lblUserName.textColor  = .red
                lblUserName.isHidden = false
                return
            }
            
            guard txtNombreOutlet.text != "" else
            {
                lblNombre.text = "Campo Requerido"
                lblNombre.textColor = .red
                lblNombre.isHidden = false
                return
            }
            
            guard txtApellidoPaternoOutlet.text != "" else
            {
                lblApellidoPaterno.text = "Campo Requerido"
                lblApellidoPaterno.textColor = .red
                lblApellidoPaterno.isHidden = false
                return
            }
            
            guard txtApellidoMaternoOutlet.text != "" else
            {
                lblApellidoMaterno.text = "Campo Requerido"
                lblApellidoMaterno.textColor = .red
                lblApellidoMaterno.isHidden  = false
                return
            }
            
            guard txtPasswordOutlet.text != ""
            else
            {
                lblPassword.text = "Campo Requerido"
                lblPassword.textColor = .red
                lblPassword.isHidden  = false
                return
            }
            
            var usuario = Usuario()
            
            var date = dpFechaNacimientoOutlet.date
            var dateFormat = DateFormatter()
            dateFormat.dateFormat  = "dd-MM-YYYY"
            
            usuario.IdUsuario = Int(txtidUsuarioOutlet.text!)
            usuario.Username = txtUserNameOutlet.text!
            usuario.Nombre = txtNombreOutlet.text!
            usuario.ApellidoPaterno = txtApellidoPaternoOutlet.text!
            usuario.ApellidoMaterno = txtApellidoMaternoOutlet.text!
            usuario.FechaNacimiento = dateFormat.string(from: date)
            usuario.Password = txtPasswordOutlet.text!
            usuario.Rol = Rol()
            usuario.Rol?.IdRol = ddlRol.selectedIndex
            
            
            let opcion = btnAction.titleLabel?.text
            
            if(btnSeleccionado == "Actualizar")
            {
                //var idUsuario = txtidUsuarioOutlet.text
                var resutl  = UsuarioViewModel.Update(usuario: usuario)
                print("Actualizado")
                if resutl.Correct!
                {
                    
                    let alert = UIAlertController(title: "Mensaje", message: "Usuario actualizado con exito.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    
                }
                else
                {
                    let alert = UIAlertController(title: "Mensaje", message: "Error al actualizar el usuario.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
            
            if(btnSeleccionado == "Agregar")
            {
                //limpiarFornulario()
                var result = UsuarioViewModel.Add(usuario: usuario)
                if result.Correct!
                {
                    let alert = UIAlertController(title: "Mensaje", message: "Usuario agregado con exito ", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
                else
                {
                    let alert = UIAlertController(title: "Mensaje", message: "Error al actualizar el usuario.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
        }
        
        func RecuperarDatos(idUsuario : Int)
        {
            var result = UsuarioViewModel.GetByid(idUsuario: IdUsuario)
            var usuario = result.Object as! Usuario
            
            var date = dpFechaNacimientoOutlet.date
            var dateFormat = DateFormatter()
            dateFormat.dateFormat  = "dd-MM-YYYY"
            
            txtidUsuarioOutlet.text = String (usuario.IdUsuario!)
            txtUserNameOutlet.text = (usuario.Username!)
            txtNombreOutlet.text = (usuario.Nombre!)
            txtApellidoPaternoOutlet.text = (usuario.ApellidoPaterno!)
            txtApellidoMaternoOutlet.text = (usuario.ApellidoMaterno!)
            //dpFechaNacimientoOutlet.date = date.dateFormat
            txtPasswordOutlet.text = (usuario.Password!)
            ddlRol.text = (usuario.Rol?.Nombre)
            //ddlRol.text = String(usuario.Rol!.IdRol!)
        }
        
        func limpiarFornulario()
        {
            txtidUsuarioOutlet.text = ""
            txtUserNameOutlet.text = ""
            txtNombreOutlet.text = ""
            txtApellidoPaternoOutlet.text = ""
            txtApellidoMaternoOutlet.text = ""
            dpFechaNacimientoOutlet.date = Date.now
            txtPasswordOutlet.text = ""
            lblUserName.text = ""
            lblNombre.text = ""
            lblApellidoPaterno.text = ""
            lblApellidoMaterno.text = ""
            
        }
}



