
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    //Timer型の「timer」という変数
    var timer : Timer?
    //変数countをInt型に指定
    var count = 0
    
    let settingKey = "timer_value"
    


    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        //UserDefaultsに初期値を設定
        settings.register(defaults: [settingKey:10])
     
    }


    @IBAction func settingButton(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true{
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerInterupt(_:)), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButton(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true{
                nowTimer.invalidate()
            }
        }
    }
        func displayUpdate() -> Int {
            let settings = UserDefaults.standard
            let timerValue = settings.integer(forKey: settingKey)
            let remainCount = timerValue - count
            countDownLabel.text = "残り\(remainCount)　秒"
            return remainCount
        }
    
    @objc func timerInterupt(_ timer:Timer){
        count += 1
        if displayUpdate() <= 0{
            count = 0
            timer.invalidate()
            let alertController = UIAlertController(title: "終了", message: "タイマー終了です", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        
        _ = displayUpdate()
    }
        
    
    
    
    
}

