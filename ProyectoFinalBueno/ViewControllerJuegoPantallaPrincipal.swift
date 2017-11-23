//
//  ViewControllerJuegoPantallaPrincipal.swift
//  ProyectoFinalBueno
//
//  Created by David Souza on 11/17/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerJuegoPantallaPrincipal: UIViewController {
    
    var fotografias1 = [String]()
    var fotografias2 = [String]()
    var fotografias3 = [String]()
    var fotografias4 = [String]()
    
    var dejarJugar = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Inicio del juego"
        
        cuentaElementos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if dejarJugar == true {
            let vistaJuego = segue.destination as! ViewControllerJuegoPantallaIntermedia
        }
        else
        {
            let alertController = UIAlertController(title: "Imágenes faltantes", message: "Agrega más fotografías a tus memorias, mínimo una imagen de cada tipo.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Cerrar", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func cuentaElementos()
    {
        /*
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
         */
        
        let realm = try! Realm()
        
        let allImages1 = realm.objects(FotografiaFamilia.self)
        let allImages2 = realm.objects(FotografiaConocido.self)
        let allImages3 = realm.objects(FotografiaFamiliaDeUnAlbum.self)
        let allImages4 = realm.objects(FotografiaOtroDeUnAlbum.self)
        
        for imagen1 in allImages1 { fotografias1.append(imagen1.nombreCompleto) }
        for imagen2 in allImages2 { fotografias2.append(imagen2.nombreCompleto) }
        for imagen3 in allImages3 { fotografias3.append(imagen3.nombreCompleto) }
        for imagen4 in allImages4 { fotografias4.append(imagen4.nombreCompleto) }
        
        let size1 = fotografias1.count
        let size2 = fotografias2.count
        let size3 = fotografias3.count
        let size4 = fotografias4.count
        
        //print(size1)
        //print(size2)
        //print(size3)
        //print(size4)
        
        if(
            size1 >= 1 &&
                size2 >= 1 &&
                size3 >= 1 &&
                size4 >= 1
            )
        {
            dejarJugar = true
        }
    }
}
