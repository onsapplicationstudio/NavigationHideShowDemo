//
//  RecipeDetailPageVC.swift
//  RawDiligence
//
//  Created by Abhinay on 14/08/18.
//  Copyright © 2018 Cyrus Kiani. All rights reserved.
//

import UIKit

class RecipeDetailPageVC:UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    //MARK:- Constant
    fileprivate let cellID = "RecipeInfoCell"
    fileprivate let headerID = "RecipeHeader"
    fileprivate let totalSections = 3
    fileprivate let imageHeight:CGFloat = 210.0
    fileprivate let statusHeight = UIApplication.shared.statusBarFrame.height
    
    //MARK:- Widgets
    fileprivate let footerButton:UIButton = {
        let button = UIButton()
        button.setTitleShadowColor(UIColor.getColorFromRGB(red: 128, green: 128, blue: 128, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor.getColorFromRGB(red: 114, green: 36, blue: 60, alpha: 1.0)
        button.setTitle("Tap to Complete", for: .normal)
        return button
    }()
    
    fileprivate let checkMarkButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "TapGray.png"), for: .normal)
        return button
    }()
    
    fileprivate let topBar:UIView =
    {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        let rect = CGRect(x: 0, y: -statusHeight, width: UIScreen.main.bounds.width, height: statusHeight * 2)
        let view = UIView(frame: rect)
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        pageAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView?.reloadData()
    }
    
   
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        view.addSubview(topBar)
        view.addSubview(footerButton)
        view.addSubview(checkMarkButton)
        
        setUpLayout()
        
        collectionView?.register(RecipeInfoCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(RecipeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.minimumLineSpacing = 0
            layout.headerReferenceSize = CGSize(width: collectionView?.frame.size.width ?? 0, height: 210.0)
        }
    }
    
    fileprivate func pageAppearance()
    {
        collectionView?.backgroundColor = UIColor.white
        hideNavBar()
    }
    
    fileprivate func setUpLayout()
    {
        view.addConstraint(visualFormat: "H:|[v0]|", forViews: footerButton)
        view.addConstraint(visualFormat: "H:|[v0]|", forViews: collectionView!)
        view.addConstraint(visualFormat: "H:[v0(20)]-10-|", forViews: checkMarkButton)
        
        view.addConstraint(visualFormat: "V:|[v0][v1(50)]|", forViews:collectionView!, footerButton)
        view.addConstraint(visualFormat: "V:[v0(20)]", forViews: checkMarkButton)
        
        checkMarkButton.centerYAnchor.constraint(equalTo: footerButton.centerYAnchor).isActive = true
    }
    
    fileprivate func hideNavBar()
    {
        if let navVC = self.navigationController{
            navVC.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navVC.navigationBar.shadowImage = UIImage()
            navVC.view.backgroundColor = .clear
            
            navVC.navigationBar.isTranslucent = true
            navVC.navigationBar.backgroundColor = UIColor.white.withAlphaComponent(0)
            navVC.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24.0), NSAttributedStringKey.foregroundColor:UIColor.getColorFromRGB(red: 61, green: 183, blue: 163, alpha: 1.0)]
            
            self.navigationItem.title = ""
        }
        
    }
    
    
    //MARK:- CollectionView Delegates DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RecipeInfoCell
        
        var desText = ""
        var title = ""
        
        switch indexPath.item {
        case 2:
            title = "Benefit"
            desText = "Fresh fruit contains living enzymes that aid in digestion and assimilation. This delicious smoothie contains Vitamins B1, B6, A, C, Magnesium, Manganese, Potassium, Folate, Iron, Phosphorus, Zinc, and Protein.Hemp seed is a POWERHOUSE of the most digestible form of protein, along with 20 amino acids including 8 essential amino acids. It also contains Omega-3, Omega-6, Vitamin A, Fiber, Iron, and Potassium. Hemp seed has a mild flavor, and blends well in smoothies!"
        case 1:
            title = "Method"
            desText = "Blend ALL ingredients in a blender until smooth. Add more or less liquid to adjust consistency. Pour smoothie into a chilled glass, garnish with an orange slice, and ENJOY!"
            
        case 0:
            title = "Humboldt Smoothie"
            desText = "• 8 oz. raw coconut water\n• 2 oranges\n• 2 apples\n• 1 banana\n• 1 cup of blackberries\n• 1-2 tbs. hemp seed (optional)"
        default:
            desText = ""
        }
        cell.descriptionLabel.text = desText
        cell.titleLabel.text = title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var height = RecipeInfoCell.Constant.TitleLabelHeight
        
        var desText = ""
        
        switch indexPath.item {
        case 2:
            desText = "Fresh fruit contains living enzymes that aid in digestion and assimilation. This delicious smoothie contains Vitamins B1, B6, A, C, Magnesium, Manganese, Potassium, Folate, Iron, Phosphorus, Zinc, and Protein.Hemp seed is a POWERHOUSE of the most digestible form of protein, along with 20 amino acids including 8 essential amino acids. It also contains Omega-3, Omega-6, Vitamin A, Fiber, Iron, and Potassium. Hemp seed has a mild flavor, and blends well in smoothies!"
        case 1:
            desText = "Blend ALL ingredients in a blender until smooth. Add more or less liquid to adjust consistency. Pour smoothie into a chilled glass, garnish with an orange slice, and ENJOY!"
            
        case 0:
            desText = "• 8 oz. raw coconut water\n• 2 oranges\n• 2 apples\n• 1 banana\n• 1 cup of blackberries\n• 1-2 tbs. hemp seed (optional)"
        default:
            desText = ""
        }
        
        height += desText.height(withConstrainedWidth: collectionView.frame.size.width, font: RecipeInfoCell.Constant.DesLabelTextFont) + 10.0
        return CGSize(width: collectionView.frame.size.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath)
        return view
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.contentOffset.y <= 0{
            scrollView.setContentOffset(CGPoint.zero, animated: false)
        }
        
        if scrollView.contentOffset.y >= 205{
            UIApplication.shared.statusBarStyle = .default
        }
        else if scrollView.contentOffset.y < 205{
            UIApplication.shared.statusBarStyle = .lightContent
        }
        showNavigationBarAccordingToYOffset(offset: scrollView.contentOffset.y)
    }
    
    fileprivate func showNavigationBarAccordingToYOffset(offset:CGFloat)
    {
        let requiredYOffset = imageHeight - statusHeight - (navigationController?.navigationBar.frame.size.height)! + 2
        
        self.navigationItem.title = ""
        if offset >= requiredYOffset
        {
            let titleHeight = RecipeInfoCell.Constant.TitleLabelHeight
            let currentHeight = offset - requiredYOffset
            let alpha = currentHeight / titleHeight
            self.topBar.alpha = alpha
            self.navigationController?.navigationBar.backgroundColor = UIColor.white.withAlphaComponent(alpha)
            if alpha >= 0.90{
                self.navigationItem.title = "Humboldt Smoothie"
            }
        }else{
            self.topBar.alpha = 0
            self.navigationController?.navigationBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        }
        
    }
    
}

