//
//  TitleFilterSectionView.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 27/10/2022.
//

import UIKit

protocol TitleFilterSectionViewProtocol: AnyObject {
    func onPressInSpanish()
    func onPressLaunched1993()
}

protocol TitleFilterSectionViewDataSource: AnyObject {
    func setValue(title: String, delegate: TitleFilterSectionViewProtocol?)
}

class TitleFilterSectionView: UIView, TitleFilterSectionViewDataSource {
  
    weak var delegate: TitleFilterSectionViewProtocol?
    @IBOutlet weak var launched1993: UIButton!
    @IBOutlet weak var inSpanishBtn: UIButton!
    @IBOutlet weak var titleSection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.launched1993.layer.cornerRadius = 16
        self.inSpanishBtn.layer.cornerRadius = 16
        self.launched1993.setTitleColor(.white, for: .normal)
        self.inSpanishBtn.setTitleColor(.white, for: .normal)
        self.launched1993.layer.borderColor = UIColor.white.cgColor
        self.launched1993.layer.borderWidth = 1
        self.inSpanishBtn.layer.borderColor = UIColor.white.cgColor
        self.inSpanishBtn.layer.borderWidth = 1
    }
    
    func setValue(title: String, delegate: TitleFilterSectionViewProtocol?) {
        self.titleSection.text = title
        self.delegate = delegate
    }
    
    func activateButton(button: UIButton) {
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
    }
    
    func desactivateButton(button: UIButton) {
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func onPressInSpanish(_ sender: Any) {
        self.delegate?.onPressInSpanish()
        self.activateButton(button: self.inSpanishBtn)
        self.desactivateButton(button: self.launched1993)
    }
    
    @IBAction func onPressLaunched1993(_ sender: Any) {
        self.delegate?.onPressLaunched1993()
        self.activateButton(button: self.launched1993)
        self.desactivateButton(button: self.inSpanishBtn)
    }
    
    class func Instance() -> TitleFilterSectionView {
        let view = Bundle.main.loadNibNamed("TitleFilterSection", owner: nil, options: nil)?.first as! TitleFilterSectionView
        return view
    }
    
    
}
