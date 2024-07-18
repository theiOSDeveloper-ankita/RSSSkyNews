//
//  NetworkManager.swift
//  SkyNews
//
//  Created by Ankita Jaiswal on 25/06/24.
//

import Foundation
import SWXMLHash

@MainActor
class NetworkManager: ObservableObject{
    @Published var channelName: String = ""
    @Published  var channelURL: String = ""
    @Published  var imageURL: String = ""
    @Published  var newsItems: [RSSNewsItem] = []
    
    func loadData() async throws{
        // This URL is received on the click of "UK" section in the URL ("https://news.sky.com/info/rss") mentioned in the problem statement
         let newsUrl = "https://feeds.skynews.com/feeds/rss/uk.xml"
        guard let url = URL(string: newsUrl)
        else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        print(urlRequest)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching xml data")}
        
        let feed = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
                let xml = XMLHash.parse(feed)

                self.channelName = xml["rss"]["channel"]["title"].element!.text
                self.channelURL = xml["rss"]["channel"]["link"].element!.text
                self.imageURL = xml["rss"]["channel"]["image"]["url"].element!.text

                for item in xml["rss"]["channel"]["item"].all
                {
                    let title = item["title"].element?.text ?? ""
                    let description = item["description"].element?.text ?? ""
                    let link = item["link"].element?.text ?? ""
                    let imageURL = item["media:thumbnail"].element?.attribute(by: "url")?.text ?? ""
                    
                    let rssNewsItem = RSSNewsItem(title: title, description: description, link: link, imageURL: imageURL)
                    newsItems.append(rssNewsItem)
                    
                }

    }
    
}