//MARK:- UICollectionViewCell

class RecipeBaseCell:UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpViews(){
        
    }
}

//---------------- RecipeInfo Cell -------------------

class RecipeInfoCell: RecipeBaseCell
{
    fileprivate let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = UIColor.getColorFromRGB(red: 249, green: 249, blue: 249, alpha: 1.0)
        label.textColor = UIColor.getColorFromRGB(red: 61, green: 183, blue: 163, alpha: 1.0)
        label.textAlignment = .center
        label.text = "Humboldt Smoothie"
        label.font = UIFont.systemFont(ofSize: 24.0)
        return label
    }()
    
    fileprivate let descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.getColorFromRGB(red: 31, green: 31, blue: 31, alpha: 1.0)
        
        label.text = ""
        label.font = RecipeInfoCell.Constant.DesLabelTextFont
        label.backgroundColor = .clear
        return label
    }()
    
    
    override fileprivate func setUpViews()
    {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        setUpLayout()
    }
    
    fileprivate func setUpLayout(){
        addConstraint(visualFormat: "H:|[v0]|", forViews: titleLabel)
        addConstraint(visualFormat: "H:|-20-[v0]-20-|", forViews: descriptionLabel)
         addConstraint(visualFormat: "V:|[v0(\(RecipeInfoCell.Constant.TitleLabelHeight))]-5-[v1]-5-|", forViews: titleLabel, descriptionLabel)
    }
    
}

extension RecipeInfoCell
{
    struct Constant {
        static let TitleLabelHeight:CGFloat = 47
        static let DesLabelTextFont = UIFont.systemFont(ofSize: 14.0)
    }
}

//---------------- RecipeHeader Cell -------------------

class RecipeHeader:RecipeBaseCell
{
    fileprivate let topImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "CabbageWraps1.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override fileprivate func setUpViews()
    {
        addSubview(topImageView)
        
        setUpLayout()
    }
    
    fileprivate func setUpLayout(){
        addConstraint(visualFormat: "H:|[v0]|", forViews: topImageView)
        addConstraint(visualFormat: "V:|[v0]|", forViews: topImageView)
    }
}


extension RecipeDetailPageVC
{
    static func instantiate() -> RecipeDetailPageVC
    {
        let layout = UICollectionViewFlowLayout()
        let vc = RecipeDetailPageVC(collectionViewLayout: layout)
        return vc
    }
}

//Extension----
extension UIView
{
    func addConstraint(visualFormat format:String, forViews: UIView...)
    {
        var dict = [String:UIView]()
        for (index, view) in forViews.enumerated()
        {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            dict[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: dict))
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UIColor
{
    static func getColorFromRGB(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) -> UIColor
    {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
