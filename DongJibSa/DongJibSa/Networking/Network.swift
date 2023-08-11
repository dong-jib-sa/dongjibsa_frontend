//
//  Network.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/03.
//

import Foundation

class Network {
    static let shared = Network()
    
    private let baseURL = "http://ec2-43-201-22-238.ap-northeast-2.compute.amazonaws.com:8080/"
    private let test = "api/v1/cicdTest"
    private let getURL = "api/v1/posts/"
    private let getMypageURL = "api/v1/my-page/indicator"
    private let getMypostURL = "api/v1/my-page/posts"
    private let postURL = "api/v1/posts/new"
    
    private init() { }
    
    func getText(completion: @escaping (String) -> Void) {
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        guard let urlComponents = URLComponents(string: baseURL + test) else {
            return
        }
        guard let requestURL = urlComponents.url else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: requestURL) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("--> response: \(response)")
                return
            }
            guard let data = data else { return }
            
            let result = String(data: data, encoding: .utf8)
            completion(result!)
        }
        task.resume()
    }
    
    func getRecipes(completion: @escaping ([Board]) -> Void) {
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        let myDong: String = UserDefaults.standard.string(forKey: "myLocation") ?? "정릉4동"
        
        guard let urlComponents = URLComponents(string: baseURL + getURL + myDong) else {
            return
        }
        guard let requestURL = urlComponents.url else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: requestURL) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("--> response: \(response)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let boardList = try decoder.decode([Board].self, from: data)
                completion(boardList)
                
            } catch let error as NSError {
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
    func getMypage(completion: @escaping ([String: Double]) -> Void) {
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        guard let urlComponents = URLComponents(string: baseURL + getMypageURL) else {
            return
        }
        guard let requestURL = urlComponents.url else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: requestURL) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("--> response: \(response)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                if let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    if let result = root["result"] as? [String: Double] {
                        completion(result)
                    }
                }
            } catch let error as NSError {
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
    func getMyPosts(completion: @escaping ([Board]) -> Void) {
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        guard let urlComponents = URLComponents(string: baseURL + getMypostURL) else {
            return
        }
        guard let requestURL = urlComponents.url else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: requestURL) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("--> response: \(response)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let boardList = try decoder.decode([Board].self, from: data)
                completion(boardList)
                
            } catch let error as NSError {
                print("error: \(error)")
            }
        }
        task.resume()
    }
}
