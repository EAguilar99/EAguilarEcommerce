//
//  GetAllUsuarioController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 03/05/23.
//

import UIKit
import SwipeCellKit

//tabla
class GetAllUsuarioController: UITableViewController {
    
    var usuarios : [Usuario] = []
    let dbManager = DBManager()
    var IdUsuario : Int = 0
    var IdRol : Int  = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "UsuarioCell", bundle: .main)
        
        tableView.register(nib , forCellReuseIdentifier: "UsuarioCell")
        
        var result = UsuarioViewModel.GetAll()
        
        if result.Correct!
        {
            //tableView.reloadData()
            for ObjUsuario in result.Objects!
            {
                let usuario = ObjUsuario as! Usuario
                usuarios.append(usuario)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioCell
        
        cell.delegate = self
        // Configure the cell...
        
        cell.txtNombre?.text = usuarios[indexPath.row].Nombre
        cell.txtApellidoPaterno?.text = usuarios[indexPath.row].ApellidoPaterno
        cell.txtApellidoMaterno?.text = usuarios[indexPath.row].ApellidoMaterno
        cell.txtUserName?.text = usuarios[indexPath.row].Username
        cell.txtFechaNacimiento?.text = usuarios[indexPath.row].FechaNacimiento
        cell.txtRol?.text = usuarios[indexPath.row].Rol?.Nombre
        
        print("el index actual es \(indexPath.row)")
        // cell.textLabel?.text = usuarios[indexPath.row].Nombre
        
        return cell
    }
}

//MARK: implementacion de swipe

extension GetAllUsuarioController : SwipeTableViewCellDelegate{
    
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
                
                let result  = UsuarioViewModel.Delete(idUsuario: self.usuarios[indexPath.row].IdUsuario!)
                
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
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.IdUsuario = self.usuarios[indexPath.row].IdUsuario!
                self.performSegue(withIdentifier: "FormController", sender: self)
                
                
                print("Se ejecuto la funcion de update")
                //CODIGO A EJECUTAR
                //
            }
            return [updateAction]
        }
        return nil
    }
    
    
    
    func updateUI()
    {
        var result = UsuarioViewModel.GetAll()
        usuarios.removeAll()
        if result.Correct!
        {
            for objUsuario in result.Objects!
            {
                let usuario = objUsuario as! Usuario
                usuarios.append(usuario)
            }
            tableView?.reloadData()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue , sender : Any?)
    {
        if segue.identifier == "FormController"
        {
            let formControl = segue.destination as!  FormController
            formControl.IdUsuario  = self.IdUsuario
        }
        
        if segue.identifier == "FormController"
        {
            let formControl = segue.destination as!  FormController
            formControl.IdRol  = self.IdRol
        }
        
    }
    
}


