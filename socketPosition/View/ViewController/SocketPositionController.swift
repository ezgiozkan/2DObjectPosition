//
//  SocketPositionController.swift
//  socketPosition
//
//  Created by Tacettin Pekin on 31.08.2021.
//

import UIKit

class SocketPositionController: UIViewController {

    //MARK:Properties
    
    let screen = SocketPositionScreen()
    let socket = SocketPositionManager()

    //MARK: Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = screen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Socket Position"
      
        setupDelegates()
    }
    

  
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket.stop()
    }
    

    
   //MARK: Setups
    
    func setupDelegates() {
        
        screen.controller = self
        socket.delegate = self
    }

}
extension SocketPositionController: SocketPositionManagerDelegate {
    
    func didConnect() {
        screen.didConnect()
    }
    
    func didReceive(point: CGPoint)
    {
       screen.handle(new: point)
    }
}

extension SocketPositionController: SocketPositionScreenDelegate {
   
    func didChange(position: CGPoint) {
        socket.socketChanged(position: position)
    }
    
    
    
}




