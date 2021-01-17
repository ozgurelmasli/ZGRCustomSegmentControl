//
//  ViewController.swift
//  CustomSegmentControl
//
//  Created by Mac on 17.01.2021.
//

import UIKit

class ViewController: UIViewController {

    private var exampleLabelTopAnchor : NSLayoutConstraint?
    private var exampleLabel : UILabel?
    
    private var segmentControl : ZGRCustomSegmentControl?
    
    private var segment_1CollectionView : UICollectionView?
    private var segment_1CollectionViewLeftAnchor : NSLayoutConstraint?
    private var segment_1FlowLayout : UICollectionViewFlowLayout?
    
    private var segment_2CollectionView : UICollectionView?
    private var segment_2LeftAnchor : NSLayoutConstraint?
    private var segment_2FlowLayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLabel()
        self.setSegment()
        
        self.setSegment_1CollectionView()
        self.setSegment_2ColllectionView()
    }


}

extension ViewController {
    private func setLabel(){
        self.exampleLabel = UILabel()
        self.exampleLabel?.text = "This is example label for animate segment control This is example label for animate segment control This is example label for animate segment control This is example label for animate segment control This is example label for animate segment control This is example label for animate segment control"
        self.exampleLabel?.textColor = .systemBlue
        self.exampleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.exampleLabel?.font = .systemFont(ofSize: 15)
        self.view.addSubview(self.exampleLabel!)
        self.exampleLabelTopAnchor = self.exampleLabel?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        self.exampleLabelTopAnchor?.isActive = true
        self.exampleLabel?.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant: 24).isActive = true
        self.exampleLabel?.rightAnchor.constraint(equalTo: self.view.rightAnchor  , constant: -24).isActive  = true
       
        self.exampleLabel?.numberOfLines = 0
        self.exampleLabel?.layoutIfNeeded()
    }
    
    private func setSegment(){
            self.segmentControl = ZGRCustomSegmentControl()
            self.segmentControl?.delegate = self
            self.view.addSubview(self.segmentControl!)
            self.segmentControl?.translatesAutoresizingMaskIntoConstraints = false
        self.segmentControl?.topAnchor.constraint(equalTo: self.exampleLabel!.bottomAnchor , constant: 15).isActive = true
        try! self.segmentControl?.configure(backgroundColor: .blue
                                       , selectColor: UIColor.yellow.withAlphaComponent(0.15)
                     
                                       , anchors: [
                                        self.segmentControl!.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant: 24),
                                        self.segmentControl!.rightAnchor.constraint(equalTo: self.view.rightAnchor , constant: -24),
                                        self.segmentControl!.heightAnchor.constraint(equalToConstant: 50)
                                       ], segmentItems: [
                                        ZGRSegmentControlItem(frame: .zero
                                                           , text: "Segment_1"
                                                           , textColor: .white
                                                           , textFont: UIFont.systemFont(ofSize: 14)),
                                        ZGRSegmentControlItem(frame: .zero
                                                           , isBadgeNeeded: true
                                                           , badgeColor: .orange
                                                           , badgeText: "1"
                                                           , text: "Segment_2"
                                                           , textColor: .white
                                                           , textFont: .systemFont(ofSize: 14))
                                       
                                       
                                       
                                       
                                       ])
        }
}
//MARK:-> setCollectionView
extension ViewController {
    private func setSegment_1CollectionView(){
        self.segment_1FlowLayout = UICollectionViewFlowLayout()
        self.segment_1FlowLayout?.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        self.segment_1FlowLayout?.scrollDirection = .vertical
        self.segment_1CollectionView = UICollectionView(frame: .zero, collectionViewLayout: segment_1FlowLayout!)
        self.segment_1CollectionView?.backgroundColor = .clear
        self.segment_1CollectionView?.register(segment1Cell.self, forCellWithReuseIdentifier: "segment_1")
        self.segment_1CollectionView?.delegate = self
        self.segment_1CollectionView?.dataSource = self
        
        self.view.addSubview(self.segment_1CollectionView!)
        self.segment_1CollectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.segment_1CollectionViewLeftAnchor = self.segment_1CollectionView?.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        self.segment_1CollectionView?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.segment_1CollectionView?.topAnchor.constraint(equalTo: self.segmentControl!.bottomAnchor , constant: 10).isActive = true
        self.segment_1CollectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.segment_1CollectionViewLeftAnchor?.isActive = true
    }
}
//MARK:-> setCollectionView
extension ViewController {
    private func setSegment_2ColllectionView(){
        self.segment_2FlowLayout = UICollectionViewFlowLayout()
        self.segment_2FlowLayout?.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        self.segment_2FlowLayout?.scrollDirection = .vertical
        self.segment_2CollectionView = UICollectionView(frame: .zero, collectionViewLayout: segment_2FlowLayout!)
        self.segment_2CollectionView?.backgroundColor = .clear
        self.segment_2CollectionView?.register(segment2Cell.self, forCellWithReuseIdentifier: "segment_2")
        self.segment_2CollectionView?.delegate = self
        self.segment_2CollectionView?.dataSource = self
        
        self.view.addSubview(self.segment_2CollectionView!)
        self.segment_2CollectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.segment_2LeftAnchor = self.segment_2CollectionView?.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant: UIScreen.main.bounds.width)
        self.segment_2CollectionView?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.segment_2CollectionView?.topAnchor.constraint(equalTo: self.segmentControl!.bottomAnchor , constant: 10).isActive = true
        self.segment_2CollectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.segment_2LeftAnchor?.isActive = true
    }
}
extension ViewController : ZGRCustomSegmentControlDelegate {
    func didSelect(to index: Int) {
        print(index)
        if index == 0 {
            self.segment_1CollectionViewLeftAnchor?.constant = 0
            self.segment_2LeftAnchor?.constant = UIScreen.main.bounds.width
        }else {
            self.segment_1CollectionViewLeftAnchor?.constant = UIScreen.main.bounds.width
            self.segment_2LeftAnchor?.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.async { [weak self] in
            self?.segment_1CollectionView?.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: .centeredVertically, animated: true)
            self?.segment_2CollectionView?.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: .centeredVertically, animated: true)
        }
    }
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentY = scrollView.contentOffset.y
        guard let startY = self.exampleLabel?.bounds.height else { return }
        if currentY < startY {
            //self.isScrolled = true
            let opacityPercantage = ((currentY * 100) / startY) / 100
            self.exampleLabelTopAnchor?.constant = -1 * currentY
            self.exampleLabel?.layer.opacity = Float(1 - opacityPercantage)
        }else {
            if (self.exampleLabel?.layer.opacity != 0 || self.exampleLabelTopAnchor?.constant != 0){
                self.exampleLabelTopAnchor?.constant = -1 * startY
                self.exampleLabel?.layer.opacity = 0
            }
        }
    }
}



// --- CollectionView Delegate ---  //
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.segment_1CollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "segment_1", for: indexPath) as? segment1Cell else {fatalError()}
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "segment_2", for: indexPath) as? segment2Cell else {fatalError()}
        return cell
    }
}




//MARK:-> Cells
class segment1Cell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class segment2Cell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
