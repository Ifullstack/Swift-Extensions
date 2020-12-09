//
//  ImageLoader.swift
//  recipe-app
//
//  Created by Cane on 28/08/2020.
//

import Foundation
import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data,Never>()
    
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    
    init(imageUrl:String) {
        guard let url = URL(string:imageUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
    
}

struct ImageView:View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(imageUrl:String) {
        imageLoader = ImageLoader(imageUrl: imageUrl)
    }
    
    var body:some View {
        Image(uiImage: ((( imageLoader.data.count == 0 ) ? UIImage( systemName: "photo.fill" ): UIImage( data: imageLoader.data ))!)).resizable()
    }
    
}
