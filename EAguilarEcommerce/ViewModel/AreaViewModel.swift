//
//  AreaViewModel.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 22/05/23.
//

import Foundation
import SQLite3


class AreaViewModel
{
    static func GetAll()->Result
    {
        var context = DBManager()
        var result = Result()
        let query = "SELECT  IdArea, Nombre FROM Area"
        
        var statement : OpaquePointer?
        
        do
        {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK
            {
                result.Objects = []
                
                while sqlite3_step(statement) == SQLITE_ROW
                {
                    var area = Area()
                    
                    area.IdArea = Int(String(cString: sqlite3_column_text(statement, 0)))
                    area.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Objects?.append(area)
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
    
    
    static func GetById(idArea : Int)->Result
    {
        var context = DBManager()
        var result  =  Result()
        var statement : OpaquePointer? = nil
        
        var query = "SELECT IdArea,Nombre FROM Area WHERE IdArea  = 1 "
        /*\(idArea)*/
        
        do
        {
            if try(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK)
            {
                let area = Area()
                if try(sqlite3_step(statement) == SQLITE_ROW)
                {
                    area.IdArea = Int(sqlite3_column_int(statement, 0))
                    area.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Object = area
                    
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
    
}
