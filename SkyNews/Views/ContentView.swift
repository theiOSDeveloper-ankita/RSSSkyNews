//
//  ContentView.swift
//  SkyNews
//
//  Created by Ankita Jaiswal on 25/06/24.
//

import SwiftUI
import SWXMLHash

struct ContentView: View {
  @StateObject var networkManager = NetworkManager()

    var body: some View {
        VStack{
            if let url = URL(string: networkManager.imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50, alignment: .leading)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(networkManager.channelName)
                .font(.system(size: 30))
                .bold()
    
          List(networkManager.newsItems){ item in
                RSSItemView(rssItem: item)
            }
            .task {
                do{
                    try await networkManager.loadData()
                }
                catch{
                   print(error.localizedDescription)
                }
            }
        

        }
    }
}

#Preview {
    ContentView()
}

