//
//  SocketPositionManagerDelegate.swift
//  socketPosition
//
//  Created by Tacettin Pekin on 31.08.2021.
//

import UIKit


protocol SocketPositionManagerDelegate: class {
    
    func didConnect()
    func didReceive(point: CGPoint)
}
