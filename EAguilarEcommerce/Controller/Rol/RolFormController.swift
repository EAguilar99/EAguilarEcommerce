//
//  RolFormController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 11/05/23.
//

import UIKit
import SQLite3
import SwipeCellKit

class RolFormController: UIViewController {

    @IBOutlet weak var txtIdRolOutlet: UITextField!
    @IBOutlet weak var txtNombreOutlet: UITextField!
    
    @IBOutlet weak var lblNombreRol: UILabel!
    let dbManager = DBManager()
    
    var IdRol : Int = 0
    
    @IBOutlet weak var btnAgregar: UIButton!
    
    @IBOutlet weak var btnAction: UIButton!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        
        txtNombreOutlet.delegate = self
        txtNombreOutlet.tag = 1
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RolFormController.ocultarTecladoPantalla))
                
                //Descomentar, si el tap no debe interferir o cancelar otras acciones
                //tap.cancelsTouchesInView = false
                
                view.addGestureRecognizer(tap)
        
        
        
        
        if IdRol != 0
        {
            RecuperarDatosRol(idRol: IdRol)
            btnAction.backgroundColor = .yellow
            btnAction.setTitle("Actualizar", for: .normal)
        }
        else
        {
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        let btnSeleccionado = sender.titleLabel?.text
        
        guard txtNombreOutlet.text != "" else
        {
            lblNombreRol.text = "Campo requerido"
            lblNombreRol.textColor  = .red
            lblNombreRol.isHidden = false
            return
        }
        
        
        var rol = Rol()
        
        rol.IdRol = Int(txtIdRolOutlet.text!)
        rol.Nombre = txtNombreOutlet.text!
        
        
        let opcion = btnAction.titleLabel?.text
        
        
        
        if(btnSeleccionado == "Actualizar")
        {
            //var idUsuario = txtidUsuarioOutlet.text
            var resutl  = RolViewModel.Update(rol: rol)
            print("Actualizado")
            if resutl.Correct!
            {
                
                let alert = UIAlertController(title: "Mensaje", message: "Rol actualizado con exito.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
                
            }
            else
            {
                let alert = UIAlertController(title: "Mensaje", message: "Error al actualizar el Rol.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
        if(btnSeleccionado == "Agregar")
        {
            var result = RolViewModel.Add(rol: rol)
            if result.Correct!
            {
                let alert = UIAlertController(title: "Mensaje", message: "Rol agregado con exito ", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            else
            {
                let alert = UIAlertController(title: "Mensaje", message: "Error al actualizar el rol.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
        
    }
    func RecuperarDatosRol(idRol : Int)
    {
        var result = RolViewModel.GetById(idRol: IdRol)
        
        var rol = result.Object as! Rol
        
        txtIdRolOutlet.text = String(rol.IdRol!)
        txtNombreOutlet.text = (rol.Nombre)
    }
    
    
}

extension RolFormController : UITextFieldDelegate
{
    @objc func ocultarTecladoPantalla()->Void
    {
        view.endEditing(true)
    }
    
    //Cuando la tecla de return es pulsada
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
     if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
     nextField.becomeFirstResponder()
     } else {
     textField.resignFirstResponder()
     }
     return false
    }
    
    func deslizar()
    {}
}

