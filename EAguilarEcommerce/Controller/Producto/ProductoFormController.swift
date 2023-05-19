//
//  ProductoFormController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 17/05/23.
//

import UIKit
import SQLite3
import SwipeCellKit
import iOSDropDown

class ProductoFormController: UIViewController {
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblPrecioUnitario: UILabel!
    @IBOutlet weak var lblStock: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblDepartamento: UILabel!
    
    @IBOutlet weak var lblproveedor: UILabel!
    @IBOutlet weak var UIImagenOutlet: UIImageView!
    
    @IBOutlet weak var txtNombreOutlet: UITextField!
    @IBOutlet weak var txtPrecioUnitarioOutlet: UITextField!
    
    @IBOutlet weak var txtStockOutlet: UITextField!
    @IBOutlet weak var txtDescripcionOutlet: UITextField!
    
    @IBOutlet weak var ddlProveedor: DropDown!
    
    @IBOutlet weak var ddlDepartamento: DropDown!
    
    @IBOutlet weak var txtIdProductoOutlet: UITextField!
    
    @IBOutlet weak var btnActionOutlet: UIButton!
    let dbManager = DBManager()
    
    var IdProducto : Int = 0
    var IdProveedor : Int = 0
    var idDepartamento :Int = 0
    var StringBase64 : String = ""
    
    let imagePickercontroller  = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        degradado()
        
        imagePickercontroller.delegate = self
        imagePickercontroller.sourceType = .photoLibrary
        imagePickercontroller.isEditing = false
        if IdProducto != 0
        {
            RecuperarDatos(idProducto: IdProducto)
            btnActionOutlet.backgroundColor = .yellow
            btnActionOutlet.setTitle("Actualizar", for: .normal)
        }
        else
        {
            btnActionOutlet.backgroundColor = .green
            btnActionOutlet.setTitle("Agregar", for: .normal)
        }
        
        ddlDepartamento.didSelect {selectedText , index , id in
            self.idDepartamento =  id }
        
        ddlDepartamento.optionArray = []
        ddlDepartamento.optionIds? = []
        
        let resultDepartamento = ProductoViewModel.GetAllDepartamento()
        
        if resultDepartamento.Correct!{
            for objDepartamento in resultDepartamento.Objects!{
                
                let departamentos = objDepartamento as! Departamento
                ddlDepartamento.optionArray.append(departamentos.Nombre!)
                ddlDepartamento.optionIds?.append(departamentos.IdDepartamento!)
            }
        }
        
        ddlProveedor.didSelect {selectedText , index , id in
            self.IdProducto =  id }
         
        ddlProveedor.optionArray = []
        ddlProveedor.optionIds? = []
        
        let resultProveedor = ProductoViewModel.GetAllProveedor()
        
        if resultProveedor.Correct!{
            for objProveedor in resultProveedor.Objects!{
                
                let proveedores = objProveedor as! Proveedor
                
                ddlProveedor.optionArray.append(proveedores.Nombre!)
                ddlProveedor.optionIds?.append(proveedores.IdProveedor!)
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
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0.0, 1.0]

        // Set the start and end points for the gradient layer
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        // Set the frame to the layer
        gradientLayer.frame = view.frame

        // Add the gradient layer as a sublayer to the background view
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    
    @IBAction func btnRecuperarImagen(_ sender: Any) {
        self.present(imagePickercontroller, animated: true)
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        let btnSeleccionado = sender.titleLabel?.text
        
        guard txtNombreOutlet.text != "" else
        {
            lblNombre.text = "Campo requerido"
            lblNombre.textColor = .red
            lblNombre.isHidden = false
            return
        }
        
        let imagen = UIImagenOutlet.image
        //producto.Imagen = convertToBase64(imagen : imagen)
        
        var producto = Producto()
        
        producto.IdProducto = Int(txtIdProductoOutlet.text!)
        producto.Nombre = txtNombreOutlet.text!
        producto.PrecioUnitario = Int(txtPrecioUnitarioOutlet.text!)
        producto.Stock = Int(txtStockOutlet.text!)
        producto.Descripcion = txtDescripcionOutlet.text!
        //producto.Imagen =
        producto.Proveedor = Proveedor()
        //producto.Proveedor?.IdProveedor = Int(ddlProveedor)
        producto.Departamento = Departamento()
        //producto.Departamento?.IdDepartamento = Int(ddlDepartamento)
        //producto.Imagen = UIImagenOutlet
        
        
        let opcion = btnActionOutlet.titleLabel?.text
        
        
        if(btnSeleccionado == "Actualizar")
        {
            var result = ProductoViewModel.Update(producto: producto)
            print("Producto actualizado")
            if result.Correct!
            {
                let alert = UIAlertController(title: "Mensaje", message: "Producto actualizado con exito", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                
                alert.addAction(action)
                self.present(alert , animated: true)
            }
        }
        
        if(btnSeleccionado == "Agregar")
        {
            var result = ProductoViewModel.Add(producto: producto)
            if result.Correct!
            {
                let alert = UIAlertController(title: "Mensaje", message: "Producto agregado con exito ", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            
        }
    }
    
    
    func RecuperarDatos(idProducto : Int)
    {
        var result =  ProductoViewModel.GetById(idProducto: IdProducto)
        var producto = result.Object as! Producto
        
        txtIdProductoOutlet.text = String(producto.IdProducto!)
        txtNombreOutlet.text = (producto.Nombre!)
        txtPrecioUnitarioOutlet.text = String(producto.PrecioUnitario!)
        txtStockOutlet.text = String(producto.Stock!)
        txtDescripcionOutlet.text = (producto.Descripcion!)
        ddlProveedor.text = producto.Proveedor?.Nombre!
        ddlDepartamento.text = producto.Departamento?.Nombre!
        ddlProveedor.text = producto.Proveedor?.Nombre!
    }
    
    
    func LimpiarDatos()
    {
        txtIdProductoOutlet.text = ""
        txtNombreOutlet.text = ""
        txtPrecioUnitarioOutlet.text = ""
        txtStockOutlet.text = ""
        txtDescripcionOutlet.text = ""
        ddlProveedor.text = ""
        ddlDepartamento.text = ""
        

    }
    
    
}


extension ProductoFormController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage]
        self.UIImagenOutlet.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        convertToBase64(image: image as! UIImage)
        
    }
    
        func convertToBase64(image : UIImage)
    {
        
        //Proceso
        let base64 = image.jpegData(compressionQuality: 1.0)
        self.StringBase64 = base64!.base64EncodedString()
    }
}
