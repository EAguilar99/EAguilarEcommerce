//
//  AreasController.swift
//  EAguilarEcommerce
//
//  Created by MacBookMBA17 on 23/05/23.
//

import UIKit

class AreasGetAllController: UIViewController {
    
    @IBOutlet weak var CollectionControllerOutlet: UICollectionView!
    
    var Areas : [Area] = []
    let dbManager = DBManager()
    
    var IdArea : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionControllerOutlet.delegate = self
        CollectionControllerOutlet.dataSource = self
        CollectionControllerOutlet.register(UINib(nibName: "AreaCell", bundle: .main), forCellWithReuseIdentifier: "AreaCell")
        
        var result = AreaViewModel.GetAll()
        
        if result.Correct!
        {
            for ObjArea in result.Objects!
            {
                let area = ObjArea as! Area
                Areas.append(area)
            }
        }        // Do any additional setup after loading the view.
    }
}


//MARK: Collection View

extension AreasGetAllController : UICollectionViewDataSource, UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.Areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //registrar la colleccion personalizada
        
        let item =
        collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCell
        
        item.lblNombreOutlet.text = Areas[indexPath.row].Nombre
        
        //UIImage.image = UIImage(named: Departamentos)
        
        print("El index actual es \(indexPath.row)")
        return item
        
    }
    
    
}

