//
//  VideoCell.swift
//  PlayLocalVideo_Leon
//
//  Created by lai leon on 2017/8/21.
//  Copyright © 2017 clem. All rights reserved.
//

/*什么时候该用值类型：
要用==运算符来比较实例的数据时
你希望那个实例的拷贝能保持独立的状态时
数据会被多个线程使用时
什么时候该用引用类型（class）：
要用==运算符来比较实例身份的时候
你希望有创建一个共享的、可变对象的时候*/

import UIKit

struct VideoModel {
    let image: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {
/*
     Public:所有都可以访问
     Internal:自己framework访问（默认）
     Private:私有的
     总的来说，默认就行，不公开就private，写框架的话，就需要public公开接口
     */
    let videoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: YHScreenWidth, height: YHScreenHeight / 3))
    let videoTitle = UILabel(frame: CGRect(x: 0, y: YHScreenHeight / 3 - 50, width: YHScreenWidth, height: 30))
    let videoSource = UILabel(frame: CGRect(x: 0, y: YHScreenHeight / 3 - 20, width: YHScreenWidth, height: 20))
    private let videoPlay = UIImageView(frame: CGRect(x: 0, y: 0, width: YHScreenWidth, height: YHScreenHeight / 3))

    private func setupView() {
        videoImage.contentMode = .scaleAspectFill
        videoPlay.contentMode = .center
        videoPlay.image = UIImage(named: "playBtn")
        videoTitle.textColor = .white
        videoTitle.textAlignment = .center
        videoTitle.font = UIFont(name: "Zapfino", size: 24)
        videoSource.textColor = .gray
        videoSource.textAlignment = .center
        videoSource.font = UIFont(name: "Avenir Next", size: 14)
        contentView.addSubview(videoImage)
        contentView.addSubview(videoTitle)
        contentView.addSubview(videoSource)
        contentView.addSubview(videoPlay)
    }

    func setModel(model: VideoModel){
        videoImage.image = UIImage(named: model.image)
        videoTitle.text = model.title
        videoSource.text = model.source
    }

    //http://www.jianshu.com/p/66ecd88b4210
    //当我们使用storyboard实现界面的时候，程序会调用这个初始化器。
    //当我们在子类定义了指定初始化器(包括自定义和重写父类指定初始化器)，那么必须显示实现required init?(coder aDecoder: NSCoder)，
    //而其他情况下则会隐式继承，我们可以不用理会。
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
}
