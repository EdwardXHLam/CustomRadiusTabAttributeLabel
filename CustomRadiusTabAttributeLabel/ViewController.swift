//
//  ViewController.swift
//  CustomRadiusTabAttributeLabel
//
//  Created by YZ-LXH on 2021/11/19.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var registrationLabel: UILabel = {
        
        let registrationLabel = UILabel(frame: CGRect(x: 10, y: 64, width: view.frame.size.width - 20, height: 200))
        
        registrationLabel.numberOfLines = 0
        
        view.addSubview(registrationLabel)
        
        return registrationLabel
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let att = generalImageTabAttribute(titleString: "动漫《海贼王》漫画第一千零三十二话更新了，此次剧情之中，火灾烬和索隆战斗期间展现出了骚操作，很是亮眼，搞笑成分不比疫灾奎因的腕龙蛇差，除此之外就是鬼之岛战场内出现了一位本不该出现的人物，就是光月日和，并且装扮成花魁小紫的样子，弹奏二胡来协助索隆，漫画说是弹奏三味线，接下来具体说明。", imgName: "baominging", tabInfo: "火热报名")
        
        registrationLabel.attributedText = att
    }

    open func generalImageTabAttribute(titleString: String?,backWardFontColor: UIColor = .black, imgName: String?, tabInfo: String?, highLightFontSize: CGFloat = 10, highLightFontColor: UIColor = .white, tabLabelHeight: CGFloat = 18, highLightBgColor: UIColor = .purple, cornerRadius: CGFloat = 5, attchX: CGFloat = 0,attchY: CGFloat = -3) -> NSAttributedString {

        let maTitleString = NSMutableAttributedString(string: " \(titleString ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular),.foregroundColor:backWardFontColor])

        let bgView = UIView()
        
        let targetimage = UIImage.init(named: imgName ?? "")
        
        let imageV = UIImageView()
        
        imageV.image = targetimage
        
        bgView.addSubview(imageV)
        
        let aaL = UILabel()
        
        aaL.text = " \(tabInfo ?? "")"
        
        aaL.font = UIFont.systemFont(ofSize: highLightFontSize, weight: UIFont.Weight.semibold)
        
        aaL.textColor = highLightFontColor
        
        aaL.textAlignment = .center
        
        bgView.addSubview(aaL)
        
        let actualWidth:CGFloat = aaL.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: tabLabelHeight)).width
        
        let getFinalHeight:CGFloat
        
        if CGFloat(targetimage?.size.height ?? 0) > tabLabelHeight {
            
            getFinalHeight = CGFloat(targetimage?.size.height ?? 0)
            
        } else {
            
            getFinalHeight = tabLabelHeight
        }
        
        let getFinalWidth:CGFloat = CGFloat(targetimage?.size.width ?? 0) + actualWidth + 6
        
        bgView.frame = CGRect(x: 0, y: 0, width: getFinalWidth, height: getFinalHeight)
        
        aaL.frame = CGRect(x: CGFloat(targetimage?.size.width ?? 0 + 2.5), y: (getFinalHeight - tabLabelHeight)/2, width: actualWidth, height: tabLabelHeight)
        
        imageV.frame = CGRect(x: 2.5, y: (getFinalHeight - (CGFloat(targetimage?.size.height ?? 0)))/2, width: CGFloat(targetimage?.size.width ?? 0), height: CGFloat(targetimage?.size.height ?? 0))
        
        bgView.backgroundColor = highLightBgColor
        
        if cornerRadius > 0 {
            
            bgView.layer.cornerRadius = cornerRadius
            
            bgView.layer.masksToBounds = true
        }
        //暂存
        view.addSubview(bgView)
        
        let image = convertViewToImage(view: bgView)
        
        let attach = NSTextAttachment()
        
        attach.bounds = CGRect(x: attchX, y: attchY, width: getFinalWidth, height: getFinalHeight)
        
        attach.image = image
        
        let imageStr = NSAttributedString(attachment: attach)
        
        maTitleString.insert(imageStr, at: 0)
        
        bgView.removeFromSuperview()
        
        return maTitleString
    }
    
    
    private func convertViewToImage(view: UIView) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale)
        
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let imageRet = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imageRet
    }
}



