//
//  MessageService.swift
//  smack
//
//  Created by McL on 9/10/18.
//  Copyright © 2018 McL. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService
{
    static let instance = MessageService()
    
    var messages = [Message]()
    var channels = [Channel]()
    var unreadChannels = [String]()
    var selectedChannel: Channel?
    
    func findAllChannels(completion: @escaping CompletionHandler)
    {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil
            {
                guard let data = response.data else
                {
                    return
                }
                
//                do
//                {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error {
//                    debugPrint(error as Any)
//                }
                
                do
                {
                    if let json = try JSON(data: data).array
                    {
                        for item in json
                        {
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            
                            self.channels.append(channel)
//                            print(channel)
                        }
                        NotificationCenter.default.post(name: NOTIFICATION_CHANNELS_LOADED, object: nil)
                        completion(true)
                    }
                } catch {
                    print(error)
                }
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessagesOfChannel(channelId: String, completion: @escaping CompletionHandler)
    {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil
            {
                self.clearMessages()
                guard let data = response.data else
                {
                    return
                }
                
                do
                {
                    if let json = try JSON(data: data).array
                    {
                        for item in json
                        {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userId = item["userId"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timestamp = item["timestamp"].stringValue
                            
                            let message = Message(message: messageBody, userId: userId, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timestamp)
                            self.messages.append(message)
                        }
                        print(self.messages)
                        completion(true)
                    }
                } catch {
                    print(error)
                }
                
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages()
    {
        messages.removeAll()
    }
    
    func clearChannels()
    {
        channels.removeAll()
    }
}
