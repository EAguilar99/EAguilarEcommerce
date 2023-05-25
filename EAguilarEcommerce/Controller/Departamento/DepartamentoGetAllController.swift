//
//  DepartamentoGetAllController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 24/05/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class DepartamentoGetAllController: UICollectionViewController {

    
    var Departamentos : [Departamento] = []
    let dbManager = DBManager()

    var IdDepartamento : Int = 0
    var IdArea : Int = 0
    var IdProducto : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "AreaCell", bundle: .main)
        
        collectionView.register(nib , forCellWithReuseIdentifier: "AreaCell")
        
       var result = DepartamentoViewModel.GetById(idArea: IdArea)
       
        if result.Correct!
        {
            for ObjDepartamento in result.Objects!
            {
                let departamento = ObjDepartamento as! Departamento
                Departamentos.append(departamento)
            }
        }

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    // MARK: - Navigation

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.Departamentos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        //registrar la colleccion personalizada
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCell
        
        item.lblNombre.text = Departamentos[indexPath.row].Nombre
        
        
        item.imagenOutket.image = UIImage(named: Departamentos[indexPath.row].Nombre!)
        
        print("El index actual es \(indexPath.row)")
        return item
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        IdDepartamento = Departamentos[indexPath.row].IdDepartamento!
        print(Departamentos[indexPath.row].IdDepartamento!)
        
        self.IdDepartamento = self.Departamentos[indexPath.row].IdDepartamento!
        self.performSegue(withIdentifier: "DepartamentoGetAllController", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "DepartamentoGetAllController"
        {
            let formControl = segue.destination as! ProductoCollectionController
            formControl.IdDepartamento = self.IdDepartamento
        }
    }
    
    
}
