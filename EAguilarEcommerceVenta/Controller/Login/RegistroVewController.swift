//
//  RegistroVewController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 23/05/23.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseAuth

class RegistroVewController: UIViewController {
    @IBOutlet weak var txtCorreoOutlet: UITextField!
    @IBOutlet weak var lblCorreoOutlet: UILabel!
    @IBOutlet weak var txtContraseñaOutlet: UITextField!
    @IBOutlet weak var lblContraseñaOutlet: UILabel!
    @IBOutlet weak var txtValidarContraseñaOutlet: UITextField!
    @IBOutlet weak var lblValidarContraseñaOultet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        degradado()

        // Do any additional setup after loading the view.
    }
    @IBAction func Registro(_ sender: Any) {
        
        guard txtCorreoOutlet.text != "" else
        {
            lblCorreoOutlet.text = "Campo requerido"
            lblCorreoOutlet.textColor  = .white
            lblCorreoOutlet.isHidden = false
            return
        }
        
        guard txtContraseñaOutlet.text != "" else
        {
            lblContraseñaOutlet.text = "Campo requerido"
            lblCorreoOutlet.textColor = .white
            lblContraseñaOutlet.isHidden = false
            return
        }
        
        guard txtValidarContraseñaOutlet.text != "" else
        {
            lblValidarContraseñaOultet.text = "Campo requerido"
            lblValidarContraseñaOultet.textColor = .white
            lblValidarContraseñaOultet.isHidden = false
            return
        }
        
        var correo = txtCorreoOutlet.text!
        var contraseña = txtContraseñaOutlet.text!
        var validarContraseña = txtValidarContraseñaOutlet.text!
        
        
        Auth.auth().createUser(withEmail: correo, password: contraseña) { authResult, error in
          
            var resultRegistro = authResult
            var errorResult = error
            
            if contraseña == validarContraseña
            {
                if errorResult == nil
                {
                    self.performSegue(withIdentifier: "usuario", sender: self)
                    
                }
            }
            else
            {
                let alert = UIAlertController(title: "Mensaje", message: "Las contraseñas no coinciden ", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
    
    
    
    func degradado()
    {
        // basic setup
        view.backgroundColor = .white
        navigationItem.title = "Gradient View"

        // Create a new gradient layer
        let gradientLayer = CAGradientLayer()
        // Set the colors and locations for the gradient layer
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.locations = [0.0, 1.0]

        // Set the start and end points for the gradient layer
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        // Set the frame to the layer
        gradientLayer.frame = view.frame

        // Add the gradient layer as a sublayer to the background view
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
