//
//  FocusGuideLineViewController.swift
//  tvExample
//
//  Created by Kurniadi on 5/12/22.
//

import UIKit

class FocusGuideLineViewController: UIViewController {

    @IBOutlet weak var topLeftButton: UIButton!
    
    @IBOutlet weak var centerButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var fakeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addFocusGuide(from: fakeView, to: topLeftButton, direction: .bottom)
        
        addFocusGuide(from: topLeftButton, to: centerButton, direction: .bottom)
        addFocusGuide(from: topLeftButton, to: centerButton, direction: .right)
        
        addFocusGuide(from: centerButton, to: rightButton, direction: .bottom)
        addFocusGuide(from: centerButton, to: rightButton, direction: .right)
      
        addFocusGuide(from: centerButton, to: topLeftButton, direction: .top)
        addFocusGuide(from: centerButton, to: topLeftButton, direction: .left)
        
        addFocusGuide(from: rightButton, to: centerButton, direction: .top)
        addFocusGuide(from: rightButton, to: centerButton, direction: .left)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    @discardableResult
    func addFocusGuide(from origin: UIView, to destination: UIView, direction: UIRectEdge, debugMode: Bool = false) -> UIFocusGuide {
        return addFocusGuide(from: origin, to: [destination], direction: direction, debugMode: debugMode)
    }

    @discardableResult
    func addFocusGuide(from origin: UIView, to destinations: [UIView], direction: UIRectEdge, debugMode: Bool = false) -> UIFocusGuide {
        let focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        focusGuide.preferredFocusEnvironments = destinations
        focusGuide.widthAnchor.constraint(equalTo: origin.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: origin.heightAnchor).isActive = true

        switch direction {
        case .bottom:
            focusGuide.topAnchor.constraint(equalTo: origin.bottomAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .top:
            focusGuide.bottomAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .left:
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.rightAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .right:
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.rightAnchor).isActive = true
        default:
            // Not supported :(
            break
        }

        if debugMode {
            view.addSubview(FocusGuideDebugView(focusGuide: focusGuide))
        }

        return focusGuide
    }
}

class FocusGuideDebugView: UIView {

    init(focusGuide: UIFocusGuide) {
        super.init(frame: focusGuide.layoutFrame)
        backgroundColor = UIColor.green.withAlphaComponent(0.15)
        layer.borderColor = UIColor.green.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 1
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
