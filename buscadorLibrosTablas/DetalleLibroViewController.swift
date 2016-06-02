//
//  DetalleLibroViewController.swift
//  buscadorLibrosTablas
//
//  Created by Nicolas Roman Toro on 6/1/16.
//  Copyright © 2016 Nicolas Roman Toro. All rights reserved.
//

import UIKit

class DetalleLibroViewController: UIViewController {
    
    var libroDetalle: Libro?

    @IBOutlet weak var tituloLibroDetalle: UILabel!
    @IBOutlet weak var isbnLibroDetalle: UILabel!
    @IBOutlet weak var autoresLibroDetalle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let titulo = libroDetalle?.titulo, autores = libroDetalle?.autores, isbn = libroDetalle?.isbn {
            tituloLibroDetalle.text = titulo
            isbnLibroDetalle.text = isbn
            autoresLibroDetalle.text = autores
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
