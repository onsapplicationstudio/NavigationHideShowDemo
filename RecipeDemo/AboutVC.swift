//
//  AboutVC.swift
//  RecipeDemo
//
//  Created by Abhinay on 31/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

enum AboutSection:Int {
    case RawLogo, RawDeligence, TouchZenMedia
}

struct TouchZenMediaRecord {
    let imageName:String!
    let link:String?
}

struct RawDeligienceRecord {
    let imageName:String!
    let link:String?
}

class AboutVC:UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    //MARK:- Private Constant
    fileprivate let touchZenMediaCell = "TouchZenMediaCell"
    fileprivate let rawDeligienceCell = "RawDeligienceCell"
    fileprivate let aboutHeaderCell = "AboutHeaderCell"
    
    fileprivate let numberOfSection = 1
    
    //MARK:- Private Vars
    fileprivate var dataSourceTouchZenMedia = [TouchZenMediaRecord]()
    fileprivate var dataSourceRawDeligience = [RawDeligienceRecord]()
    fileprivate var collectionFirstContentY:CGFloat = 0.0
    fileprivate var isFirstTime = true
    fileprivate var imageHeaderFefaultHeight:CGFloat = 0.0
    
    //MARK:- Widgets
    private let imageHeader:UIImageView = {
        let imageV = UIImageView()
        imageV.image = #imageLiteral(resourceName: "AboutRawvana")
        imageV.contentMode = .scaleAspectFill
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    //MARK:- View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initialSetting()
        pageAppearance()
    }
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        collectionView?.addSubview(imageHeader)
        
        setLayout()
        setData()
        
        collectionView?.register(AboutHeaderCell.self, forCellWithReuseIdentifier: aboutHeaderCell)
        collectionView?.register(TouchZenMediaCell.self, forCellWithReuseIdentifier: touchZenMediaCell)
        collectionView?.register(RawDeligienceCell.self, forCellWithReuseIdentifier: rawDeligienceCell)
        
//        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
//            layout.headerReferenceSize = CGSize(width:collectionView!.frame.size.width, height:AboutHeaderCell.getHeightForImage(name: "AboutRawvana"))
//        }
        
        self.title = "Stretchy Header"
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if isFirstTime{
            isFirstTime = false
            collectionFirstContentY = collectionView!.contentOffset.y
        }
    }
    
    fileprivate func pageAppearance(){
        collectionView?.backgroundColor = .white
    }
    
    fileprivate func setLayout()
    {
        imageHeaderFefaultHeight = AboutVC.getHeightForImage(name: "AboutRawvana")
        updateHeaderImageFrame()
        collectionView?.contentInset = UIEdgeInsets(top: imageHeaderFefaultHeight , left: 0, bottom: 0, right: 0)
    }
    
    fileprivate func setData()
    {
        //TouchZenMedia
        dataSourceTouchZenMedia.append(TouchZenMediaRecord(imageName: "TouchZenSupport", link: ""))
        dataSourceTouchZenMedia.append(TouchZenMediaRecord(imageName: "TouchZenWebsite", link: ""))
        dataSourceTouchZenMedia.append(TouchZenMediaRecord(imageName: "TouchZenInstagram", link: ""))
        dataSourceTouchZenMedia.append(TouchZenMediaRecord(imageName: "TouchZenFacebook", link: ""))
        dataSourceTouchZenMedia.append(TouchZenMediaRecord(imageName: "TouchZenTwitter", link: ""))
        dataSourceTouchZenMedia.append(TouchZenMediaRecord(imageName: "TouchZenMore", link: ""))
        
        //Raw Deligence
        dataSourceRawDeligience.append(RawDeligienceRecord(imageName: "Rawvana_Facebook", link: ""))
        dataSourceRawDeligience.append(RawDeligienceRecord(imageName: "Rawvana_Instagram", link: ""))
        dataSourceRawDeligience.append(RawDeligienceRecord(imageName: "Rawvana_Youtube", link: ""))
        dataSourceRawDeligience.append(RawDeligienceRecord(imageName: "Rawvana_Website", link: ""))
    }
    
    //MARK:- Collection DataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let section = AboutSection(rawValue: section)!
        switch section
        {
            case .RawLogo:
                return 1
            case .TouchZenMedia:
                return dataSourceTouchZenMedia.count
            case .RawDeligence:
                return dataSourceRawDeligience.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let section = AboutSection(rawValue: indexPath.section)!
        switch section
        {
            case .RawLogo:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: aboutHeaderCell, for: indexPath) as! AboutHeaderCell
                cell.imageName = "Rawvana_Logo"
            return cell
            
            case .TouchZenMedia:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: touchZenMediaCell, for: indexPath) as! TouchZenMediaCell
                cell.record = dataSourceTouchZenMedia[indexPath.item]
                return cell
            case .RawDeligence:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rawDeligienceCell, for: indexPath) as! RawDeligienceCell
                cell.record = dataSourceRawDeligience[indexPath.item]
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let section = AboutSection(rawValue: indexPath.section)!
        switch section
        {
            case .RawLogo:
                return CGSize(width: collectionView.frame.size.width, height: AboutVC.getHeightForImage(name: "Rawvana_Logo"))
            case .TouchZenMedia:
                return CGSize(width: collectionView.frame.size.width, height: TouchZenMediaCell.CellHeight)
            case .RawDeligence:
                return CGSize(width: collectionView.frame.size.width, height: AboutVC.getHeightForImage(name: "Rawvana_Youtube"))
        }
        
    }
    
    //Scroll Delegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        updateHeaderImageFrame()
    }
    
    fileprivate func updateHeaderImageFrame()
    {
        let yPoint = collectionView!.contentOffset.y
        
        var frame = CGRect(x: 5, y: -imageHeaderFefaultHeight, width: collectionView!.frame.size.width - 10, height: imageHeaderFefaultHeight)
        
        if collectionFirstContentY > yPoint && collectionFirstContentY != 0
        {
            let diff = -(yPoint) - -(collectionFirstContentY)
            frame.origin.y = -(imageHeaderFefaultHeight + diff)
            frame.size.height = imageHeaderFefaultHeight + diff
        }
        imageHeader.frame = frame
    }
    
}

