//
//  ViewModel.swift
//  Perritos
//
//  Created by Marco Alonso Rodriguez on 03/11/22.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    var loader = AsyncThrowImage()
    
    func fetchImage() async {
        let image = try? await loader.loadImageWithAsycn()
        self.image = image
    }
    
    func fetchImageWithCompletion() {
        loader.getImageWithCompletion { [weak self] image, error in
            self?.image = image
        }
    }
}
