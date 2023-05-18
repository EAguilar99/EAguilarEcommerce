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
    
    @IBOutlet weak var txtProveedorOutlet: UITextField!
    @IBOutlet weak var txtDepartamentoOutlet: UITextField!
    
    @IBOutlet weak var txtIdProductoOutlet: UITextField!
    
    @IBOutlet weak var btnActionOutlet: UIButton!
    let dbManager = DBManager()
    
    var IdProducto : Int = 0
    
    let imagePickercontroller  = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        //producto.image = convertToBase64(imagen : imagen)
        
        var producto = Producto()
        
        producto.IdProducto = Int(txtIdProductoOutlet.text!)
        producto.Nombre = txtNombreOutlet.text!
        producto.PrecioUnitario = Int(txtPrecioUnitarioOutlet.text!)
        producto.Stock = Int(txtStockOutlet.text!)
        producto.Descripcion = txtDescripcionOutlet.text!
        producto.Proveedor = Proveedor()
        //producto.Proveedor?.IdProveedor =
        producto.Departamento = Departamento()
        //producto.Departamento?.IdDepartamento =
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
        txtProveedorOutlet.text = producto.Proveedor?.Nombre!
        txtDepartamentoOutlet.text = producto.Departamento?.Nombre!
        txtProveedorOutlet.text = producto.Proveedor?.Nombre!
    }
    
    
    func LimpiarDatos()
    {
        txtIdProductoOutlet.text = ""
        txtNombreOutlet.text = ""
        txtPrecioUnitarioOutlet.text = ""
        txtStockOutlet.text = ""
        txtDescripcionOutlet.text = ""
        txtProveedorOutlet.text = ""
        txtDepartamentoOutlet.text = ""
        

    }
    
    
}


extension ProductoFormController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let data = info[.originalImage]
        self.UIImagenOutlet.image = info[.originalImage] as! UIImage
        dismiss(animated: true)
        
    }
    
    func convertToBase64(image : UIImage)->String
    {
        let base64 = ""
        //Proceso
        return base64
        
    }
}
