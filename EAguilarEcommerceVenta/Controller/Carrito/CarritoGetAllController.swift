//
//  CarritoGetAllController.swift
//  EAguilarEcommerceVenta
//
//  Created by MacBookMBA17 on 29/05/23.
//

import UIKit
import SwipeCellKit

class CarritoGetAllController: UIViewController{
    
    var total : Double = 0
    var subtotal : Int = 0
    
    var carritoViewModel = CarritoViewModel()
    var productosdelCarrito : [VentaProductos] = []
    var dbManager = DBManager()
    
    @IBOutlet weak var CarritoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdateUI()
        
        CarritoTableView.delegate = self
        CarritoTableView.dataSource = self
        
        //let nib = UINib(nibName: "CarritoCell" , bundle: .main)
        
        CarritoTableView.register(UINib(nibName: "CarritoCell" , bundle: .main), forCellReuseIdentifier: "CarritoCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UpdateUI()
    }
    
    func UpdateUI()
    {
        var result = carritoViewModel.GetAll()
        productosdelCarrito.removeAll()
        
        if result.Correct!
        {
            for ObjCarrito in result.Objects!
            {
                var carrito = ObjCarrito as! VentaProductos
                productosdelCarrito.append(carrito)
            }
            CarritoTableView.reloadData()
        }
    }
}

    
    // MARK: - Table view data source
    
    extension CarritoGetAllController : UITableViewDataSource, UITableViewDelegate
    {
        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return productosdelCarrito.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoCell
            cell.delegate = self
            // Configure the cell...
            
            if productosdelCarrito[indexPath.row].producto?.Imagen == "" || productosdelCarrito[indexPath.row].producto?.Imagen == nil
            {
                cell.UIImageOutlet.image = UIImage(named: "defaultimage")
            }
            else{
                var string : String = productosdelCarrito[indexPath.row].producto!.Imagen!
                var dataDecoded : Data = Data(base64Encoded: string)!
                cell.UIImageOutlet.image = UIImage(data: dataDecoded)
            }
            
            cell.lblNombreOutlet.text = productosdelCarrito[indexPath.row].producto?.Nombre
            cell.lblCantidadOutlet.text = (String(productosdelCarrito[indexPath.row].cantidad!))
            //cell.lblPrecioOutlet.text = (String(productosdelCarrito[indexPath.row].producto!.PrecioUnitario!))
            cell.lblSubtotalOutlet.text = productosdelCarrito[indexPath.row].producto?.PrecioUnitario?.description
            
            subtotal = productosdelCarrito[indexPath.row].cantidad! * (productosdelCarrito[indexPath.row].producto?.PrecioUnitario ?? 0)
            cell.lblSubtotalOutlet.text = String(subtotal)
            
            cell.stepper.value = Double(productosdelCarrito[indexPath.row].cantidad!)
            cell.stepper.tag = indexPath.row
            cell.stepper.addTarget(self , action: #selector(Steeperaction), for: .touchUpInside)
            
            print("el index actual es \(indexPath.row)")
            return cell
        }
    }


//MARK: implementacion de Swipe
extension CarritoGetAllController : SwipeTableViewCellDelegate{
    
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
                
                let result = self.carritoViewModel.Delete((self.productosdelCarrito[indexPath.row].producto?.IdProducto! ?? 0)!)
            
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
        return nil
    }
    
    
    
    func updateUI()
    {
        var result = carritoViewModel.GetAll()
        productosdelCarrito.removeAll()
        if result.Correct!
        {
            for objproducto in result.Objects!
            {
                let producto = objproducto as! VentaProductos
                productosdelCarrito.append(producto)
            }
            CarritoTableView.reloadData()
        }
    }
    
    
    @objc func Steeperaction(sender: UIStepper){
            let indexPath = IndexPath(row: sender.tag, section: 0)
            print("sender ---> \(sender.value)")
            if sender.value >= 1{
                if carritoViewModel.UpdateCantidad(IdProducto: (productosdelCarrito[indexPath.row].producto?.IdProducto)!, Cantidad: Int(sender.value)).Correct!{
                    total = 0.0
                    UpdateUI()
                    print("Se actualizó")
                }else{
                    print("No se puede actualizar")
                }
            }else{
                sender.value = 1
                print("Ocurrio un error")
            }
        }
    }

    
    
 


