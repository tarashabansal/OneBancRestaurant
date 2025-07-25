//
//  CuisineCardView.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//


import SwiftUI

struct CuisineCardView: View {
    let cuisine: Cuisine

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RemoteImage(urlString: cuisine.cuisine_image_url)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)
                .frame(maxWidth: .infinity, maxHeight: 180)
                .padding(.horizontal,10)

            Text(cuisine.cuisine_name)
                .foregroundColor(.white)
                .bold()
                .offset(x:20, y: -10)
        }
        .frame(width: 400, height: 200)
        .padding(.horizontal,20)
    }
}

#Preview {
    CuisineCardView(cuisine:Cuisine(cuisine_id: "475674",
                                    cuisine_name: "North Indian",
                                    cuisine_image_url:"https://uat-static.onebanc.ai/picture/ob_cuisine_chinese.webp",items: []))
}
