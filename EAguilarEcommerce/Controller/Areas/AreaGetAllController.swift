//
//  AreaGetAllController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 23/05/23.
//

import UIKit

class AreaGetAllController: UIViewController {
    
    var Areas : [Area] = []
    let dbManager = DBManager()
    
    var IdArea : Int = 0
    
    @IBOutlet weak var UICollectionController: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        UICollectionController.delegate = self
        UICollectionController.dataSource = self
        UICollectionController.register(UINib(nibName: "AreaCell", bundle: .main), forCellWithReuseIdentifier: "AreaCell")
        
        
        var result = AreaViewModel.GetAll()
        
        if result.Correct!
        {
            for objArea in result.Objects!
            {
            let area = objArea as! Area
                Areas.append(area)
            }
        }
    }
}

//MARK: Collection View

extension AreaGetAllController : UICollectionViewDataSource, UICollectionViewDelegate
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.Areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let item =
        collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCell
        item.lblNombre.text = Areas[indexPath.row].Nombre
        
        print("el index actual es \(indexPath.row)")
        item.imagenOutket.image = UIImage(named: Areas[indexPath.row].Nombre!)
        
        return item
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        IdArea = Areas[indexPath.row].IdArea!
        print(Areas[indexPath.row].IdArea!)
        
        self.IdArea = self.Areas[indexPath.row].IdArea!
        self.performSegue(withIdentifier: "AreaGetAllController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue , sender : Any?)
    {
        if segue.identifier == "AreaGetAllController"
        {
            let formControl = segue.destination as!  DepartamentoGetAllController
            formControl.IdArea  = self.IdArea
        }
    }
    
}
