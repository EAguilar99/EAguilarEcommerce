//
//  ProductoViewModel.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 16/05/23.
//

import Foundation
import SQLite3

class ProductoViewModel
{
   
    
    static func GetAll()->Result
    {
        var context = DBManager()
        var result = Result()
        /**/
        let query = "SELECT  Producto.IdProducto, Producto.Nombre, Producto.PrecioUnitario,Producto.Stock, Producto.Descripcion, Producto.Imagen, Departamento.IdDepartamento, Departamento.Nombre, Proveedor. IdProveedor, Proveedor.Nombre, Proveedor.Telefono FROM Producto INNER JOIN Departamento on Departamento.IdDepartamento = Producto.IdDepartamento INNER JOIN Proveedor on  Proveedor.IdProveedor = Producto.IdProveedor"
        
        var statement : OpaquePointer?
        
        do
        {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK
            {
                result.Objects = []
                
                while sqlite3_step(statement) == SQLITE_ROW
                {
                    var producto = Producto()
                    
                    producto.IdProducto = Int(String(cString: sqlite3_column_text(statement, 0)))
                    producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    producto.PrecioUnitario =  Int(String(cString: sqlite3_column_text(statement, 2)))
                    producto.Stock = Int(String(cString: sqlite3_column_text(statement, 3)))
                    producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement, 4)))


                    producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(String(cString: sqlite3_column_text(statement, 6)))
                    producto.Departamento?.Nombre =  String(describing: String(cString: sqlite3_column_text(statement, 7)))
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = Int(String(cString: sqlite3_column_text(statement, 8)))
                    producto.Proveedor?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 9)))
                    producto.Proveedor?.Telefono = String(describing: String(cString: sqlite3_column_text(statement, 10)))
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
            }
            else
            {
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error al realizar el get all"
            }
        }
        catch let ex
        {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
    static func GetById(idProducto : Int)->Result
    {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        
        var query = "SELECT  Producto.IdProducto, Producto.Nombre, Producto.PrecioUnitario,Producto.Stock, Producto.Descripcion, Producto.Imagen, Departamento.Nombre, Proveedor.Nombre FROM Producto INNER JOIN Departamento on Departamento.IdDepartamento = Producto.IdDepartamento INNER JOIN Proveedor ON Producto.IdProveedor = Proveedor.IdProveedor WHERE IdProducto = \(idProducto)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                let producto = Producto()
                if try(sqlite3_step(statement) == SQLITE_ROW)
                {
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    producto.PrecioUnitario = Int(sqlite3_column_int(statement, 2))
                    producto.Stock = Int(sqlite3_column_int(statement, 3))
                    producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                    producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                    
                    producto.Departamento = Departamento()
                    
                    producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                    
                    producto.Proveedor = Proveedor()
                    
                    producto.Proveedor?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 7)))
                    
                    result.Object = producto
                    
                    result.Correct =  true
                }
                else
                {
                    result.Correct = false
                    result.ErrorMessage = "Ocurrio un error "
                }
            }
        }
        catch let ex
        {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
    static func Add(producto : Producto)->Result
    {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        
        var query = " INSERT INTO Producto(Nombre, PrecioUnitario,Stock,Descripcion,Imagen ,IdProveedor,IdDepartamento) VALUES(?,?,?,?,?,?,?)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                sqlite3_bind_text(statement, 1, (producto.Nombre! as NSString).utf8String, -1, nil)
                
                sqlite3_bind_int(statement, 2, Int32(((producto.PrecioUnitario! ?? 2) as NSInteger)))
                sqlite3_bind_int(statement, 3, Int32(((producto.Stock! ?? 3) as NSInteger)))
                sqlite3_bind_text(statement, 4, (producto.Descripcion! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 5, (producto.Imagen! as NSString).utf8String, -1, nil)
                
                sqlite3_bind_int(statement, 6, Int32(((producto.Proveedor?.IdProveedor! ?? 5) as NSInteger)))
                sqlite3_bind_int(statement, 7, Int32(((producto.Departamento?.IdDepartamento! ?? 6) as NSInteger)))
                
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    print("Producto insertado")
                }
                else
                {
                    print("Error al insertar el producto")
                }
                result.Correct = true
                
            }
        }
        catch let ex
        {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
    
    static func Update(producto : Producto)->Result
    {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        
        let query = "UPDATE Producto SET  Nombre = ?, PrecioUnitario = ?, Stock = ?, Descripcion = ?, Imagen = ?, IdProveedor = ?, IdDepartamento = ? WHERE IdProducto = \(producto.IdProducto!)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                sqlite3_bind_text(statement, 1, (producto.Nombre! as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 2, Int32(((producto.PrecioUnitario! ?? 2) as NSInteger)))
                sqlite3_bind_int(statement, 3, Int32(((producto.Stock! ?? 3) as NSInteger)))
                sqlite3_bind_text(statement, 4, (producto.Descripcion! as NSString).utf8String, -1, nil)
                
                sqlite3_bind_text(statement, 5, (producto.Imagen! as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 6, Int32(((producto.Proveedor?.IdProveedor! ?? 5) as NSInteger)))
                sqlite3_bind_int(statement, 7, Int32(((producto.Departamento?.IdDepartamento! ?? 6) as NSInteger)))
                
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    print("Producto actualizado")
                    
                    result.Correct = true
                }
                else
                {
                    print("Error al actualizar el producto")
                }
                
            }
        }
        catch let ex
        {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
    static func Delete(idProducto : Int )->Result
    {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        var query = "DELETE FROM Producto WHERE IdProducto = \(idProducto)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    print("Producto eliminado")
                    result.Correct = true
                }
                else
                {
                    print("error al eliminar el producto")
                }
            }
        }
        catch let ex
        {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
    static func GetByIdDepartamento(idDepartamento : Int)->Result
    {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        
        var query =
        "SELECT  IdProducto, Nombre, PrecioUnitario,Stock, Descripcion,Imagen, IdDepartamento FROM Producto WHERE IdDepartamento = \(idDepartamento)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                let producto = Producto()
                if try(sqlite3_step(statement) == SQLITE_ROW)
                {
                    result.Objects = []
                    
                    while sqlite3_step(statement) == SQLITE_ROW
                    {
                        var producto = Producto()
                    
                        producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                        producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                        producto.PrecioUnitario = Int(sqlite3_column_int(statement, 2))
                        producto.Stock = Int(sqlite3_column_int(statement, 3))
                        producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                        producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                        producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 6))
                        
                        result.Objects?.append(producto)
                    }
                    result.Correct = true
                }
                else
                {
                    result.Correct = false
                    result.ErrorMessage = "Ocurrio un error "
                }

            }
        }
        catch let ex
        {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
}
