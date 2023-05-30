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
            
            let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.EAguilarEcommerce")!.appendingPathComponent(path)
            
            //let filePath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(path)
            
            if(sqlite3_open(storeURL.path, &db) == SQLITE_OK){
                print("Conexion exitosa")
                print(storeURL)
                return db
            }else{
                print("Fallo la conexión")
                return nil
            }
        }
    }
