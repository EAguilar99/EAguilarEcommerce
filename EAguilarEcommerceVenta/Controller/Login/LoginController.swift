//
//  LoginController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 19/05/23.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    @IBOutlet weak var txtCorreoOutlet: UITextField!
    
    @IBOutlet weak var lblCorreoOutlet: UILabel!
    
    @IBOutlet weak var txtContraseñaOutlet: UITextField!
    
    @IBOutlet weak var lblContraseñaOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        degradado()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        guard txtCorreoOutlet.text != "" else
        {
            lblCorreoOutlet.text = "Campo requerido"
            lblCorreoOutlet.textColor  = .red
            lblCorreoOutlet.isHidden = false
            return
        }
        
        guard txtContraseñaOutlet.text != "" else
        {
            lblContraseñaOutlet.text = "Campo requerido"
            lblCorreoOutlet.textColor = .red
            lblContraseñaOutlet.isHidden = false
            return
        }
        
        var correo : String = txtCorreoOutlet.text!
        var contraseña : String = txtContraseñaOutlet.text!
        
        Auth.auth().signIn(withEmail: correo , password: contraseña) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
            
            var loginresult = authResult
            var errorResult = error
            if errorResult == nil
            {
                self!.performSegue(withIdentifier: "usuario", sender: self)
            }
            else
            {
                    let alert = UIAlertController(title: "Mensaje", message: "Contraseña o usuario no validos ", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(action)
                    self!.present(alert, animated: true)
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
