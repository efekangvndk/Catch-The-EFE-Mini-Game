//
//  ViewController.swift
//  CathTheEfeGame
//
//  Created by Efekan Güvendik on 26.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // ---------Variables---------
    
    var score = 0
    var timerCounter = Timer()
    var counter = 0
    var efeArray = [UIImageView]() // burda Imagelar için bir dizi tanımladıkki tek tek 9 tanesi ile uğraşmayalım gizlerken.
    var hideTimer = Timer() //bir tane daha timer yaptık bunuda image lerin gizlenme süresi olsun diye.
    var highScore = 0
   
    // --------- Views ---------
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var resim9: UIImageView!
    @IBOutlet weak var resim8: UIImageView!
    @IBOutlet weak var resim7: UIImageView!
    @IBOutlet weak var resim6: UIImageView!
    @IBOutlet weak var resim5: UIImageView!
    @IBOutlet weak var resim4: UIImageView!
    @IBOutlet weak var resim3: UIImageView!
    @IBOutlet weak var resim2: UIImageView!
    @IBOutlet weak var resim1: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pxfuel")!)
        
        //highScoreCheck
        let storedHighScore = UserDefaults.standard.object(forKey: "hihgscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        scoreLabel.text = "Score : \(score)"
    
    
    // --------- Recognizer ---------
        resim1.isUserInteractionEnabled = true      //kullanıcının resme tıklanabilir hale getirmesini sağlar.
        resim2.isUserInteractionEnabled = true      //maalesef bunuda 9x kez yazmam lazım :D :D :D
        resim3.isUserInteractionEnabled = true
        resim4.isUserInteractionEnabled = true
        resim5.isUserInteractionEnabled = true
        resim6.isUserInteractionEnabled = true
        resim7.isUserInteractionEnabled = true
        resim8.isUserInteractionEnabled = true
        resim9.isUserInteractionEnabled = true
        
        
        scoreLabel.text = "Score : \(score)"
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))    //yukarıda resme tıklanabilirliği açdık
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))    //şimdi ise bunların kendine tıklattıran kodu
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))    //kodu tanımladık.
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        resim1.addGestureRecognizer(recognizer1)    //hepsini birbirne bağladık
        resim2.addGestureRecognizer(recognizer2)
        resim3.addGestureRecognizer(recognizer3)
        resim4.addGestureRecognizer(recognizer4)
        resim5.addGestureRecognizer(recognizer5)
        resim6.addGestureRecognizer(recognizer6)
        resim7.addGestureRecognizer(recognizer7)
        resim8.addGestureRecognizer(recognizer8)
        resim9.addGestureRecognizer(recognizer9)
        
        efeArray = [resim1,resim2,resim3,resim4,resim5 ,resim6,resim7,resim8,resim9] //bu bu şekilde de olabilir. efeArray.append(resim1)
                                                                                     //ama bu şekilde çok uzun sürerdi kısa yolu tercih ettik.
        
        // --------- Timers ---------
        counter = 10
        timer.text = "\(counter)"       //bu şekilde String(counter) ile aynı şeyi demiş olduk.
        
        timerCounter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown ), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideEfe), userInfo: nil, repeats: true)
        
        hideEfe()                                   //burada bir efehide çağırmam lazımki gözüksün bunu viewDidLoad içinde yapıcaz.

    }
    
    // --------- Hide ------------
    
   @objc func hideEfe(){ //istediğimiz saklama işleminin func burada yazıcaz sonra select ile tanımlarır.
        //bunu uzun yoldan bu yol ile resim1.isHidden = true kısa yoldan ise for loop ile yaparız sonuçda bir dizimiz var.
        for resim in efeArray {
            resim.isHidden = true
        }
            let random = Int(arc4random_uniform(UInt32(efeArray.count - 1)))
            efeArray[random].isHidden = false

        }
    
    
    @objc func increaseScore(){ //burada yukarıda yapmış olduğumuz func ile ne amaçladığımızı yani tıklandığında ne olucağını yazıcaz.
         score += 1
        scoreLabel.text = "Score: \(score) "
        
    }

    
    
    
    @objc func countDown(){ //burada timerCounter içindeki işlem için bir objec func açdık ve işlevi geri sayım yapmak.
        counter -= 1
        timer.text = "Time: \(counter)"
        
        if counter == 0 {
            timerCounter.invalidate()
            hideTimer.invalidate()
            timer.text = "Game Over."
            for resim in efeArray {
                resim.isHidden = true
            }
            
            if self.score > self.highScore{
                self.highScore = self.score + self.highScore
                highScoreLabel.text = "Higscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
        // --------- Alert ---------
            let alert = UIAlertController(title: "Times İs Up", message: "Do You Want Try Again. ", preferredStyle: UIAlertController.Style.alert )
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel )
            let repButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //normalde burada bişey istemez ve nil hatta yazmazdık ancak şuanda istiyoruz ne istiyoruz oyunun başdan başmalasını.
                //replay Func yazıcaz.
                self.score = 0   //bunu dumdüz score yazarsak bize hangi score olduğunu anlamdığını söyler bunun için self yazıcaz ki en başdaki olduğunu                 anlasın
                self.scoreLabel.text = "Score: \(self.score) "
                self.counter = 10
                self.timer.text = "\(self.counter)"   //score ve counter resetlenmiş oldu
                
                self.timerCounter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown ), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideEfe), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(repButton)
            //bu alertleri göstermek için geçmişde öğrendiğimiz self.present kullanırız.
            self.present(alert, animated: true,completion: nil)
             
            
                }
            }
        }



        

    
    


