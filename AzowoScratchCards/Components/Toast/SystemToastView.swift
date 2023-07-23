//
//  SystemToastView.swift
//  Urbi
//
//  Created by Marek Baláž on 22/07/2023.
//

import Foundation
import UIKit

class SystemToastView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var componentContentView : UIView!
    @IBOutlet weak var contentToastView     : UIView!
    @IBOutlet weak var topView              : UIView!
    @IBOutlet weak var iconImage            : UIImageView!
    @IBOutlet weak var titleLbl             : UILabel!
    
    // MARK: - Variables
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
    
    private func setupXib() {
        let view = loadXib()
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(componentContentView)
        componentContentView = view
    }
    
    private func loadXib() -> UIView? {
        Bundle.main.loadNibNamed("SystemToastView", owner: self, options: nil)
        
        setFonts()
        setColors()
        contentToastView.layer.cornerRadius = 20
        contentToastView.layer.borderWidth = 1
        contentToastView.layer.borderColor = UIColor.content2().cgColor
        topView.layer.cornerRadius = 20
        contentToastView.layer.shadowColor = UIColor.content2().cgColor
        contentToastView.layer.shadowOpacity = 0.16
        contentToastView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentToastView.layer.shadowRadius = 16
        return componentContentView
    }
    
    func setFonts() {
        self.titleLbl.font = UIFont.text()
    }
    
    func setColors() {
        self.contentToastView.backgroundColor = UIColor.background2()
        self.topView.backgroundColor = UIColor.background2()
        self.iconImage.tintColor = UIColor.primary()
        self.titleLbl.textColor = UIColor.primary()
    }
    
}
