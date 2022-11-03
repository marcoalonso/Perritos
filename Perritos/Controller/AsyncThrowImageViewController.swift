//
//  AsyncThrowImageViewController.swift
//  Perritos
//
//  Created by Marco Alonso Rodriguez on 03/11/22.
//

import UIKit

class AsyncThrowImage {
    var image: UIImage? = nil
    let url = URL(string: "https://picsum.photos/200/300")!
    
    //recive a data and response and return a UIImage?
    func responseHandler(data: Data?, response: URLResponse?) -> UIImage? {
        //Unwrap data, and create image
        guard let data = data,
              let image = UIImage(data: data),
              let response = response else { return nil }
        return image
    }
    
    func loadImageWithAsycn() async throws -> UIImage? {
        do{
            //try to create data and response
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return responseHandler(data: data, response: response)
        } catch {
            throw error
        }
    }
    
    //Here is another way to call API by completion
    func getImageWithCompletion(completionHandler: @escaping(_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  let _ = response else { return }
            completionHandler(image, nil)
        }
        .resume()
    }
}

class AsyncThrowImageViewController: UIViewController {
    
    @IBOutlet weak var imageAsync: UIImageView!
    var vm = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.- Option with escaping closure
        //        vm.fetchImageWithCompletion()
        //        imageAsync.image = vm.image
        
        //2.- Option with async await
        Task {
            await vm.fetchImage()
            imageAsync.image = vm.image
        }
        
    }
    
    @IBAction func getImageButton(_ sender: UIButton) {
        //1.- Option with escaping closure
        //        vm.fetchImageWithCompletion()
        //        imageAsync.image = vm.image
        
        //2.- Option with async await
        Task {
            await vm.fetchImage()
            imageAsync.image = vm.image
        }
    }
    
    
}