extension AboutVC
{
    static func instantiate() -> AboutVC
    {
        let flowLayout = UICollectionViewFlowLayout()
        let vc = AboutVC(collectionViewLayout: flowLayout)
        return vc
    }
}

//MARK:- UICollectionViewCell

class AboutBaseCell:UICollectionViewCell
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

class AboutHeaderCell: AboutBaseCell
{
    //MARK:-Public Var
    var imageName:String!{
        didSet{
            imageTitle.image = UIImage(named:imageName)
        }
    }
    
    //MARK:- Private Widgets
    
    private let imageTitle:UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    override func setupView()
    {
        addSubview(imageTitle)
        setLayout()
    }
    
    private func setLayout()
    {
        addConstraint(visualFormat: "H:|-5-[v0]-5-|", forViews: imageTitle)
        addConstraint(visualFormat: "V:|-5-[v0]-5-|", forViews: imageTitle)
    }
    
}

class TouchZenMediaCell:AboutBaseCell
{
    static let CellHeight:CGFloat = 44
    
    var record:TouchZenMediaRecord!{
        didSet{
            imageTitle.image = UIImage(named:record.imageName)
        }
    }
    
    //MARK:- Private Widgets
    
    private let imageTitle:UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    
    private let viewSeperator:UIView = {
        let seperator = UIView()
        seperator.backgroundColor = .lightGray
        return seperator
    }()
    
    override func setupView()
    {
        addSubview(imageTitle)
        addSubview(viewSeperator)
        setLayout()
    }
    
    private func setLayout()
    {
        addConstraint(visualFormat: "H:|-5-[v0]-5-|", forViews: imageTitle)
        addConstraint(visualFormat: "V:|[v0]-0.50-|", forViews:imageTitle)
        
        addConstraint(visualFormat: "H:|[v0]|", forViews:viewSeperator)
        addConstraint(visualFormat: "V:[v0(0.50)]|", forViews: viewSeperator)
        
    }
    
}


class RawDeligienceCell:AboutBaseCell
{
    private static let Spacing:CGFloat = 5
    
    var record:RawDeligienceRecord!{
        didSet{
            imageTitle.image = UIImage(named:record.imageName)
        }
    }
    
    //MARK:- Private Widgets
    
    private let imageTitle:UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    override func setupView()
    {
        addSubview(imageTitle)
        setLayout()
    }
    
    private func setLayout()
    {
        addConstraint(visualFormat: "H:|-\(RawDeligienceCell.Spacing)-[v0]-\(RawDeligienceCell.Spacing)-|", forViews: imageTitle)
        addConstraint(visualFormat: "V:|[v0]|", forViews: imageTitle)
    }
    
}

extension AboutVC
{
    fileprivate static func getHeightForImage(name:String) -> CGFloat
    {
        let image = UIImage(named:name)!
        let imageHeight = image.size.height
        let imageWidth = image.size.width
        
        let cellWidth = UIScreen.main.bounds.size.width - 10
        let cellHeight = (imageHeight / imageWidth) * cellWidth + 10
        return cellHeight
    }
    
}
