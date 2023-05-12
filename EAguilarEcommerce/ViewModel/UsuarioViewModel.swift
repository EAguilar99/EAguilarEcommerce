//
//  UsuarioViewModel.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 04/05/23.
//

import Foundation
import SQLite3


class UsuarioViewModel
{
    
    static func GetAll()->Result
    {
        var context = DBManager()
        var result = Result()
        let query = "SELECT Usuario.IdUsuario,Usuario.UserName,Usuario.Nombre,Usuario.ApellidoPaterno,Usuario.ApellidoMaterno,Usuario.FechaNacimiento,Usuario.Password,Rol.IdRol,Rol.Nombre FROM Usuario INNER JOIN Rol ON Rol.IdRol = Usuario.IdRol"
        var statement : OpaquePointer?
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK
            {
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW
                {
                    var usuario = Usuario()
                    usuario.IdUsuario = Int(sqlite3_column_int(statement, 0))
                    usuario.Username = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    usuario.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                    usuario.ApellidoPaterno = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                    usuario.ApellidoMaterno = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                    usuario.FechaNacimiento = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                    usuario.Password = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                    
                    usuario.Rol = Rol()
                    
                    usuario.Rol?.IdRol = Int(sqlite3_column_int(statement, 7))
                    usuario.Rol?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 8)))
                    
                    result.Objects?.append(usuario)
                }
                result.Correct = true
            }
            else
            {
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
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
    
    
    static func GetByid(idUsuario : Int)->Result
    {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        let query = " SELECT Usuario.IdUsuario,Usuario.UserName,Usuario.Nombre,Usuario.ApellidoPaterno,Usuario.ApellidoMaterno, Usuario.FechaNacimiento,Usuario.Password,Rol.IdRol,Rol.Nombre FROM Usuario INNER JOIN Rol ON Rol.IdRol = Usuario.IdRol WHERE IdUsuario  = \(idUsuario)"
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                let usuario = Usuario()
                if try sqlite3_step(statement) == SQLITE_ROW
                {
                    usuario.IdUsuario = Int(sqlite3_column_int(statement, 0))
                    usuario.Username = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    usuario.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                    usuario.ApellidoPaterno = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                    usuario.ApellidoMaterno = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                    usuario.FechaNacimiento = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                    usuario.Password = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                    
                   // usuario.Rol = Rol()
                    
                    usuario.Rol?.IdRol = Int(sqlite3_column_int(statement, 7))
                    usuario.Rol?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 8)))
                    
                    result.Object = usuario
                    
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
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
    
    static func Add(usuario : Usuario)->Result
    {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        let query = " INSERT INTO Usuario(UserName,Nombre,ApellidoPaterno,ApellidoMaterno, FechaNacimiento, Password,IdRol) VALUES(?,?,?,?,?,?,?)"
        do
        {
            if try(sqlite3_prepare_v2(context.db,query,-1, &statement, nil) == SQLITE_OK)
            {
                sqlite3_bind_text(statement,1, (usuario.Username! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement,2,(usuario.Nombre! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement,3,(usuario.ApellidoPaterno! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement,4,(usuario.ApellidoMaterno! as NSString).utf8String,-1,nil)
                sqlite3_bind_text(statement,5,(usuario.FechaNacimiento! as NSString).utf8String,-1,nil)
                sqlite3_bind_text(statement,6,(usuario.Password! as NSString).utf8String,-1,nil)
                sqlite3_bind_int(statement, 7, Int32(((usuario.Rol?.IdRol! ?? 8) as NSInteger)))
                
                
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    print("Usuario Insertado")
                }
                else
                {
                    print("Error la realizar el insert.")
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
    
    
    
    static func Update(usuario : Usuario)->Result
    {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        let query = "UPDATE Usuario SET UserName  = ?, Nombre  = ?, ApellidoPaterno = ?, ApellidoMaterno  = ?, FechaNacimiento  = ?, Password = ? WHERE IdUsuario = \(usuario.IdUsuario!)"
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                //var usuario = Usuario()
                sqlite3_bind_text(statement, 1, (usuario.Username! as NSString).utf8String,-1,nil)
                sqlite3_bind_text(statement, 2, (usuario.Nombre! as NSString).utf8String,-1,nil)
                sqlite3_bind_text(statement, 3, (usuario.ApellidoPaterno! as NSString).utf8String,-1,nil)
                sqlite3_bind_text(statement, 4, (usuario.ApellidoMaterno! as NSString).utf8String,-1,nil)
                sqlite3_bind_text(statement, 5, (usuario.FechaNacimiento! as NSString).utf8String,-1,nil)
                sqlite3_bind_text(statement, 6, (usuario.Password! as NSString).utf8String,-1,nil)
                
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    print("Usuario Actualizado")
                    
                }
                else
                {
                    print("Error al actualizar el usuario")
                }
                result.Correct = true
            }
            
            else
            {
                print("Ocurrio un error")
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
    
    
    
    
    
    static func Delete(idUsuario : Int )->Result
    {
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        var query = "DELETE FROM Usuario WHERE IdUsuario  = \(idUsuario)"
        do
        {
            if try(sqlite3_prepare_v2(context.db,query,-1,&statement, nil) == SQLITE_OK)
            {
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    print("Usuario eliminado")
                    
                }
                
                else
                {
                    print("Error al eliminar registro")
                }
                result.Correct = true
            }
            else
            {
                print("Ocurrio un error")
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
