//
//  RolController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 09/05/23.
//

import UIKit
import SwipeCellKit

//MARK: MAIN
class RolGetAllController: UIViewController
{
    
    var Roles : [Rol] = []
    let dbManager = DBManager()
    
    var IdRol : Int = 0
    
    @IBOutlet weak var RolTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        RolTableView.delegate = self
        RolTableView.dataSource = self
        RolTableView.register(UINib(nibName: "RolCell" , bundle: .main), forCellReuseIdentifier: "RolCell")//permite usar los tres protoclos row of section , section
        
        
        
        
        var result = RolViewModel.Getall()
        
        if result.Correct!
        {
            for ObjRol in result.Objects!
            {
                let rol = ObjRol as! Rol
                Roles.append(rol)
            }
        }
        

        // Do any additional setup after loading the view.
    }
}

//MARK: Table view
extension RolGetAllController : UITableViewDataSource, UITableViewDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
           1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.Roles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //registrar la celda perzonalizada con el register co  el identificador
        
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "RolCell", for: indexPath) as! RolCell
        
        cell.delegate = self
        cell.NombreRolOutlet?.text = Roles[indexPath.row].Nombre
        
        print("el index actual es \(indexPath.row)")
        
        return cell
    }
    
    
    
    
}


//MARK: Cell swipecell
extension RolGetAllController : SwipeTableViewCellDelegate
{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]?
    {
        if orientation == .right
        {
            let deleteAction = SwipeAction(style: .destructive, title: "Delete")
            {
                action, indexPath in print(indexPath.row)
                
                print ("se ejecuto la funcion de borrar")
                
                let result = RolViewModel.Delete(idRol: self.Roles[indexPath.row].IdRol!)
                
                if result.Correct!
                {
                    self.updateUI()
                }
                
            }
            
            return [deleteAction]
        }
        if orientation == .left
        {
            let updateAction = SwipeAction(style: .default, title: "Update"){action, indexPath in
                
                self.IdRol = self.Roles[indexPath.row].IdRol!
                self.performSegue(withIdentifier: "RolFormController", sender: self)
                
                print("se ejucto la funcion de update")
            }
            return[updateAction]
        }
        return nil
    }
    
    func updateUI()
    {
        var result = RolViewModel.Getall()
        Roles.removeAll()
        if result.Correct!
        {
            for objRol in result.Objects!
            {
                let rol = objRol as! Rol
                Roles.append(rol)
            }
            //tableView?.reloadData()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue , sender : Any?)
    {
        if segue.identifier == "RolFormController"
        {
            let formControl = segue.destination as!  RolFormController
            formControl.IdRol  = self.IdRol
        }
        
    }
    
    
    
}
