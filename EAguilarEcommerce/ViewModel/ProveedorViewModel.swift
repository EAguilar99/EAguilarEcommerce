//
//  ProveedorViewModel.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 22/05/23.
//

import Foundation
import SQLite3

class ProveedorViewModel
{
    static func GetAll()->Result
    {
        var context = DBManager()
        var result = Result()
        let query = "SELECT  IdProveedor, Nombre FROM Proveedor"
        
        var statement : OpaquePointer?
        
        do
        {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK
            {
                result.Objects = []
                
                while sqlite3_step(statement) == SQLITE_ROW
                {
                    var proveedor = Proveedor()
                    
                    proveedor.IdProveedor = Int(String(cString: sqlite3_column_text(statement, 0)))
                    proveedor.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Objects?.append(proveedor)
                }
                result.Correct = true
            }
            else
            {
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error al realizar el getall"
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
