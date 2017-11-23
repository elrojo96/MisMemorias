//
//  ViewController.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 11/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var titular = Persona()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Memorias"
        
        obtenerUltimaPersona()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func obtenerUltimaPersona()
    {
        let realm = try! Realm()
        
        let allTitulares = realm.objects(Persona.self)
        
        var contador = 0
        
        for person in allTitulares
        {
            contador = contador + 1
        }
        
        if(contador > 0){
            titular.imagen = allTitulares[contador - 1].imagen
        }
        
    }
    
    @IBAction func unwindToDestinationViewController (sender: UIStoryboardSegue){
        obtenerUltimaPersona()
    }
    
    /*
     func maskRoundedImage(image: UIImage, radius: CGFloat) -> UIImage {
     let imageView: UIImageView = UIImageView(image: image)
     var layer: CALayer = CALayer()
     layer = imageView.layer
     layer.masksToBounds = true
     layer.cornerRadius = radius
     UIGraphicsBeginImageContext(imageView.bounds.size)
     layer.render(in: UIGraphicsGetCurrentContext()!)
     let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     return roundedImage!
     }image.frame.size.width / 2.0
    */
}
