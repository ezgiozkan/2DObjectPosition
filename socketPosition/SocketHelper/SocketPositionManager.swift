//
//  SocketTutorialMAnager.swift
//  socketPosition
//
//  Created by  Ezgi Özkan on 27.08.2021.
//

import UIKit
import SocketIO

class SocketPositionManager {

    // MARK: - Delegates
    weak var delegate: SocketPositionManagerDelegate?

    // MARK: - Properties
    let manager = SocketManager(socketURL: URL(string: "https://socket-io-whiteboard.now.sh")!, config: [.log(false), .compress])
    var socket: SocketIOClient? = nil

    // MARK: - Life Cycle
    init() {
       
        setupSocket()
        setupSocketEvents()
        socket?.connect()
    }

    func stop() {
        socket?.removeAllHandlers()
    }
  

    // MARK: - Socket Setups
    func setupSocket() {
        self.socket = manager.defaultSocket
    }

    
    func setupSocketEvents() {

        socket?.on(clientEvent: .connect) {data, ack in
            self.delegate?.didConnect()
        }

        socket?.on("drawing") { (data, ack) in
            guard let dataInfo = data.first else { return }
            if let response: SocketPosition = try? SocketParser.convert(data: dataInfo) {
                let position = CGPoint.init(x: response.x, y: response.y)
                self.delegate?.didReceive(point: position)
            }
        }

    }

    // MARK: - Socket Emits
    func socketChanged(position: CGPoint) {
        let info: [String : Any] = [
            "x": Double(position.x),
            "y": Double(position.y)
        ]
        socket?.emit("drawing", info)
    }

}

