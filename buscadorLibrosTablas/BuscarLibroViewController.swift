//
//  BuscarLibroViewController.swift
//  buscadorLibrosTablas
//
//  Created by Nicolas Roman Toro on 5/31/16.
//  Copyright © 2016 Nicolas Roman Toro. All rights reserved.
//

import UIKit

class BuscarLibroViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var textoISBN: UITextField!
    @IBOutlet weak var textoRespuesta: UILabel!
    @IBOutlet weak var textoTitulo: UILabel!
    @IBOutlet weak var textoAutores: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!

    // This value is either passed by `BuscarLibroTableViewController` in `prepareForSegue(_:sender:)` or constructed as part of adding a new libro.
    var libroNuevo: Libro?
    var textoDisplay: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        print("Cancelado: no se agregó un nuevo libro")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender === saveButton {
            let isbn = textoISBN.text ?? "ISBN de prueba"
            let titulo = textoTitulo.text ?? "Título de prueba"
            let autores = textoAutores.text ?? "Autores de prueba"
            
            // Guardar los valores en libroNuevo para pasar vía segue
            libroNuevo = Libro(i: isbn, t: titulo, a: autores)
            print("Libro nuevo agregado")
        }
    }
    
    // MARK: Actions
    func sincrono(isbn:String) {
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"+isbn
        let url = NSURL(string: urls)
        let datos: NSData? = NSData(contentsOfURL: url!)
        let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        textoDisplay = String(texto)
        
        // Consultar JSON para extraer Título, Autores, Portada
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)

            let dico1 = json as! NSDictionary
            if let dico2 = dico1["ISBN:"+textoISBN.text!] as! NSDictionary? {
                textoTitulo.text = dico2["title"] as! NSString as String
                if let dico3 = dico2["authors"] as! NSArray as Array? {
                    let dico4 = dico3[0] as! NSDictionary
                    textoAutores.text = dico4["name"] as! NSString as String
                }
            } else {
                print("Error: ISBN no encontrado, ingresalo nuevamente")
            }
            
            /*
            let dico5 = dico2["cover"] as! NSDictionary
            let urlImagenString = dico5["large"] as! NSString as String
            let imagenContenidaEnURL = UIImage(contentsOfFile: urlImagenString)
            
            portada.image = imagenContenidaEnURL
            */
        }
        catch {
        }
    }

    @IBAction func buscaISBN(sender: AnyObject) {
        // Realiza la búsqueda
        sincrono(textoISBN.text!)

        // Actualiza label
        textoRespuesta.text = textoDisplay

        // Almaceno datos en varibale Libro para pasarlo a TableView
        if let titulo = textoTitulo.text, autores = textoAutores.text, isbn = textoISBN.text {
            libroNuevo = Libro(i: isbn, t: titulo, a: autores)
        }
    }

}
