//
//  ZGRSegmentControl.swift
//  CustomSegmentControl
//
//  Created by Hasan Ozgur Elmasli on 17.01.2021.
//
import Foundation
import UIKit

enum ZGRSegmentControlError : String , Error {
    case NoItemFound = "You need to give ZGRSegmentControlItem for creating custom segment control. That's illegal"
}

protocol ZGRCustomSegmentControlDelegate : class{
   func didSelect(to index : Int)
}

final class ZGRSegmentControlItem :  UIView {
   private var segmentLabel : UILabel?
   private var badgeView :  UIView?
   
   private var  isBadgeNeeded : Bool = false
   private var  badgeColor : UIColor = .white
   private var badgeText : String = ""
   private var  text : String = ""
   private var  textColor : UIColor = .clear
   private var  textFont :  UIFont = . systemFont(ofSize: 15)
   
   
   convenience  init(frame: CGRect
                     , isBadgeNeeded : Bool = false
                     , badgeColor : UIColor = .white
                     , badgeText  : String = ""
                     , text : String
                     , textColor : UIColor
                     , textFont :  UIFont ) {
       self.init(frame:frame)
       
       self.isBadgeNeeded = isBadgeNeeded
       self.badgeColor = badgeColor
       self.badgeText = badgeText
       
       self.text = text
       self.textColor = textColor
       self.textFont = textFont
   }
   
   fileprivate func setupView(){
       self.setSegmentLabel()
       if self.isBadgeNeeded {
           self.setBadgeView()
       }
   }
   private func setSegmentLabel(){
       self.segmentLabel = UILabel()
       self.addSubview(self.segmentLabel!)
    self.segmentLabel?.translatesAutoresizingMaskIntoConstraints = false
    self.segmentLabel?.text = text
    self.segmentLabel?.textColor = textColor
    self.segmentLabel?.font = textFont
    self.segmentLabel?.textAlignment = .center
       self.segmentLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
       self.segmentLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor , constant:  self.isBadgeNeeded == true ? -11 : 0).isActive = true
       self.segmentLabel?.numberOfLines = 2
       let width = self.text.getLabelWidth(height: 19, font: self.textFont)
       self.segmentLabel?.widthAnchor.constraint(equalToConstant: width).isActive = true
   }
   private func setBadgeView(){
       self.badgeView = UIView()
       self.addSubview(self.badgeView!)
       self.badgeView?.backgroundColor = self.badgeColor
       self.badgeView?.translatesAutoresizingMaskIntoConstraints = false
       self.badgeView?.leftAnchor.constraint(equalTo: self.segmentLabel!.rightAnchor , constant: 5).isActive = true
       self.badgeView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
       self.badgeView?.widthAnchor.constraint(equalToConstant: 22).isActive = true
       self.badgeView?.heightAnchor.constraint(equalToConstant: 22).isActive = true
       self.badgeView?.layer.masksToBounds = true
       self.badgeView?.layer.cornerRadius = 6
       
       
       let bagdeLabel : UILabel = UILabel()
       self.badgeView?.addSubview(bagdeLabel)
       bagdeLabel.text = self.badgeText
       bagdeLabel.textColor = UIColor.white.withAlphaComponent(0.5)
       bagdeLabel.font = .systemFont(ofSize: 13)
       bagdeLabel.textAlignment = .center
       bagdeLabel.translatesAutoresizingMaskIntoConstraints = false
       bagdeLabel.centerXAnchor.constraint(equalTo: self.badgeView!.centerXAnchor).isActive = true
       bagdeLabel.centerYAnchor.constraint(equalTo: self.badgeView!.centerYAnchor).isActive = true
       bagdeLabel.widthAnchor.constraint(equalTo: self.badgeView!.widthAnchor).isActive = true
   }
}


final class ZGRCustomSegmentControl: UIView {
   private var selectorColor : UIColor = .white
   private var itemCount : Int = 2
   private var selectorView : UIView?
   private var segmentItems : [ZGRSegmentControlItem] = []
   
   private var currentIndex : Int = 0
   private var selectorViewLeftAnchor : NSLayoutConstraint?
   
   weak var delegate : ZGRCustomSegmentControlDelegate?
   
