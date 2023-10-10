//
//  ImageLoader.swift
//  NewsApp
//
//  Created by narfk on 05/10/2023.
//

import SwiftUI

/// Un gestionnaire d'images distant qui télécharge une image à partir d'une URL donnée.
struct RemoteImage: View {
    @ObservedObject var imageLoader: ImageLoader
    
    /// Initialise la vue avec l'URL de l'image à charger.
    ///
    /// - Parameter url: L'URL de l'image distante.
    init(url: String) {
        self.imageLoader = ImageLoader(urlString: url)
    }
    
    var body: some View {
        Image(uiImage: UIImage(data: imageLoader.data) ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

/// Un gestionnaire d'images distant qui télécharge les données de l'image à partir de l'URL donnée.
class ImageLoader: ObservableObject {
    @Published var data = Data()
    
    /// Initialise le gestionnaire d'images avec l'URL de l'image à télécharger.
    ///
    /// - Parameter urlString: L'URL de l'image distante.
    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }.resume()
    }
}
