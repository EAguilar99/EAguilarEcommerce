//
//  RolViewModel.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 09/05/23.
//

import Foundation
import SQLite3

class RolViewModel
{
    
    static func Getall()->Result
    {
        var context =  DBManager()
        var result = Result()
        let query = "SELECT IdRol, Nombre FROM Rol"
        var statement : OpaquePointer?
        
        do
        {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK
            {
                result.Objects = []
                
                while sqlite3_step(statement) == SQLITE_ROW
                {
                    var rol = Rol()
                    
                    rol.IdRol = Int(String(cString: sqlite3_column_text(statement, 0)))
                    rol.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Objects?.append(rol)
                }
                result.Correct = true
            }
            else
            {
                result.Correct = false
                result.ErrorMessage = "Ocurrio unn error"
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
    
    
    static func GetById(idRol : Int)->Result
    {
        var context = DBManager()
        var result  =  Result()
        var statement : OpaquePointer? = nil
        
        var query = "SELECT IdRol,Nombre FROM Rol WHERE IdRol  = \(idRol)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                let rol = Rol()
                if try(sqlite3_step(statement) == SQLITE_ROW)
                {
                    rol.IdRol = Int(sqlite3_column_int(statement, 0))
                    rol.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Object = rol
                    
                    result.Correct = true
                }
            }
            else
            {
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
        }
        catch let ex
        {
            result.Correct  = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
    static func Add(rol : Rol)->Result
    {
        
        var context =  DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        
        var query = "INSERT INTO Rol (Nombre) Values(?)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                sqlite3_bind_text(statement, 1, (rol.Nombre! as NSString).utf8String, -1, nil)
                
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    print("Rol insertado")
                }
                else
                {
                    print("Error al realizar el insert")
                }
            }
            result.Correct = true
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
    
    static func Update(rol : Rol)->Result
    {
        var context = DBManager()
        var result  = Result()
        var statement : OpaquePointer?
        
        var query = "UPDATE Rol SET  Nombre = ? WHERE IdRol = \(rol.IdRol)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                sqlite3_bind_text(statement, 1, (rol.Nombre! as NSString).utf8String,-1, nil)
                
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    print("Rol Actualizado")
                    result.Correct = true
                }
                else
                {
                    print("Error al actualizar el rol")
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
    
    
    
    static func Delete(idRol : Int)-> Result
    {
        var context = DBManager()
        var result  = Result()
        var statement : OpaquePointer? = nil
        
        var query = "DELETE FROM Rol WHERE IdRol = \(idRol)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    print("Rol eliminado con exito")
                    result.Correct = true
                }
                else
                {
                    print("Error al eliminar el rol")
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
