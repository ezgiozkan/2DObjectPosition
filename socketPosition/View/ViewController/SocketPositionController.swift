//
//  SocketPositionController.swift
//  socketPosition
//
//  Created by Tacettin Pekin on 31.08.2021.
//

import UIKit

class SocketPositionController: UIViewController {

    //MARK:Properties
    @IBOutlet var element: UIView!
    let socket = SocketPositionManager()
    

    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Socket Position"
      
        setupDelegates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket.stop()
    }
    
    
    //MARK: -Interactions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self.view) else {return}
        handle(point: location)
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self.view) else {return}
        handle(point: location)
    }

    //MARK: - Send position to socket
    
    func handle(point: CGPoint) {
        socket.socketChanged(position: point)
        //position
        handle(new: point)
    }
    
    //MARK: - Update element on screen
    
    func handle(new point: CGPoint) {
        
        element.center = point
    }
    
    
    
   //MARK: Setups
    
    func setupDelegates() {
        
        
        socket.delegate = self
    }

}
extension SocketPositionController: SocketPositionManagerDelegate {
    
    func didConnect() {
        
    }
    
    func didReceive(point: CGPoint)
    {
       handle(new: point)
    }
}





