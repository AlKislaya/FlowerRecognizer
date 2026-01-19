//
//  WikiArticleService.swift
//  FlowerRecognizer
//
//  Created by Alexandra on 19.01.26.
//

import Foundation

class WikiArticleService {
    public func fetchArticle(title: String) async throws -> (String?, (any Error)?) {
        let url = try formUrl(with: title)
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            return (nil, getNSError(with: httpResponse))
        }
        
        let result = try parseJson(with: data)
        return (result?.extract, nil)
    }
}

extension WikiArticleService {
    struct ResponseJson: Decodable {
        let query: Query
        
        struct Query: Decodable {
            let pages: [String: Page]
            
            struct Page: Decodable {
                let extract: String
            }
        }
    }
    
    private func parseJson(with data: Data) throws -> ResponseJson.Query.Page? {
        let decoder = JSONDecoder()
        let result = try decoder.decode(ResponseJson.self, from: data)
        return result.query.pages.first?.value
    }
}

extension WikiArticleService {
    static let urlEndPoint = "https://en.wikipedia.org/w/api.php"
    static let urlConfigurationsQuery = [URLQueryItem(name: "action", value: "query"),
                                         URLQueryItem(name: "prop", value: "extracts"),
                                         URLQueryItem(name: "exintro", value: String(true)),
                                         URLQueryItem(name: "explaintext", value: String(true)),
                                         URLQueryItem(name: "redirects", value: "1"),
                                         URLQueryItem(name: "format", value: "json")]
    
    private func getNSError(with response: HTTPURLResponse) -> NSError {
        return NSError(domain: "Test", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: HTTPURLResponse.localizedString(forStatusCode: response.statusCode)])
    }
    
    private func formUrl(with title:String) throws -> URL {
        guard let url = URL(string: WikiArticleService.urlEndPoint) else {
            fatalError()
        }
        
        let titleQueryItem = URLQueryItem(name: "titles", value: title)
        let allQueryItems = WikiArticleService.urlConfigurationsQuery + [titleQueryItem]
        return url.appending(queryItems: allQueryItems)
    }
}
