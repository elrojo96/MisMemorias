//
//  ViewControllerJuegoPantallaIntermedia.swift
//  ProyectoFinalBueno
//
//  Created by David Souza on 11/17/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit
import RealmSwift

struct question
{
    var question : String!
    //var Answers = [String]()
    var Answer : Int!
}

class ViewControllerJuegoPantallaIntermedia: UIViewController {
    
    @IBOutlet weak var btImagen1: UIButton!
    @IBOutlet weak var btImagen2: UIButton!
    @IBOutlet weak var btImagen3: UIButton!
    @IBOutlet weak var btImagen4: UIButton!
    
    @IBOutlet weak var lbPreguntaDelJuego: UILabel!
    @IBOutlet weak var lbRespuestaCorrecta: UILabel!
    @IBOutlet weak var lbRespuestaIncorrecta: UILabel!
    
    var Nombres  = [String]()
    var Imagenes = [NSData]()
    var Albumes  = [String]()
    
    var preguntas = [question]()
    var numeroDeLaPregunta : Int!
    var numeroDeLaRespuesta : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Juego"
        
        lbRespuestaCorrecta.isHidden = true
        lbRespuestaIncorrecta.isHidden = true
        
        obtenerImagenes()
        cargarImagenesEnElJuego()
        hacerPreguntasRespuesta()
        
        juego()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func obtenerImagenes()
    {
        let realm = try! Realm()
        //--
        let fotografiasDeTodosLosFamiliares = realm.objects(FotografiaFamilia.self)
        let random1 = fotografiasDeTodosLosFamiliares[Int(arc4random_uniform(UInt32(fotografiasDeTodosLosFamiliares.count)))]
        Nombres.append(random1.nombreCompleto)
        Imagenes.append(random1.imagen)
        //--
        let fotografiasDeTodosLosConocidos = realm.objects(FotografiaConocido.self)
        let random2 = fotografiasDeTodosLosConocidos[Int(arc4random_uniform(UInt32(fotografiasDeTodosLosConocidos.count)))]
        Nombres.append(random2.nombreCompleto)
        Imagenes.append(random2.imagen)
        //--
        let fotografiasDeTodosLosAlbumes1 = realm.objects(FotografiaFamiliaDeUnAlbum.self)
        let random3 = fotografiasDeTodosLosAlbumes1[Int(arc4random_uniform(UInt32(fotografiasDeTodosLosAlbumes1.count)))]
        Nombres.append(random3.nombreCompleto)
        Imagenes.append(random3.imagen)
        Albumes.append(random3.albumPerteneciente)
        //--
        let fotografiasDeTodosLosAlbumes2 = realm.objects(FotografiaOtroDeUnAlbum.self)
        let random4 = fotografiasDeTodosLosAlbumes2[Int(arc4random_uniform(UInt32(fotografiasDeTodosLosAlbumes2.count)))]
        Nombres.append(random4.nombreCompleto)
        Imagenes.append(random4.imagen)
        Albumes.append(random4.albumPerteneciente)
        
        //let size1 = Nombres.count
        //let size2 = Imagenes.count
        //let size3 = Albumes.count
        
        //print(size1)
        //print(size2)
        //print(size3)
    }
    
    func cargarImagenesEnElJuego()
    {
        //btImagen1.setImage(UIImage(data: Imagenes[0] as Data, scale: 1.0), for: UIControlState())
        //btImagen2.setImage(UIImage(data: Imagenes[1] as Data, scale: 1.0), for: UIControlState())
        //btImagen3.setImage(UIImage(data: Imagenes[2] as Data, scale: 1.0), for: UIControlState())
        //btImagen4.setImage(UIImage(data: Imagenes[3] as Data, scale: 1.0), for: UIControlState())
        
        btImagen1.setBackgroundImage(UIImage(data: Imagenes[0] as Data, scale: 1.0), for: UIControlState())
        btImagen2.setBackgroundImage(UIImage(data: Imagenes[1] as Data, scale: 1.0), for: UIControlState())
        btImagen3.setBackgroundImage(UIImage(data: Imagenes[2] as Data, scale: 1.0), for: UIControlState())
        btImagen4.setBackgroundImage(UIImage(data: Imagenes[3] as Data, scale: 1.0), for: UIControlState())
    }
    
