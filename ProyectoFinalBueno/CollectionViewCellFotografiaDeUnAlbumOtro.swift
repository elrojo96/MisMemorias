//
//  CollectionViewCellFotografiaDeUnAlbumOtro.swift
//  ProyectoFinalBueno
//
//  Created by Luis Alfonso Rojo Sánchez on 16/11/17.
//  Copyright © 2017 ITESM. All rights reserved.
//

import UIKit

class CollectionViewCellFotografiaDeUnAlbumOtro: UICollectionViewCell
{
    @IBOutlet weak var imagen: UIImageView!
    
    func displayContent(imagen2: UIImage)
    {
        imagen.image = imagen2
    }
}
