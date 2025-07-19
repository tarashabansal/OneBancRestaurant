//
//  RemoteImage.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//


import SwiftUI

struct RemoteImage: View {
    let urlString: String
    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Color.gray.opacity(0.1) // Placeholder if image is not available
            }
        }
        .onAppear {
            //retriving image from URL and creating it into an Image in UI
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        image = uiImage
                    }
                }
            }.resume()
        }
    }
}

//testing
#Preview {
    RemoteImage(urlString: "https://uat-static.onebanc.ai/picture/ob_dish_spring_rolls.webp")
    
}