    func hacerPreguntasRespuesta()
    {
        preguntas =
            [
                question(question: "¿Quien es \(Nombres[0])?", Answer: 1),
                question(question: "¿Quien es \(Nombres[1])?", Answer: 2),
                question(question: "¿Cual es la fotografía de \(Nombres[2]) en \(Albumes[0])?", Answer: 3),
                question(question: "¿Cual es la fotografía de \(Nombres[3]) en \(Albumes[1])?", Answer: 4)
        ]
        
        print(preguntas)
    }
    
    func juego()
    {
        numeroDeLaPregunta = 1
        numeroDeLaRespuesta = 1
        lbPreguntaDelJuego.text = preguntas[0].question
    }
    
    
    @IBAction func boton1Presionado(_ sender: UIButton)
    {
        if numeroDeLaPregunta == 1
        {
            lbRespuestaCorrecta.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75)
            {
                self.lbRespuestaCorrecta.isHidden = true
            }
            /*
             //===========================
             obtenerImagenes()
             cargarImagenesEnElJuego()
             hacerPreguntasRespuesta()
             //===========================
             */
            numeroDeLaPregunta = 2
            numeroDeLaRespuesta = 2
            lbPreguntaDelJuego.text = preguntas[1].question
            
        }
        else
        {
            lbRespuestaIncorrecta.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75)
            {
                self.lbRespuestaIncorrecta.isHidden = true
            }
        }
    }
    
    @IBAction func boton2Presionado(_ sender: UIButton)
    {
        if numeroDeLaPregunta == 2
        {
            lbRespuestaCorrecta.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75)
            {
                self.lbRespuestaCorrecta.isHidden = true
            }
            /*
             //===========================
             obtenerImagenes()
             cargarImagenesEnElJuego()
             hacerPreguntasRespuesta()
             //===========================
             */
            numeroDeLaPregunta = 3
            numeroDeLaRespuesta = 3
            lbPreguntaDelJuego.text = preguntas[2].question
        }
        else
        {
            lbRespuestaIncorrecta.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75)
            {
                self.lbRespuestaIncorrecta.isHidden = true
            }
        }
    }
    
    @IBAction func boton3Presionado(_ sender: UIButton)
    {
        if numeroDeLaPregunta == 3
        {
            lbRespuestaCorrecta.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75)
            {
                self.lbRespuestaCorrecta.isHidden = true
            }
            /*
             //===========================
             obtenerImagenes()
             cargarImagenesEnElJuego()
             hacerPreguntasRespuesta()
             //===========================
             */
            numeroDeLaPregunta = 4
            numeroDeLaRespuesta = 4
            lbPreguntaDelJuego.text = preguntas[3].question
        }
        else
        {
            lbRespuestaIncorrecta.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75)
            {
                self.lbRespuestaIncorrecta.isHidden = true
            }
        }
    }
    
    @IBAction func boton4Presionado(_ sender: UIButton)
    {
        if numeroDeLaPregunta == 4
        {
            lbRespuestaCorrecta.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75)
            {
                self.lbRespuestaCorrecta.isHidden = true
            }
            
            //  Mostrar alerta de que ha ganado el juego
            
            let alertController = UIAlertController(title: "¡Felicidades!", message: "Haz ganado el juego.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Cerrar", style: .default, handler:{ action in
                self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            //self.dismiss(animated: true, completion: nil)
            
            /*
             DispatchQueue.main.asyncAfter(deadline: .now() + 1)
             {
             self.navigationController?.popViewController(animated: true)
             }
             */
            
            //self.navigationController!.popToRootViewController(animated: true)
            
            //Sacar al usuario del juego
            //performSegue(withIdentifier: "juegoFinalizado", sender: nil)
        }
        else
        {
            lbRespuestaIncorrecta.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75)
            {
                self.lbRespuestaIncorrecta.isHidden = true
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
