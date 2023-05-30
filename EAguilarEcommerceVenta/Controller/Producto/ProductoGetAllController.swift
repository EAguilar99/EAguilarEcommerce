
//
//  ProductoCollectionController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 24/05/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductoCollectionController: UICollectionViewController {
    
    let carritoViewModel = CarritoViewModel()
    
    var Productos : [Producto] = []
    let dbManager = DBManager()
    
    var IdProducto = 0
    var IdDepartamento = 0
    var Nombre = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProductoCollectionCell", bundle: .main)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductoCollectionCell")
        
        if Nombre == ""
        {
            var result = ProductoViewModel.GetByIdDepartamento(idDepartamento: IdDepartamento)
            
            if result.Correct!
            {
                for ObjProducto in result.Objects!
                {
                    let producto = ObjProducto as! Producto
                    Productos.append(producto)
                }
            }
        }
        else if Nombre != ""
        {
            var result = ProductoViewModel.GetByIdNombre(Nombre: Nombre)
            
            if result.Correct!
            {
                for objproducto in result.Objects!
                {
                    let producto = objproducto as! Producto
                    Productos.append(producto)
                }
            }
            
        }
        

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Productos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCollectionCell", for: indexPath) as! ProductoCollectionCell
        
        
            var string = Productos[indexPath.row].Imagen!
            var decode : Data = Data(base64Encoded: string)!
        item.UIImagenOutlet.image = UIImage(data: decode)
        
        item.lblNombreOutlet.text = Productos[indexPath.row].Nombre
        item.lblDescripcionOutlet.text = Productos[indexPath.row].Descripcion
        item.lblPrecioOutlet.text = String(Productos[indexPath.row].PrecioUnitario!)
        
        item.btnCarrito.tag = indexPath.row
        item.btnCarrito.addTarget(self, action: #selector(addCarrito), for: .touchUpInside)
        
        return item
    }
    
    @objc func addCarrito(sender : UIButton)
    {
        
        print("se apreto el boton \(sender.tag)")
        print()
      let idProducto = Productos[sender.tag].IdProducto!
        
        var result = carritoViewModel.Add(idProducto)
        if result.Correct!
        {
           let alert = UIAlertController(title: "Mensaje", message: "producto Agregado al carrito", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Mensaje", message: "Error al agregar el producto al carrito", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        carritoViewModel.GetAll()
    }
    
}
