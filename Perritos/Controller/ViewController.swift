//
//  ViewController.swift
//  Perritos
//
//  Created by Marco Alonso Rodriguez on 29/10/22.
//

import UIKit


@MainActor
class ViewController: UIViewController {

    
    @IBOutlet weak var ImagenPerro: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://i.pinimg.com/736x/f9/cd/f9/f9cdf9807c6e607bf3a2c171825cb85a.jpg"
        let url = URL(string: urlString)
        
        DispatchQueue.main.async {
            let dataPerro = try? Data(contentsOf: url!)
            self.ImagenPerro.image = UIImage(data: dataPerro!)
        }
    }

    @IBAction func verMasButton(_ sender: UIButton) {
        buscarPerritos()
    }
    
    func buscarPerritos(){
        let urlString = "https://dog.ceo/api/breeds/image/random"
        
        if let url = URL(string: urlString) {
            if let dataJSON = try? Data(contentsOf: url) {
                if let imagenURLString = parseJSON(data: dataJSON){
                    //parseJSON me va a devolver la url a consultar para cambiar la imagen
                    //Crear un obj de tipo data
                    print("Debug: \(imagenURLString.message)")
                    if let urlPerrito = URL(string: imagenURLString.message){
                        if let dataPerro = try? Data(contentsOf: urlPerrito){
                            //Crear una UIImage a partir de una data
                            ImagenPerro.image = UIImage(data: dataPerro)
                        }
                    }
                }
            }
        } else {
            print("URL no válida")
        }
    }
    
    func parseJSON(data: Data) -> PerritoModel? {
        let decoder = JSONDecoder()
        if let datosDecodificados = try? decoder.decode(PerritoModel.self, from: data) {
            return datosDecodificados
        }
        return nil
    }
}

