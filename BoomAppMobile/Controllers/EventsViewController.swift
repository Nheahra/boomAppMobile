//
//  EventsViewController.swift
//  BoomAppMobile
//
//  Created by Katelyn on 1/31/19.
//  Copyright © 2019 Katelyn. All rights reserved.
//

import UIKit
import Foundation

class EventCell: UICollectionViewCell {
    @IBOutlet weak var eventLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let eventLabel = UILabel(frame: .zero)
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(eventLabel)
        NSLayoutConstraint.activate([
            eventLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            eventLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            eventLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            eventLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
        self.eventLabel = eventLabel
        
        self.contentView.backgroundColor = .lightGray
        self.eventLabel.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("Interface Builder is not supported: aDecoder")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("Interface Builder is not supported: awakeFromNib()")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.eventLabel.text = nil
    }
}

class EventsViewController: UICollectionViewController {
    
    @IBOutlet weak var eventCollectionView: UICollectionView!

    override func loadView() {
        super.loadView()
        
        let eventCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        eventCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(eventCollectionView)
        NSLayoutConstraint.activate([
            eventCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            eventCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            eventCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            eventCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        self.eventCollectionView = eventCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventCollectionView.backgroundColor = .white
        self.eventCollectionView.dataSource = self
        self.eventCollectionView.delegate = self
        
        self.eventCollectionView.register(EventCell.self, forCellWithReuseIdentifier: "EventCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = eventCollectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCell
        cell.eventLabel.text = String(indexPath.row + 1)
        return cell
    }
    
    override func numberOfSections(in eventCollectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Events.allCases.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}

extension EventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 16, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}
