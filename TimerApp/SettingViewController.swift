
import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
 
    let settingArray : [Int] = [10,20,30,40,50,60]
    //設定値を覚えるキー設定
    let settingKey = "timer_value"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        
        for row in 0..<settingArray.count{
            if settingArray[row] == timerValue{
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
        

    }
    
    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    
    @IBAction func decisionButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let settings = UserDefaults.standard
        settings.setValue(settingArray[row], forKey: settingKey)
        settings.synchronize()
    }
    
    
    
}
