//
//  ViewControllerVerAlbumFamiliar.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 12/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class ViewControllerVerAlbumFamiliar: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ProtocoloRecargaVista {
    
    var Nombre = [String]()
    var Relacion = [String]()
    var Fecha = [Date]()
    var Comentarios = [String]()
    var Imagenes = [NSData]()
    
    var nombreDelAlbum : String!
    
    @IBOutlet weak var imagenesDelAlbumFamiliar: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = nombreDelAlbum
        
        queryImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "agregarFotografia"
        {
            let vistaAgregarFotografia = segue.destination as! ViewControllerAgregarFotografiaAAlbumFamiliar
            
            vistaAgregarFotografia.nombreParaElAlbum = nombreDelAlbum
            vistaAgregarFotografia.delegado = self
        }
        else if segue.identifier == "mostrarFotografia"
        {
            //let cell = sender as! UICollectionViewCell
            //let indexPath = self.collectionView?.indexPath(for: cell)
            let indexPath = imagenesDelAlbumFamiliar.indexPathsForSelectedItems![0]
            
            //let cell = collectionView(imagenesDelAlbumFamiliar, cellForItemAt: imagenesDelAlbumFamiliar.indexPath(for: imagenesDelAlbumFamiliar))
            
            let vistaVerDetalle = segue.destination as! ViewControllerVerFotografiaDeAlbum
            vistaVerDetalle.Nombre      = Nombre        [indexPath.row]
            vistaVerDetalle.Relacion    = Relacion      [indexPath.row]
            vistaVerDetalle.Fecha       = Fecha         [indexPath.row]
            vistaVerDetalle.Comentarios = Comentarios   [indexPath.row]
            vistaVerDetalle.Imagen      = Imagenes      [indexPath.row]
            vistaVerDetalle.delegado = self
        }
    }
    
    
    
    @IBAction func unwindAgregarFotografiaParaAlbumFamiliar(unwindSegue : UIStoryboardSegue)
    {
        Nombre.removeAll()
        Relacion.removeAll()
        Fecha.removeAll()
        Comentarios.removeAll()
        Imagenes.removeAll()
        
        queryImages()
        imagenesDelAlbumFamiliar.reloadData()
        //imagenesDelAlbumFamiliar.reloadInputViews()
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Nombre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCellFotografiaDeUnAlbumFamiliar
        
        cell.displayContent(imagen2: UIImage(data:Imagenes[indexPath.row] as Data, scale: 1.0)!)
        
        return cell
        
    }
    
    func queryImages(){
        let realm = try! Realm()
        
        let allImages = realm.objects(FotografiaFamiliaDeUnAlbum.self).filter("albumPerteneciente == %@", nombreDelAlbum)
        
        for memory in allImages{
            
            Nombre.append(memory.nombreCompleto)
            Relacion.append(memory.relacion)
            Fecha.append(memory.birthday)
            Comentarios.append(memory.informacionAdicional)
            Imagenes.append(memory.imagen)
            
            //tableView.reloadData()
            //collectionView ?.reloadData()
            
        }
    }
    
    func recargaVista()
    {
        Nombre.removeAll()
        Relacion.removeAll()
        Fecha.removeAll()
        Comentarios.removeAll()
        Imagenes.removeAll()
        
        queryImages()
        imagenesDelAlbumFamiliar.reloadData()
    }
}
