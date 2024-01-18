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
    private let postVeripyPhoneNumberUser = "api/v1/users/verifyPhoneNumberUser"
    private let postRegisterPhoneNumberUser = "api/v1/users/registerPhoneNumberUser"
    private let postVerifyOAuthUser = "api/v1/users/oauth2/verifyOAuthUser"
    private let postRegisterOAuthUser = "api/v1/users/oauth2/registerOAuthUser"
    
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
    
    func postVeripyPhoneNumber(number: String, nickName: String, completion: @escaping (String) -> Void) {
        let strURL = baseURL + postVeripyPhoneNumberUser
        let parameters: [String: Any] = ["phoneNumber": number, "nickName": nickName]
        
        let configuration = URLSessionConfiguration.default
        
        guard let urlComponets = URLComponents(string: strURL) else { return }
        guard let requestURL = urlComponets.url else { return }
        var request = URLRequest(url: requestURL)
        
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = jsonData
        
        let session = URLSession(configuration: configuration)
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)  else {
                print("Error: HTTP request failed \n --> response: \(response)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let loginInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: String] else { return }
                let result = loginInfo["result"]!
                completion(result)
                
            } catch let error as NSError {
                print("Error occur: error calling PATCH - \(error)")
            }
            
        }.resume()
    }
    
    func postRegisterPhoneNumber(number: String, nickName: String, completion: @escaping (String) -> Void) {
        let strURL = baseURL + postRegisterPhoneNumberUser
        let parameters: [String: Any] = ["phoneNumber": number, "nickName": nickName]
        
        let configuration = URLSessionConfiguration.default
        
        guard let urlComponets = URLComponents(string: strURL) else { return }
        guard let requestURL = urlComponets.url else { return }
        var request = URLRequest(url: requestURL)
        
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = jsonData
        
        let session = URLSession(configuration: configuration)
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)  else {
                print("Error: HTTP request failed \n --> response: \(response)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let loginInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                print(loginInfo)
                let result = loginInfo["resultCode"]!
                completion(result as! String)
                
            } catch let error as NSError {
                print("Error occur: error calling PATCH - \(error)")
            }
            
        }.resume()
    }
    
    func postVerifyOAuthUser(type: LoginType, email: String, id: String, completion: @escaping (String) -> Void) {
        let strURL = baseURL + postVerifyOAuthUser
        let parameters: [String: Any] = ["socialType": type.title, "email": email, "socialId": id]
        
        let configuration = URLSessionConfiguration.default
        
        guard let urlComponets = URLComponents(string: strURL) else { return }
        guard let requestURL = urlComponets.url else { return }
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = jsonData
        
        let session = URLSession(configuration: configuration)
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)  else {
                print("Error: HTTP request failed \n --> response: \(response)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let loginInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: String] else { return }
                guard let result = loginInfo["result"] else { return }
                completion(result)
                
            } catch let error as NSError {
                print("Error occur: error calling PATCH - \(error)")
            }
            
        }.resume()
    }
    
    func postRegisterOAuthUserLogin(type: LoginType, email: String, id: String, nickName: String, completion: @escaping (Int) -> Void) {
        let strURL = baseURL + postRegisterOAuthUser
        let parameters: [String: Any] = ["socialType": type.title, "email": email, "socialId": id, "nickName": nickName]
        
        let configuration = URLSessionConfiguration.default
        
        guard let urlComponets = URLComponents(string: strURL) else { return }
        guard let requestURL = urlComponets.url else { return }
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = jsonData
        
        let session = URLSession(configuration: configuration)
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)  else {
                print("Error: HTTP request failed \n --> response: \(response)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let loginInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                guard let result = loginInfo["result"] as? [String: Any] else { return }
                guard let userId = result["memberId"] as? Int else { return }
                completion(userId)
                
            } catch let error as NSError {
                print("Error occur: error calling PATCH - \(error)")
            }
            
        }.resume()
    }
    
    func postBoard(image: Data? = nil, filename: String? = nil, recipe: [String: Any], recipeIngredients: [[String: Any]], completion: @escaping ([String]) -> Void) {
        let strURL = baseURL + postURL
        let myDong: String = UserDefaults.standard.string(forKey: "myLocation") ?? "정릉4동"
        let expectingPrice: String = "\(recipe["expectingPrice"] ?? "25000")"
        let peopleCount: String = "\(recipe["peopleCount"] ?? "4")"
        let pricePerOne = "\(Int(expectingPrice)! / Int(peopleCount)!)"
        
        let configuration = URLSessionConfiguration.default
        
        guard let urlComponets = URLComponents(string: strURL) else { return }
        guard let requestURL = urlComponets.url else { return }
        var request = URLRequest(url: requestURL)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var parameters: [String: Any] = recipe
        parameters["userName"] = "지예로운사람" // userName은 지예로운사람으로 고정되어 있음
        parameters["dong"] = myDong
        parameters["pricePerOne"] = pricePerOne
        
        for i in 0..<recipeIngredients.count {
            parameters["ingredients[\(i)].ingredientName"] = recipeIngredients[i]["ingredientName"]
            parameters["ingredients[\(i)].totalQty"] = recipeIngredients[i]["totalQty"]
            parameters["ingredients[\(i)].requiredQty"] = recipeIngredients[i]["requiredQty"]
            parameters["ingredients[\(i)].sharingAvailableQty"] = recipeIngredients[i]["sharingAvailableQty"]
        }
        
        var uploadData = Data()
        let imgDataKey = "image"
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            uploadData.append(boundaryPrefix.data(using: .utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            uploadData.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        if let imageData = image {
            uploadData.append(boundaryPrefix.data(using: .utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(imgDataKey)\"; filename=\"\(filename ?? "profileImage.jpeg")\"\r\n".data(using: .utf8)!)
            uploadData.append("Content-Type: \("image/jpeg")\r\n\r\n".data(using: .utf8)!)
            uploadData.append(imageData)
            uploadData.append("\r\n".data(using: .utf8)!)
            uploadData.append("--\(boundary)--".data(using: .utf8)!)
        }
        
        let session = URLSession(configuration: configuration)
        session.uploadTask(with: request, from: uploadData) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)  else {
                print("Error: HTTP request failed \n --> response: \(response)")
                return
            }
            guard let data = data else { return }
            
            do {
                guard let recipeInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                
                guard let recipeInfoResult = recipeInfo["result"] as? [String: Any] else { return }
                guard let id = recipeInfoResult["id"] as? Int else { return }
                guard let imageUrl = recipeInfoResult["imgUrl"] as? String else { return }
                guard let createdAt = recipeInfoResult["createdAt"] as? String else { return }
//                guard let userName = recipeInfoResult["user"]["userName"] as? String else { return }
                
                completion([imageUrl, createdAt])
                
            } catch let error as NSError {
                print("Error occur: error calling PATCH - \(error)")
            }
        }.resume()
    }
}
