//
//  AsyncImageView.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import SwiftUI

struct AsyncImageView: View {
    let photoReference: String?
    let apiKey: String

    var body: some View {
        if let photoRef = photoReference,
           let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=100&photoreference=\(photoRef)&key=\(apiKey)") {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable().scaledToFit()
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    Image(systemName: "photo")
                }
            }
        } else {
            Image(systemName: "photo")
        }
    }
}


#if DEBUG
struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(photoReference: "mockPhoto", apiKey: "mockAPIKey")
            .frame(width: 60, height: 60)
    }
}
#endif
