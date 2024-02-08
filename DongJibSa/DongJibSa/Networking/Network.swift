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
    private let getURL = "api/v1/posts"
    private let getMypageURL = "api/v1/my-page/"
    private let indicator = "/indicator"
    private let getMyposts = "/api/v1/my-page/"
    private let postURL = "api/v1/posts/new"
    private let postVeripyPhoneNumberUser = "api/v1/users/verifyPhoneNumberUser"
    private let postRegisterPhoneNumberUser = "api/v1/users/registerPhoneNumberUser"
    private let postVerifyOAuthUser = "api/v1/users/oauth2/verifyOAuthUser"
    private let postRegisterOAuthUser = "api/v1/users/oauth2/registerOAuthUser"
    private let deleteRecipe = "api/v1/posts/"
    private let deleteUser = "api/v1/users/"
    
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
                
        guard let urlComponents = URLComponents(string: baseURL + getURL) else {
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
                let resultData = try decoder.decode(ResultData.self, from: data)
                let boardList = resultData.result.map { $0 }
                completion(boardList)
                
            } catch let error as NSError {
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
    func getRecipe(recipeId: Int, completion: @escaping (PostDto) -> Void) {
        let postId = "/\(recipeId)"
        let strURL = baseURL + getURL + postId
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
                
        guard var urlComponents = URLComponents(string: strURL) else {
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
                let response = try decoder.decode(ResponseRecipe.self, from: data)
                let recipe = response.result
                completion(recipe)
                
            } catch let error as NSError {
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
    func getMypage(completion: @escaping (Indicator) -> Void) {
        guard let user = UserDefaults.standard.dictionary(forKey: "User"),
              let memberId = user["userId"] as? Int else { return }
        let endPoint = "\(memberId)"
        let strURL = baseURL + getMypageURL + endPoint + indicator
        
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        guard let urlComponents = URLComponents(string: strURL) else {
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
                let response = try decoder.decode(ResponseIndicator.self, from: data)
                let result = response.result
                completion(result)
                
            } catch let error as NSError {
                print("error: \(error)")
            }
        }
        task.resume()
    }
    
    func getMyPosts(completion: @escaping ([PostDto]) -> Void) {
        guard let user = UserDefaults.standard.dictionary(forKey: "User"),
              let memberId = user["userId"] as? Int else { return }
        
        let endPoint = "\(memberId)/posts"
        let strURL = baseURL + getMyposts + endPoint
        
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        guard let urlComponents = URLComponents(string: strURL) else {
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
                let boardList = try decoder.decode([PostDto].self, from: data)
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
    
//    func postBoard(image: Data? = nil, filename: String? = nil, recipe: [String: Any], recipeIngredients: [[String: Any]], completion: @escaping ([String]) -> Void) {
//        let strURL = baseURL + postURL
//        let myDong: String = UserDefaults.standard.string(forKey: "myLocation") ?? "정릉4동"
//        let expectingPrice: String = "\(recipe["expectingPrice"] ?? "25000")"
//        let peopleCount: String = "\(recipe["peopleCount"] ?? "4")"
//        let pricePerOne = "\(Int(expectingPrice)! / Int(peopleCount)!)"
//        
//        let configuration = URLSessionConfiguration.default
//        
//        guard let urlComponets = URLComponents(string: strURL) else { return }
//        guard let requestURL = urlComponets.url else { return }
//        var request = URLRequest(url: requestURL)
//        
//        let boundary = "Boundary-\(UUID().uuidString)"
//        
//        request.httpMethod = "POST"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        
//        var parameters: [String: Any] = recipe
//        parameters["userName"] = "지예로운사람" // userName은 지예로운사람으로 고정되어 있음
//        parameters["dong"] = myDong
//        parameters["pricePerOne"] = pricePerOne
//        
//        for i in 0..<recipeIngredients.count {
//            parameters["ingredients[\(i)].ingredientName"] = recipeIngredients[i]["ingredientName"]
//            parameters["ingredients[\(i)].totalQty"] = recipeIngredients[i]["totalQty"]
//            parameters["ingredients[\(i)].requiredQty"] = recipeIngredients[i]["requiredQty"]
//            parameters["ingredients[\(i)].sharingAvailableQty"] = recipeIngredients[i]["sharingAvailableQty"]
//        }
//        
//        var uploadData = Data()
//        let imgDataKey = "image"
//        let boundaryPrefix = "--\(boundary)\r\n"
//        
//        for (key, value) in parameters {
//            uploadData.append(boundaryPrefix.data(using: .utf8)!)
//            uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//            uploadData.append("\(value)\r\n".data(using: .utf8)!)
//        }
//        
//        if let imageData = image {
//            uploadData.append(boundaryPrefix.data(using: .utf8)!)
//            uploadData.append("Content-Disposition: form-data; name=\"\(imgDataKey)\"; filename=\"\(filename ?? "profileImage.jpeg")\"\r\n".data(using: .utf8)!)
//            uploadData.append("Content-Type: \("image/jpeg")\r\n\r\n".data(using: .utf8)!)
//            uploadData.append(imageData)
//            uploadData.append("\r\n".data(using: .utf8)!)
//            uploadData.append("--\(boundary)--".data(using: .utf8)!)
//        }
//        
//        let session = URLSession(configuration: configuration)
//        session.uploadTask(with: request, from: uploadData) { data, response, error in
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200..<300).contains(httpResponse.statusCode)  else {
//                print("Error: HTTP request failed \n --> response: \(response)")
//                return
//            }
//            guard let data = data else { return }
//            
//            do {
//                guard let recipeInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
//                
//                guard let recipeInfoResult = recipeInfo["result"] as? [String: Any] else { return }
//                guard let id = recipeInfoResult["id"] as? Int else { return }
//                guard let imageUrl = recipeInfoResult["imgUrl"] as? String else { return }
//                guard let createdAt = recipeInfoResult["createdAt"] as? String else { return }
////                guard let userName = recipeInfoResult["user"]["userName"] as? String else { return }
//                
//                completion([imageUrl, createdAt])
//                
//            } catch let error as NSError {
//                print("Error occur: error calling PATCH - \(error)")
//            }
//        }.resume()
//    }
    
    func postRecipe(images: [Data]? = nil, filename: String? = nil, memberId: Int, recipe: [String: Any], recipeIngredients: [[String: Any]], completion: @escaping (PostDto) -> Void) {
        let strURL = baseURL + postURL
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
        parameters["memberId"] = memberId
        parameters["pricePerOne"] = pricePerOne
        
        for i in 0..<recipeIngredients.count {
            parameters["ingredients[\(i)].ingredientName"] = recipeIngredients[i]["ingredientName"]
            parameters["ingredients[\(i)].totalQty"] = recipeIngredients[i]["totalQty"]
            parameters["ingredients[\(i)].requiredQty"] = recipeIngredients[i]["requiredQty"]
            parameters["ingredients[\(i)].sharingAvailableQty"] = recipeIngredients[i]["sharingAvailableQty"]
        }
        
        var uploadData = Data()
        let imgDataKey = "images"
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            uploadData.append(boundaryPrefix.data(using: .utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            uploadData.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        guard let images = images else { return }
        for i in 0..<images.count {
            print("images.count - \(images.count)")
            let filename = "\(filename ?? "recipeImage.jpeg")\(i)"
            if let imageData = images[i] as? Data {
                uploadData.append(boundaryPrefix.data(using: .utf8)!)
                uploadData.append("Content-Disposition: form-data; name=\"\(imgDataKey)\"; filename=\"\(filename ?? "recipeImage.jpeg")\"\r\n".data(using: .utf8)!)
                uploadData.append("Content-Type: \("image/jpeg")\r\n\r\n".data(using: .utf8)!)
                uploadData.append(imageData)
                uploadData.append("\r\n".data(using: .utf8)!)
            }
        }
        uploadData.append("--\(boundary)--".data(using: .utf8)!)
        
        let session = URLSession(configuration: configuration)
        session.uploadTask(with: request, from: uploadData) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)  else {
                print("Error: HTTP request failed \n --> response: \(response)")
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ResponseRecipe.self, from: data)
                let recipe = response.result
                completion(recipe)
                
            } catch let error as NSError {
                print("Error occur: error calling PATCH - \(error)")
            }
        }.resume()
    }
    
    func putRecipe(postId: Int, images: [Data]? = nil, filename: String? = nil, memberId: Int, recipe: [String: Any], recipeIngredients: [[String: Any]], completion: @escaping (PostDto) -> Void) {
        let postId = "\(postId)"
        let strURL = baseURL + deleteRecipe + postId
        
        let expectingPrice: String = "\(recipe["expectingPrice"] ?? "25000")"
        let peopleCount: String = "\(recipe["peopleCount"] ?? "4")"
        let pricePerOne = "\(Int(expectingPrice)! / Int(peopleCount)!)"
        
        let configuration = URLSessionConfiguration.default
        
        guard let urlComponets = URLComponents(string: strURL) else { return }
        guard let requestURL = urlComponets.url else { return }
        var request = URLRequest(url: requestURL)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        request.httpMethod = "PUT"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var parameters: [String: Any] = recipe
        parameters["memberId"] = memberId
        parameters["pricePerOne"] = pricePerOne
        
        for i in 0..<recipeIngredients.count {
            parameters["ingredients[\(i)].ingredientName"] = recipeIngredients[i]["ingredientName"]
            parameters["ingredients[\(i)].totalQty"] = recipeIngredients[i]["totalQty"]
            parameters["ingredients[\(i)].requiredQty"] = recipeIngredients[i]["requiredQty"]
            parameters["ingredients[\(i)].sharingAvailableQty"] = recipeIngredients[i]["sharingAvailableQty"]
        }
        
        var uploadData = Data()
        let imgDataKey = "images"
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            uploadData.append(boundaryPrefix.data(using: .utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            uploadData.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        guard let images = images else { return }
        for i in 0..<images.count {
            print("images.count - \(images.count)")
            let filename = "\(filename ?? "recipeImage.jpeg")\(i)"
            if let imageData = images[i] as? Data {
                uploadData.append(boundaryPrefix.data(using: .utf8)!)
                uploadData.append("Content-Disposition: form-data; name=\"\(imgDataKey)\"; filename=\"\(filename ?? "recipeImage.jpeg")\"\r\n".data(using: .utf8)!)
                uploadData.append("Content-Type: \("image/jpeg")\r\n\r\n".data(using: .utf8)!)
                uploadData.append(imageData)
                uploadData.append("\r\n".data(using: .utf8)!)
            }
        }
        uploadData.append("--\(boundary)--".data(using: .utf8)!)
        
        let session = URLSession(configuration: configuration)
        session.uploadTask(with: request, from: uploadData) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)  else {
                print("Error: HTTP request failed \n --> response: \(response)")
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ResponseRecipe.self, from: data)
                let recipe = response.result
                print(">> response \(recipe)")
                completion(recipe)
                
            } catch let error as NSError {
                print("Error occur: error calling PATCH - \(error)")
            }
        }.resume()
    }
    
    func deleteUserLogout() {
        guard let user = UserDefaults.standard.dictionary(forKey: "User"),
              let memberId = user["userId"] as? Int else { return }
        let endPoint = "\(memberId)"
        let strURL = baseURL + deleteUser + endPoint
        guard let url = URL(string: strURL) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("--> response: \(response)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let logoutInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                print(logoutInfo)
                
            } catch let error as NSError {
                print("error: \(error)")
            }
        }.resume()
    }
    
    func deleteMyRecipe(postId: Int) {
        guard let user = UserDefaults.standard.dictionary(forKey: "User"),
              let memberId = user["userId"] as? Int else { return }
        let endPoint = "\(memberId)"
        let postId = "\(postId)/\(endPoint)"
        let strURL = baseURL + deleteRecipe + postId
        guard let url = URL(string: strURL) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("--> response: \(response)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let logoutInfo = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: String] else { return }
                print(logoutInfo)
                
            } catch let error as NSError {
                print("error: \(error)")
            }
        }.resume()
    }
}
