//
//  SocketService.swift
//  smack
//
//  Created by McL on 9/13/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject
{
    static let instance = SocketService()
    override init()
    {
//        super.init()
    }
    
//    let manager: SocketManager = SocketManager(socketURL: URL(string: BASE_URL)!)
//    let socket = self.manager
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    
    
    func establishConnection()
    {
        let socket = manager.defaultSocket
        socket.connect()
    }
    
    func closeConnection()
    {
        let socket = manager.defaultSocket
        socket.disconnect()
    }
    
    func addChannel(
        channelName: String,
        channelDescription: String,
        completion: @escaping CompletionHandler
        )
    {
        let socket = manager.defaultSocket
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler)
    {
        let socket = manager.defaultSocket
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else
            {
                return
            }
            
            guard let channelDescription = dataArray[1] as? String else
            {
                return
            }
            
            guard let channelId = dataArray[2] as? String else
            {
                return
            }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
}