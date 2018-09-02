//
//  SettingVC.swift
//  RawDiligence
//
//  Created by Abhinay on 30/08/18.
//  Copyright © 2018 Cyrus Kiani. All rights reserved.
//

import UIKit

struct SettingRecord {
    let title:String!
    var subTitle:String?
}

class SettingVC: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    //MARK:- Widgets
    fileprivate let lblHeaderTitle:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        var attributedText = NSMutableAttributedString(string: "Raw Diligence is currently:", attributes: [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17.0)])
        let onOffAttributedText = NSAttributedString(string: " ON", attributes: [NSAttributedStringKey.foregroundColor:UIColor.green, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17.0)])
        attributedText.append(onOffAttributedText)
        lbl.attributedText = attributedText
        lbl.backgroundColor = .white
        return lbl
    }()
    
    fileprivate let viewResetContainer:UIView = {
        let view = UIView ()
        view.backgroundColor = .lightGray
        view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
        return view
    }()
    
    fileprivate var stackView:UIStackView!
    
    fileprivate let btnReset:UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Reset\nDetox", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17.0)]), for: .normal)
        btn.titleLabel?.numberOfLines = 2
        btn.backgroundColor = UIColor.green
        btn.layer.cornerRadius = 86.0 / 2
        btn.layer.borderWidth = 0.50
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.masksToBounds = true
        return btn
    }()
    
    fileprivate let btnPause:UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Pause\nDetox", attributes: [NSAttributedStringKey.foregroundColor : UIColor.black, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17.0)]), for: .normal)
        btn.titleLabel?.numberOfLines = 2
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 86.0 / 2
        btn.layer.borderWidth = 0.50
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }()
    
    //MARK:- Priavte Constant
    fileprivate let cellId = "SettingCell"
    
    //MARK:- Priavte Vars
    fileprivate var dataSource = [SettingRecord]()
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        pageAppearance()
    }
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        view.addSubview(lblHeaderTitle)
        view.addSubview(viewResetContainer)
        
        
        stackView = UIStackView(arrangedSubviews: [btnReset, btnPause])
        stackView.spacing = 86.0
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .red
        
        viewResetContainer.addSubview(stackView)
        
        setLayout()
        setData()
        
        collectionView?.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    fileprivate func pageAppearance(){
        collectionView?.backgroundColor = .white
    }
    
    fileprivate func setLayout()
    {
        view.addConstraint(visualFormat: "H:|[v0]|", forViews: lblHeaderTitle)
        view.addConstraint(visualFormat: "H:|[v0]|", forViews: viewResetContainer)
        view.addConstraint(visualFormat: "H:|[v0]|", forViews: collectionView!)
        
        view.addConstraint(visualFormat: "V:|-64-[v0(44)][v1(100)][v2]|", forViews: lblHeaderTitle, viewResetContainer, collectionView!)
        
        stackView.centerYAnchor.constraint(equalTo: viewResetContainer.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: viewResetContainer.centerXAnchor).isActive = true
        
        viewResetContainer.addConstraint(visualFormat:"V:|-7-[v0]-7-|", forViews: stackView)
        viewResetContainer.addConstraint(visualFormat:"H:[v0(258)]", forViews: stackView)
    }
    
    fileprivate func setData()
    {
        dataSource.append(SettingRecord(title: "Daily Reminders", subTitle: "Off"))
        dataSource.append(SettingRecord(title: "Before Picture", subTitle: "Not Taken"))
        dataSource.append(SettingRecord(title: "History", subTitle: ""))
    }
    
    fileprivate func refreshPage(){
        collectionView?.reloadData()
    }
    
    //MARK:- Collection DataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.record = dataSource[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 44)
    }
    
}

extension SettingVC
{
    static func instantiate() -> SettingVC
    {
        let flowLayout = UICollectionViewFlowLayout()
        let vc = SettingVC(collectionViewLayout: flowLayout)
        return vc
    }
}

//MARK:- UICollectionViewCell

class SettingBaseCell:UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        
    }
}

class SettingCell: SettingBaseCell
{
    private var datePicker:UIDatePicker?
    
    var record:SettingRecord!{
        didSet{
           lblTitle.text = record.title
            lblSubTitle.text = record.subTitle
        }
    }
    
    private let lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 17.0)
        return lbl
    }()
    
    private let lblSubTitle:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .right
        lbl.font = UIFont.systemFont(ofSize: 17.0)
        return lbl
    }()
    
    private let viewSeperator:UIView = {
        let seperator = UIView()
        seperator.backgroundColor = .lightGray
        return seperator
    }()
    
    override func setupView()
    {
        addSubview(lblTitle)
        addSubview(lblSubTitle)
        addSubview(viewSeperator)
        setLayout()
    }
    
    private func setLayout()
    {
        addConstraint(visualFormat: "H:|-15-[v0][v1(100)]-15-|", forViews:lblTitle, lblSubTitle)
        addConstraint(visualFormat: "H:|[v0]|", forViews:viewSeperator)
        addConstraint(visualFormat: "V:|[v0]-1-|", forViews: lblTitle)
        addConstraint(visualFormat: "V:|[v0]-1-|", forViews: lblSubTitle)
        addConstraint(visualFormat: "V:[v0(0.50)]|", forViews: viewSeperator)
        
    }
}
