//
//  ViewController.swift
//  OpenLibrary
//
//  Created by Paco on 7/5/16.
//  Copyright © 2016 Simied. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var titulo: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buscador(sender: AnyObject) {
        
        do {
            var urlText = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
            urlText += sender.text!
            let url = NSURL(string: urlText)
            let datos = NSData(contentsOfURL: url!)
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
            
            if ( datos!.length < 3 ){
                let alerta = UIAlertController(title: "Error",
                                               message: "ISBN no encontrado",
                                               preferredStyle: UIAlertControllerStyle.Alert)
                let accion = UIAlertAction(title: "Cerrar",
                                           style: UIAlertActionStyle.Default) { _ in
                                            alerta.dismissViewControllerAnimated(true, completion: nil) }
                alerta.addAction(accion)
                self.presentViewController(alerta, animated: true, completion: nil)
            }else{
                var Head = "ISBN:"
                Head += sender.text!
                titulo.text = json[Head]!["title"] as! String
                let keys = json[Head]! as! NSDictionary
                let Todosautores = keys["authors"] as! NSArray
                var names : String = " "
                for value in Todosautores{
                    var Autor = value as! NSDictionary
                    var Name = Autor["name"] as! String
                    names += Name
                    names += ","
                    
                }
                autor.text = names
                
            }
            
            
            
        } catch {
            print("json error: \(error)")
        }
    }
}

