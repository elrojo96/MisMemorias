//
//  FotografiaConocido.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 11/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import Foundation
import RealmSwift

class FotografiaConocido : Object
{
    @objc dynamic var imagen = NSData()
    @objc dynamic var nombreCompleto = ""
    @objc dynamic var birthday = Date()
    @objc dynamic var informacionAdicional = ""
    @objc dynamic var relacion = ""
    //@objc dynamic var notaDeVoz
}

