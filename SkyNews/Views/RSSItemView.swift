//
//  RSSItemView.swift
//  SkyNews
//
//  Created by Ankita Jaiswal on 17/07/24.
//

import SwiftUI

struct RSSItemView: View {
    @State var rssItem: RSSNewsItem
    var body: some View {
        VStack(alignment: .leading){
            if let url = URL(string: rssItem.imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }

            }
            Text(rssItem.title)
                .font(.headline)
            Text(rssItem.description)
                .font(.subheadline)
            Link("Read more", destination: URL(string: rssItem.link)!)
                .font(.body)
                .foregroundColor(.blue)
        }.padding(.bottom)
    }
}


#Preview {
    RSSItemView(rssItem: RSSNewsItem(title: "Julian Assange flies out of UK after being freed in US plea deal", description: "US authorities have agreed to drop their demand for Julian Assange to be extradited from the UK after reaching a plea deal with the WikiLeaks founder.", link: "https://news.sky.com/story/julian-assange-will-not-be-extradited-to-the-us-after-reaching-plea-deal-13158340", imageURL: "https://e3.365dm.com/24/06/1920x1080/skynews-julian-assange-leaving_6590205.jpg?20240625013342"))
}
