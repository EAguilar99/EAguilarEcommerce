//
//  ProductoGetAllController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 17/05/23.
//

import UIKit
import SwipeCellKit

class ProductoGetAllController: UITableViewController {
    
    var productos : [Producto] = []
    let dbManager = DBManager()
    var IdProducto : Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "ProductoCell", bundle: .main)
        
        tableView.register(nib, forCellReuseIdentifier: "ProductoCell")
        
        var result = ProductoViewModel.GetAll()
        
        if result.Correct!
        {
            for ObjProducto in result.Objects!
            {
                let producto = ObjProducto as! Producto
                productos.append(producto)
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoCell
        
        cell.delegate = self
        // Configure the cell...
        
        cell.lblNombreOUtlet?.text = productos[indexPath.row].Nombre
        cell.lblDescripcionOutlet?.text = productos[indexPath.row].Descripcion
        cell.lblPrecioUnitarioOutlet.text = String(productos[indexPath.row].PrecioUnitario!)
        cell.lblDepartamentoOutlet.text = productos[indexPath.row].Departamento?.Nombre
        
        //image
        if productos[indexPath.row].Imagen == "" || productos[indexPath.row].Imagen == nil
        {
            cell.UIImageView.image = UIImage(named:"defaultimage")
        }
        else
        {
            var string = productos[indexPath.row].Imagen!
            var decode : Data = Data(base64Encoded: string)!
            cell.UIImageView.image = UIImage(data: decode)
        }

        return cell
    }

}

extension ProductoGetAllController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]?
    {
        
        if orientation == .right
        {
            let deleteAction = SwipeAction(style: .destructive, title: "Delete")
            {
                action, indexPath in
                print(indexPath.row)
                
                print("Se ejecuto la funcion de borrar")
                //CODIGO A EJECUTAR
                
                //AlumnoViewModel.Delete(idAlumno : 2)
                
                let result  = ProductoViewModel.Delete(idProducto: self.productos[indexPath.row].IdProducto!)
                
                if result.Correct!
                {
                    self.updateUI()
                }
                else
                {
                    print("Ocurrio un error")
                }
                
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.IdProducto = self.productos[indexPath.row].IdProducto!
                self.performSegue(withIdentifier: "ProductoFormController", sender: self)
                
                
                print("Se ejecuto la funcion de update")
                //CODIGO A EJECUTAR
                //
            }
            return [updateAction]
        }
        return nil
    }
    
    func updateUI()
    {
        var result = ProductoViewModel.GetAll()
        productos.removeAll()
        if result.Correct!
        {
            for objProducto in result.Objects!
            {
                let producto = objProducto as! Producto
                productos.append(producto)
            }
            tableView?.reloadData()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue , sender : Any?)
    {
        
        if segue.identifier == "ProductoFormController"
        {
            let formControl = segue.destination as!  ProductoFormController
            formControl.IdProducto  = self.IdProducto
        }
        
    }
}

