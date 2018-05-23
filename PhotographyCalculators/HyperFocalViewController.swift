import UIKit
import APJTextPickerView
class HyperFocalViewController: UIViewController {

    @IBOutlet weak var aSpinner: APJTextPickerView!
    @IBOutlet weak var cSpinner: APJTextPickerView!
    @IBOutlet weak var txtF: UITextField!
    
    @IBOutlet weak var txtAnswer: UILabel!
    var A = 0.0, C : Double = 0.0
    let apertureList = ["1.0", "1.1", "1.2", "1.4", "1.6", "1.8", "2.0", "2.2", "2.5", "2.8", "3.2", "3.5", "4.0", "4.5", "5.0", "5.6", "6.3", "7.1", "8.0", "9.0", "10.0", "12.0", "14.0", "16.0", "18.0", "20.0", "22.0", "25.0", "29.0", "32.0", "36.0", "40.0", "45.0", "51.0", "57.0", "60.0", "62.0", "64.0", "66.0", "68.0", "70.0"]
    
    let circle_of_confustionList = ["0.030", "0.023", "0.020", "0.019", "0.010"]
    
    @IBAction func calc_btn_clicked(_ sender: Any)
    {
        var F = txtF.text
        if (!(F?.isEmpty)! )
        {
            txtAnswer.text = "H = %.2f" + String(Calcullate_H(txtF: F!, txtA: A, txtC: C)) + ""
        }
        else
        {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextStringsPickerView()
    }
    func initTextStringsPickerView() {
        
        aSpinner.type = .strings
        aSpinner.pickerDelegate = self
        aSpinner.dataSource = self
        aSpinner.placeholder = "1.0"
        
        cSpinner.type = .strings
        cSpinner.pickerDelegate = self
        cSpinner.dataSource = self
        cSpinner.placeholder = "0.030"
    }
    func Calcullate_H(txtF : String, txtA : Double, txtC : Double) -> Double
    {
        var f = Double(txtF)
        var h = ((f! * f!) / (txtA * txtC)) + f!
        h = Double(round(h * 1000) / 1000)
        return h
    }
}
extension HyperFocalViewController: APJTextPickerViewDelegate {
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        if textPickerView.tag == 1
        {
            A = Double(apertureList[row])!
        }
        else if textPickerView.tag == 2
        {
            C = Double(circle_of_confustionList[row])!
        }
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        if textPickerView.tag == 1
        {
            return apertureList[row]
        }
        else
        {
            return circle_of_confustionList[row]
        }
    }
}

extension HyperFocalViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        if pickerView.tag == 1
        {
            return apertureList.count
        }
        else
        {
            return circle_of_confustionList.count
        }
    }
}
