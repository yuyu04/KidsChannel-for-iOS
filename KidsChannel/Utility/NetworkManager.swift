//
//  NetworkManager.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    let libraryDirectory: String = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
    
    static let loginUrlPath = "http://emwkids.blaubit.co.kr/user/login"
    static let userUpdateUrlPath = "http://emwkids.blaubit.co.kr/user/update"
    static let userJoinUrlPath = "http://emwkids.blaubit.co.kr/user/join"
    static let cameraSearchUrlPath = "http://emwkids.blaubit.co.kr/camera/search"
    
    static let cameraWatchUrlPath = "http://emwkids.blaubit.co.kr/view/watch"
    static let cameraRecordUrlPath = "http://emwkids.blaubit.co.kr/view/record"
    
    static func createRequestParameter(parameter: [String : String]) -> String {
        var paramterString = ""
        for (key, value) in parameter {
            if paramterString.isEmpty == false {
                paramterString += "&"
            }
            paramterString += "\(key)=\(value)"
        }
        
        return paramterString
    }
    
    static func jsonDictionary(withJSONString: String) throws -> [String: Any] {
        let jsonDictionary: [String: Any]
        
        do {
            jsonDictionary = try JSONSerialization.jsonObject(with: withJSONString.data(using: .utf8)!, options: []) as! [String: Any]
        } catch {
            let description = NSLocalizedString("Could not analyze json data", comment: "Failed to unpack JSON")
            print(description)
            throw error
        }
        
        return jsonDictionary
    }
    
    static func requestImage(url: String, completion: @escaping(_ image: UIImage?) -> Void) {
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failed to request data from server. serviceManager = \(url), error = \(error)")
                completion(nil)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                completion(nil)
                return
            }
            
            guard let responseImage = UIImage(data: data) else {
                completion(nil)
                return
            }
        
            
            completion(responseImage)
            }.resume()
    }
    
    static func requestImageData(url: String, completion: @escaping(_ data: Data?) -> Void) {
        let request = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failed to request data from server. serviceManager = \(url)")
                completion(nil)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                completion(nil)
                return
            }
            
            completion(data)
            }.resume()
    }
    
    static func requestData(url: String, parameter: String, method: String, completion: @escaping (_ responseJson: [String: Any]?) -> Void) {
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method
        request.httpBody = parameter.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failed to request data from server. serviceManager = \(url), error = \(error)")
                completion(nil)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                completion(nil)
                return
            }
            
            guard let responseData = String(bytes: data, encoding: .utf8) else {
                completion(nil)
                return
            }
            
            let trimString = responseData.trimmingCharacters(in: .whitespacesAndNewlines)
            var responseJson: [String: Any]
            do {
                responseJson = try jsonDictionary(withJSONString: trimString)
            } catch {
                completion(nil)
                return
            }
            
            completion(responseJson)
            }.resume()
    }
    
    static func requestDataForCamera(url: String, parameter: String, method: String, completion: @escaping (_ responseJson: [[String: Any]]?) -> Void) {
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5.0)
        request.httpMethod = method
        request.httpBody = parameter.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failed to request data from server. serviceManager = \(url), error = \(error)")
                completion(nil)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                completion(nil)
                return
            }
            
            guard let responseData = String(bytes: data, encoding: .utf8) else {
                completion(nil)
                return
            }
            
            let trimString = responseData.trimmingCharacters(in: .whitespacesAndNewlines)
            var responseJson: [[String: Any]]
            do {
                responseJson = try JSONSerialization.jsonObject(with: trimString.data(using: .utf8)!, options: []) as! [[String: Any]]
            } catch {
                completion(nil)
                return
            }
            
            completion(responseJson)
            }.resume()
    }
    
    static func requestLogin(fromUserId: String, password: String, completion: @escaping (_ kindergartenName: String, _ serverMessage: String) -> Void) {
        let loginUrl = loginUrlPath + "/" + fromUserId + "/" + password.md5()
        self.requestData(url: loginUrl, parameter: "", method: "GET") { (responseJson) in
            if responseJson == nil {
                completion("", "서버로부터 응답을 받을 수 없습니다")
                return
            }
            
            guard let result: String = responseJson?["kindergarten_name"] as! String? else {
                guard let message: String = responseJson?["message"] as! String? else {
                    completion("", "서버로부터 응답을 받을 수 없습니다")
                    return
                }
                
                if message == "id" {
                    completion("", "아이디를 확인해 주시기 바랍니다")
                    return
                } else if message == "pw" {
                    completion("", "잘못된 비밀번호를 입력하셨습니다")
                    return
                }
                
                completion("", "서버로부터 응답을 받을 수 없습니다")
                return
            }
            
            completion(result, "")
        }
    }
    
    static func requestUserUpdate(userId: String, password: String, kindergartenName: String,
                                  completion: @escaping (_ message: String) -> Void) {
        let paramterString = self.createRequestParameter(parameter: ["user_id":userId, "user_pw":password.md5(), "kindergarten_name":kindergartenName])
        self.requestData(url: userUpdateUrlPath, parameter: paramterString, method: "POST") { (responseJson) in
            if responseJson == nil {
                completion("서버로부터 응답을 받을 수 없습니다")
                return
            }
            
            guard let value: Bool = responseJson?["error"] as! Bool? else {
                completion("")
                return
            }
            
            if value {
                completion("회원정보를 수정하지 못했습니다")
                return
            }
            
            completion("")
        }
    }
    
    static func requestUserJoin(userId: String, password: String, kindergartenName: String,
                                  completion: @escaping (_ message: String) -> Void) {
        let paramterString = self.createRequestParameter(parameter: ["user_id":userId, "user_pw":password.md5(), "kindergarten_name":kindergartenName])
        self.requestData(url: userJoinUrlPath, parameter: paramterString, method: "POST") { (responseJson) in
            if responseJson == nil {
                completion("서버로부터 응답을 받을 수 없습니다")
                return
            }
            
            guard let value: Bool = responseJson?["error"] as! Bool? else {
                completion("")
                return
            }
            
            if value {
                completion("회원가입에 실패하였습니다")
                return
            }
            
            completion("")
        }
    }
    
    static func requestCameraSearch(userId: String, completion: @escaping (_ cameraList: Array<Camera>?) -> Void) {
        let searchUrl = cameraSearchUrlPath + "/" + userId
        self.requestDataForCamera(url: searchUrl, parameter: "", method: "GET") { (responseJson) in
            guard let jsonArray = responseJson else {
                completion(nil)
                return
            }
            
            var cameras = [Camera]()
            for json in jsonArray {
                guard let cameraIdx = json["camera_idx"] as! String?,
                    let cameraName = json["camera_name"] as! String?,
                    let cameraIp = json["camera_ip"] as! String?,
                    let cameraPort = json["camera_port"] as! String?,
                    let cameraId = json["camera_id"] as! String?,
                    let cameraPassword = json["camera_pw"] as! String?,
                    let cameraNumber = json["camera_num"] as! String?,
                    let cameraCaptureUrl = json["camera_capture_url"] as! String?,
                    let updateTime = json["updated_time"] as! String? else {
                        continue
                }
                
                var cameraRtspUrl: String
                if json["camera_rtsp_url"] != nil {
                    cameraRtspUrl = json["camera_rtsp_url"] as! String
                } else {
                    cameraRtspUrl = ""
                }
                
                let camera = Camera(idx: cameraIdx, name: cameraName, ip: cameraIp, port: cameraPort, id: cameraId, password: cameraPassword, number: cameraNumber, updateTime: updateTime, cameraCaptureUrl: cameraCaptureUrl, cameraRtspUrl: cameraRtspUrl)
                cameras.append(camera)
            }
            
            completion(cameras)
        }
    }
    
    static func requestViewWatch(userId: String, cameraIdx: String, viewStartTime: Date, viewEndTime: Date) {
        let viewStartTimeString = String(Int64(viewStartTime.timeIntervalSince1970*1000))
        let viewEndTimeString = String(Int64(viewEndTime.timeIntervalSince1970*1000))
        let paramterString = self.createRequestParameter(parameter: ["user_id":userId, "camera_idx":cameraIdx, "view_start":viewStartTimeString, "view_end":viewEndTimeString, "view_type":"0"])
        self.requestData(url: cameraWatchUrlPath, parameter: paramterString, method: "POST") { (responseJson) in
            if responseJson == nil {
                print("failed post record data. userId=\(userId), cameraIdx=\(cameraIdx), recordStartTime=\(viewStartTimeString), recordEndTime=\(viewEndTimeString)")
                return
            }
            
            print("post record data. responseData=\(String(describing: responseJson))")
        }
    }
    
    static func requestViewRecord(userId: String, cameraIdx: String, recordStartTime: Date, recordEndTime: Date) {
        let recordStartTimeString = String(Int64(recordStartTime.timeIntervalSince1970*1000))
        let recordEndTimeString = String(Int64(recordEndTime.timeIntervalSince1970*1000))
        let paramterString = self.createRequestParameter(parameter: ["user_id":userId, "camera_idx":cameraIdx, "view_start":recordStartTimeString, "view_end":recordEndTimeString, "view_type":"1"])
        self.requestData(url: cameraRecordUrlPath, parameter: paramterString, method: "POST") { (responseJson) in
            if responseJson == nil {
                print("failed post record data. userId=\(userId), cameraIdx=\(cameraIdx), recordStartTime=\(recordStartTimeString), recordEndTime=\(recordEndTimeString)")
                return
            }
            
            print("post record data. responseData=\(String(describing: responseJson))")
        }
    }
    
    static func requestServiceStatus(status: @escaping (_ status: Bool) -> Void) {
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId") else {
            status(false)
            return
        }
        
        let urlString = "http://emwkids.blaubit.co.kr/schdule/check/" + userId
        NetworkManager.requestData(url: urlString, parameter: "", method: "GET") { (responseJson) in
            if responseJson == nil {
                DispatchQueue.main.async {
                    status(false)
                }
                return
            }
            
            guard let result: Bool = responseJson?["check"] as? Bool else {
                DispatchQueue.main.async {
                    status(false)
                }
                return
            }
            
            if result {
                DispatchQueue.main.async {
                    status(true)
                }
            } else {
                DispatchQueue.main.async {
                    status(false)
                }
            }
        }
    }
}
