//
//  SocketPositionScreen.swift
//  socketPosition
//
//  Created by Tacettin Pekin on 31.08.2021.
//

import UIKit



class SocketPositionScreen: UIView {
    
    //MARK: - Parameters

    weak var controller: SocketPositionScreenDelegate?
    
    override init(frame: CGRect = .zero) {
      super.init(frame: frame)
       
        setupViews()
        self.backgroundColor = .white
        //setupConstraints()
  }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(element)
    }

    
 
   
   var loading = true {
        
        didSet {
            if !loading {
                UIView.animate(withDuration: 0.5) {
                    self.element.alpha = 1.0
                }
            }
        }
    }
     
    //MARK: Elements
    
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        
        let view = UIActivityIndicatorView(frame: .zero)
        view.hidesWhenStopped = true
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        
        return view
    }()
    
    
    let element: UIView = {
        let view = UIView(frame: CGRect(x: 150, y: 200, width: 50, height: 50))
        view.layer.borderWidth = 1.0
        view.backgroundColor = .black
        return view
    }()
    
     
    
    //MARK: -Interactions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {return}
        handle(point: location)
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {return}
        handle(point: location)
        
    }
    
    //MARK: - Handle New Position
    
    func handle(point: CGPoint) {
        controller?.didChange(position: point)
        handle(new: point)
    }
    
    //MARK: - Outputs from Controller
    
    func handle(new point: CGPoint) {
        
        element.center = point
    }
    
  func didConnect(){
        
        loading = false
    }
}


