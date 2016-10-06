//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 松原秀峰 on 2016/09/28.
//  Copyright © 2016年 松原秀峰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appTitle: UIImageView!   // タイトルロゴ
    @IBOutlet weak var mainImage: UIImageView!  // スライドショーの表示場所:Tagを1に設定
    @IBOutlet weak var mainTitle: UILabel!      // スライドショーのタイトル表示場所
    @IBOutlet weak var playButton: UIButton!    // 再生ボタン
    @IBOutlet weak var nextButton: UIButton!    // 次へボタン
    @IBOutlet weak var backButton: UIButton!    // 戻るボタン
    
    var timer: NSTimer = NSTimer()
    
    
    //画像ファイルとタイトルの配列を作成する
    var imageFile: [String] = ["0_kotatu.png",
                               "1_aruki.png",
                               "2_densya.png",
                               "3_shokuji.png",
                               "4_shirei.png",
                               "5_toujou.png",
                               "6_bang.png"]
    
    var imageTitle: [String] = ["マナーは大事...。",
                                "歩きスマホに",
                                "電車スマホも",
                                "食べながらとは\nお行儀の悪い！",
                                "なになに？\nまたスマホのマナー違反じゃと？",
                                "スマホ婆スターズ登場！\nマナーが守れないなら\nこうしてやるわい！",
                                "ドッカァ〜ン!!"]
    var i = 0
    var ConstPlayLabel = "再生"
    var ConstStopLabel = "停止"
    
    
    
    // MARK: - Image -
    
    //**
    /*画像を配列のインデックスから参照させる
    */
    func imageChange(i:Int){
        mainImage.image = UIImage(named: imageFile[i])
        mainTitle.text = imageTitle[i]
    }
    
    

    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初期画像とタイトルの設定
        appTitle.image = UIImage(named: "SlideTitle.png")
        imageChange(0)
        mainTitle.text = imageTitle[0]
                
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Image -
    
    //**
    /*画像切替えをインデックス順に表示する関数設定
    */
    func slideView() {
        
        if i == imageFile.count - 1 {
            // インデックス番号が最大になったら0に戻す
            i = 0
        }else{
            i += 1
        }
        imageChange(i)
    }
    
    
    
    // MARK: - Touches Event -
    
    //**
    /*画面遷移
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 画像をタッチした場合にタグの値を返す
        let touch = touches.first! as UITouch
        
        if touch.view!.tag == 1{
            // 拡大画面に遷移する
            [self.performSegueWithIdentifier("enlargedSegue", sender: self)]
        }
    }
    
    //**
    /*拡大表示画像を渡す
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let enlargedView: EnlargedViewController = segue.destinationViewController as! EnlargedViewController
        enlargedView.imageL = mainImage.image
    }
    
    
    
    // MARK: - Action -
    
    //**
    /*「次へ」ボタンの処理
     */
    @IBAction func nextView(sender: AnyObject) {
        if i == imageFile.count - 1 {
            i = 0
        }else{
            i += 1
        }
        imageChange(i)
    }
    
    //**
    /*「戻る」ボタンの処理
     */
    @IBAction func backView(sender: AnyObject) {
        if i == 0{
            i = imageFile.count - 1
        }else{
            i -= 1
        }
        imageChange(i)
    }
    
    //**
    /*「再生」ボタンの処理
     */
    @IBAction func playView(sender: AnyObject) {
        if playButton.titleLabel?.text == ConstPlayLabel{
            
            // 再生を押した場合の各ボタンの制御
            playButton.setTitle(ConstStopLabel, forState: .Normal)
            nextButton.enabled = false
            backButton.enabled = false
            
            // タイマーの設定
            timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.slideView), userInfo: nil, repeats: true)
            
        } else {
            
            // 停止を押した場合の各ボタンの制御
            playButton.setTitle(ConstPlayLabel, forState: .Normal)
            nextButton.enabled = true
            backButton.enabled = true
            
            // タイマーの解除
            timer.invalidate()
        }
    }
    
    //**
    /*遷移画面から「戻る」ボタンの処理
     */
    @IBAction func backMainPage(segue: UIStoryboardSegue){
        
    }
    
    
    }
