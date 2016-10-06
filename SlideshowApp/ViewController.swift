//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 松原秀峰 on 2016/09/28.
//  Copyright © 2016年 松原秀峰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView! //スライドショーの表示場所:Tagを1に設定
    
    @IBOutlet weak var mainTitle: UILabel! //スライドショーのタイトル表示場所
    
    @IBOutlet weak var playButton: UIButton! //再生ボタン
    
    @IBOutlet weak var nextButton: UIButton! //次へボタン
    
    @IBOutlet weak var backButton: UIButton! //戻るボタン
    
    
    var startStop = true
    
    //画像ファイルとタイトルの配列を作成する
    var imageFile: [String] = ["0_kotatu.png", "2_aruki.png", "3_densya.png", "4_shokuji.png", "1_shirei.png", "5_toujou.png", "6_bang.png"]
    
    var imageTitle: [String] = ["マナーは大事...。", "歩きスマホに", "電車スマホも", "食べながらとは\nお行儀の悪い！", "なになに？\nまたスマホのマナー違反じゃと？", "スマホ婆スターズ登場！\nマナーが守れないなら\nこうしてやるわい！", "ドッカァ〜ン!!"]
    
    //画像切替えを関数設定
    func imageChange(i:Int){
        
        mainImage.image = UIImage(named: imageFile[i])
        mainTitle.text = imageTitle[i]
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初期画像とタイトルの設定
        imageChange(0)
        mainTitle.text = imageTitle[0]
                
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    var i = 0
    var lastIndex: Int?
    
    
    @IBAction func nextView(sender: AnyObject) {
        //次へボタンの処理
        if i == imageFile.count - 1 {
            i = 0
        }else{
            i += 1
        }
        imageChange(i)
        ///lastIndex = i
    }
    
    @IBAction func backView(sender: AnyObject) {
        //戻るボタンの処理
        if i == 0{
            i = imageFile.count - 1
        }else{
            i -= 1
        }
        imageChange(i)
        //lastIndex = i
    }
    
    
    
    @IBAction func playView(sender: AnyObject) {
        //再生ボタンの処理
        if playButton.titleLabel?.text == "再生"{
            
            //再生を押した場合の各ボタンの制御
            playButton.setTitle("停止", forState: .Normal)
            nextButton.enabled = false
            backButton.enabled = false
            
            while playButton.titleLabel?.text == "再生" {
            
                var timer: NSTimer = NSTimer()
                timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.slideView), userInfo: nil, repeats: false)
            }
        
        
        }else{
            
            //停止を押した場合の各ボタンの制御
            playButton.setTitle("再生", forState: .Normal)
            nextButton.enabled = true
            backButton.enabled = true
            
            
            
            
        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //画像をタッチした場合にタグの値を返す
        let touch = touches.first! as UITouch
        
        if touch.view!.tag == 1{
            //拡大画面に遷移する
            [self.performSegueWithIdentifier("enlargedSegue", sender: self)]
            //表示する画像ファイルの指定
            
        }
    
    }

    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //    let enlargedView: EnlargedViewController = segue.destinationViewController as! EnlargedViewController
    //
    //
    //}
    
    @IBAction func backMainPage(segue: UIStoryboardSegue){
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func slideView() {
        
        if i == imageFile.count - 1 {
            i = 0
        }else{
            i += 1
        }
        imageChange(i)
    
    }
    
    }