   override init(frame: CGRect) {
       super.init(frame: frame)
   }
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    /**
     This func create custom segment control depends given variables
     
     - parameter backgroundColor: Segment control background color.
     - parameter selectColor: Shows which segment you are in 2. which named as selectorView , this variable background color of selectorView
     - parameter anchors: Constraint
     - parameter segmentedItems: What will be show inside one segment
     - returns: Void
     - warning: You need to give item if don't ,  func will throw an error
     
     
     # Notes: #
     1. None
     
     # Example #
     ```
     // self.segmentControl?.configure(backgroundColor: .blue
     , selectColor: UIColor.yellow.withAlphaComponent(0.15)
     , anchors: [ //--- anchors --- //
     ], segmentItems: [
       // --- ZGRItems --- //
     ])

     ```
     
     */
   func configure(backgroundColor : UIColor
                    , selectColor : UIColor
                    , anchors : [NSLayoutConstraint]
                  , segmentItems : [ZGRSegmentControlItem]) throws{
        if segmentItems.count == 0 {
            throw ZGRSegmentControlError.NoItemFound
        }
        self.backgroundColor = backgroundColor
        self.itemCount = segmentItems.count
        self.selectorColor = selectColor
        self.segmentItems = segmentItems
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(anchors)
        self.layoutIfNeeded()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
       
        self.setSelectorView()
        self.setSegmentItems()
   }
   
   
   
}


// --- Set UI --- //
extension ZGRCustomSegmentControl {
    private func setSelectorView(){
        self.selectorView = UIView()
        self.addSubview(self.selectorView!)
        let width = self.bounds.width - 15
        let perItemWidth = width / CGFloat(itemCount)
        self.selectorView?.translatesAutoresizingMaskIntoConstraints = false
        self.selectorView?.backgroundColor = self.selectorColor
        self.selectorViewLeftAnchor =  self.selectorView?.leftAnchor.constraint(equalTo: self.leftAnchor , constant: 5)
        self.selectorView?.topAnchor.constraint(equalTo: self.topAnchor , constant: 5).isActive = true
        self.selectorView?.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -5).isActive = true
        self.selectorView?.widthAnchor.constraint(equalToConstant: perItemWidth).isActive = true
        self.selectorViewLeftAnchor?.isActive = true
        
        self.selectorView?.layer.masksToBounds = true
        self.selectorView?.layer.cornerRadius = 12
    }
    private func setSegmentItems(){
        if self.segmentItems.count == 0 {return}
        let width = self.bounds.width
        let perItemWidth = width / CGFloat(itemCount)
        for(index , item) in self.segmentItems.enumerated() {
            self.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            item.tag = index
            item.isUserInteractionEnabled = true
            item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(segmentTapped(gesture:))))
            if index == 0 {
                item.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            }else {
                item.leftAnchor.constraint(equalTo: self.segmentItems[index - 1].rightAnchor).isActive = true
            }
            item.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            item.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            item.widthAnchor.constraint(equalToConstant: perItemWidth).isActive  = true
            item.setupView()
            
            if index == self.currentIndex {
                item.subviews.forEach({$0.layer.opacity = 1.0})
            }else {
                item.subviews.forEach({$0.layer.opacity = 0.5})
            }
        }
    }
}

// --- @objc func --- //
extension ZGRCustomSegmentControl {
    @objc func segmentTapped(gesture : UITapGestureRecognizer){
        guard let index = gesture.view?.tag else {return}
        let width = self.bounds.width - 15
        let perItemWidth = width / CGFloat(itemCount)
        if self.currentIndex == index {return}
        self.currentIndex = index
        
        for (index , item)  in self.segmentItems.enumerated() {
            if index == self.currentIndex {
                item.subviews.forEach({$0.layer.opacity = 1.0})
            }else {
                item.subviews.forEach({$0.layer.opacity = 0.5})
            }
        }
        
        let perItemLeft = (CGFloat(index) * perItemWidth)
        let spacing = (index * 5)  + 5
        self.selectorViewLeftAnchor?.constant =  perItemLeft + CGFloat(spacing)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
        self.delegate?.didSelect(to: gesture.view?.tag ?? 0)
    }
}





extension String {
    func getLabelWidth(height : CGFloat , font :UIFont) -> CGFloat {
            let tempLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
            tempLabel.numberOfLines = 0
            tempLabel.text = self
            tempLabel.font = font
            tempLabel.sizeToFit()
            return tempLabel.frame.width
        }
}
