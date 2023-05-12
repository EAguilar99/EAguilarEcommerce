//
//  DBManager.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 28/04/23.
//

import Foundation
import UIKit
import SQLite3

class DBManager
{
        var db : OpaquePointer?  //0x0000000
        let path : String = "Document.EAguilarEcommerce.sqlite"
        
        init(){
            self.db = Get()
        }
        
     
        func Get() -> OpaquePointer?{
            let filePath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(path)
            if(sqlite3_open(filePath.path, &db) == SQLITE_OK){
                print("Conexion exitosa")
                print(filePath)
                return db
            }else{
                print("Fallo la conexión")
                return nil
            }
        }
    }
