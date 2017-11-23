//
//  ViewControllerPersonas.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 11/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit

class ViewControllerPersonas: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Personas"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindAgregarFotografiaFamilia(unwindSegue : UIStoryboardSegue)
    {
        
    }
    
    @IBAction func unwindAgregarFotografiaConocido(unwindSegue : UIStoryboardSegue)
    {
        
    }
}
