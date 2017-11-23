//
//  CollectionViewControllerFotografiasFamilia.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 11/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class CollectionViewControllerFotografiasFamilia: UICollectionViewController, ProtocoloRecargaVista {
    
    var Nombre = [String]()
    var Relacion = [String]()
    var Fecha = [Date]()
    var Comentarios = [String]()
    var Imagenes = [NSData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        self.title = "Mi familia"
        
        queryImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Nombre.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCellFotografiaDeLaGaleria
        
        // Configure the cell
        //cell.imagen.image = UIImage(data:Imagenes[indexPath.row] as Data, scale: 1.0)
        
        cell.displayContent(imagen2: UIImage(data:Imagenes[indexPath.row] as Data, scale: 1.0)!)
        
        return cell
        
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func queryImages(){
        let realm = try! Realm()
        
        let allImages = realm.objects(FotografiaFamilia.self)
        
        for memory in allImages{
            
            Nombre.append(memory.nombreCompleto)
            Relacion.append(memory.relacion)
            Fecha.append(memory.birthday)
            Comentarios.append(memory.informacionAdicional)
            Imagenes.append(memory.imagen)
            
            //tableView.reloadData()
            collectionView?.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "mostrarFotografiaFamiliar") {
            
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView?.indexPath(for: cell)
            
            
            
            let vistaVerDetalle = segue.destination as! ViewControllerVerFotografiaFamilia
            vistaVerDetalle.Nombre      = Nombre        [indexPath!.row]
            vistaVerDetalle.Relacion    = Relacion      [indexPath!.row]
            vistaVerDetalle.Fecha       = Fecha         [indexPath!.row]
            vistaVerDetalle.Comentarios = Comentarios   [indexPath!.row]
            vistaVerDetalle.Imagen      = Imagenes      [indexPath!.row]
            vistaVerDetalle.delegado = self
        }
        
    }
    
    func recargaVista() {
        Nombre.removeAll()
        Relacion.removeAll()
        Fecha.removeAll()
        Comentarios.removeAll()
        Imagenes.removeAll()
        
        queryImages()
        self.collectionView?.reloadData()
    }
}
