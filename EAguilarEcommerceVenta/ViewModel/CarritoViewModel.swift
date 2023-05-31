//
//  CarritoViewModel.swift
//  EAguilarEcommerceVenta
//
//  Created by MacBookMBA17 on 26/05/23.
//

import Foundation
import UIKit
import CoreData

class CarritoViewModel{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(_ IdProducto : Int) -> Result{
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context)!
        
        let alumno = NSManagedObject(entity: entity, insertInto: context)
        
        alumno.setValue(IdProducto, forKey: "idProducto")
        alumno.setValue(1, forKey: "cantidad")
        
        do{
            try context.save()
            result.Correct = true
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        
        return result
    }
    func UpdateCantidad(IdAlumno : Int){
        
    }
    func Delete(_ IdProducto : Int)->Result{
        var result = Result()
           
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           
           let context = appDelegate.persistentContainer.viewContext
           
           let response = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
           response.predicate = NSPredicate(format: "idProducto = %@", String(IdProducto))
           
           do{
               let test = try context.fetch(response)
               
               let ObjectDelete = test[0] as! NSManagedObject
               context.delete(ObjectDelete)
               
               try context.save()
               
               result.Correct = true
               print("Producto eliminado del carrito")
               
           }catch let error{
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               result.Ex = error
           }
           return result
    }
    func GetById(idProducto : Int){
        
    }
    
        func GetAll() -> Result{

            var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
        
        do{
            let resultFetch = try context.fetch(response)
            result.Objects = []
            for obj in resultFetch as! [NSManagedObject]{
                let ventaproducto = VentaProductos()
                
                ventaproducto.producto = Producto()
                ventaproducto.producto?.IdProducto = obj.value(forKey: "idProducto") as! Int
                ventaproducto.cantidad = obj.value(forKey: "cantidad") as! Int
                let resultGetById = ProductoViewModel.GetById(idProducto: ventaproducto.producto?.IdProducto as! Int)
                
                if resultGetById.Correct! {

                    let producto = resultGetById.Object! as! Producto
                    
                    ventaproducto.producto?.Nombre = producto.Nombre
                    ventaproducto.producto?.Descripcion = producto.Descripcion
                    
                    result.Correct = true
                    
                }
                result.Objects?.append(ventaproducto)
            }
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }
}
