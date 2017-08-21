//
//  ViewController.swift
//  PlayLocalVideo_Leon
//
//  Created by lai leon on 2017/8/20.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

let YHScreenRect: CGRect = UIScreen.main.bounds
let YHScreenWidth: CGFloat = UIScreen.main.bounds.width
let YHScreenHeight: CGFloat = UIScreen.main.bounds.height

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: YHScreenRect, style: .plain)
    let reuseIdentifier = "VideoCell"
    let data = [
        VideoModel(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        VideoModel(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        VideoModel(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
        VideoModel(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
        VideoModel(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
        VideoModel(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
    ]

    var playViewController: AVPlayerViewController?
    var playView: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playView = nil
        playViewController = nil
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func playVideo(){
        /*
         错误处理：
         1.throwing，把函数抛出的错误传递给调用此函数的代码
         2.do-catch
         3.将错误作为可选类型处理
         4.断言此错误根本不会发生
         */
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        if (path == nil){
            print("没有该文件！")
            return
        }
        //由于返回了可选类型，并且通过上方判断，可以确定是有值的，然后强制解包
        playView = AVPlayer(url: URL(fileURLWithPath: path!))
        playViewController = AVPlayerViewController()
        playViewController?.player = playView
        self.present(playViewController!, animated: true){
            self.playView?.play()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         !强制解析值，解析前一定确保可选是有值的

         类型转换：
            as?:返回一个向下转型的类型的可选值
            as!:强制转型，并且解包
            is:检查能够向下转化成指定类型
            as:向上转换成超类
         当不确定是否可以转成功时，用as?，确定时，用as!
        */
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VideoCell
        cell.setModel(model: data[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        playVideo()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return YHScreenHeight/3
    }
}
