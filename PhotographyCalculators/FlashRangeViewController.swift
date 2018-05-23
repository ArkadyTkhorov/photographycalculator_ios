
import UIKit
import APJTextPickerView
class FlashRangeViewController: UIViewController {
    
    
    let iosList = ["100", "200", "400", "800", "1600", "3200", "6400", "12800", "25600"]
    let select_mfList = ["Meters", "Feet"]
    var selected : Int = 1
    var ios : Int = 100
    var guide_num = 0, aperture : Float = 0
    @IBOutlet weak var spinner_iso: APJTextPickerView!
    @IBOutlet weak var etxtGuideNumber: UITextField!
    @IBOutlet weak var spinner_unit: APJTextPickerView!
    @IBOutlet weak var etxtApeture: UITextField!
    
    @IBOutlet weak var etxtRange: UITextField!
    
    @IBAction func calc_range_btn_clicked(_ sender: Any) {
        
        guide_num = Int(Float(etxtGuideNumber.text!)!)
        aperture = Float(etxtApeture.text!)!
        cal(fpcGuide: Float(guide_num), fpcIso: ios, fpcAperture: aperture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextStringsPickerView()
        etxtGuideNumber.text = "0.0"
        etxtApeture.text = "0.0"
    }
    private func cal(fpcGuide : Float , fpcIso : Int , fpcAperture : Float)
    {
        var r = Float(fpcGuide * sqrt(Float(fpcIso / 100)) / fpcAperture)
        etxtRange.text = String(format: "%.2f", r)
    }
    private func initTextStringsPickerView() {
        spinner_iso.type = .strings
        spinner_iso.pickerDelegate = self as! APJTextPickerViewDelegate
        spinner_iso.dataSource = self as! APJTextPickerViewDataSource
        spinner_iso.placeholder = "100"
        
        spinner_unit.type = .strings
        spinner_unit.pickerDelegate = self as! APJTextPickerViewDelegate
        spinner_unit.dataSource = self as! APJTextPickerViewDataSource
        spinner_unit.placeholder = "Meters"
    }
    
}
extension FlashRangeViewController: APJTextPickerViewDelegate {
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        if textPickerView.tag == 1
        {
            if iosList[row] == "100"
            {
                ios = 100
            }
            else if iosList[row] == "200"
            {
                ios = 200
            }
            else if iosList[row] == "400"
            {
                ios = 400
            }
            else if iosList[row] == "800"
            {
                ios = 800
            }
            else if iosList[row] == "1600"
            {
                ios = 1600
            }
            else if iosList[row] == "3200"
            {
                ios = 3200
            }
            else if iosList[row] == "6400"
            {
                ios = 6400
            }
            else if iosList[row] == "12800"
            {
                ios = 12800
            }
            else if iosList[row] == "25600"
            {
                ios = 25600
            }
        }
        else if textPickerView.tag == 2
        {
            if select_mfList[row] == "Meters"
            {
                selected = 1
            }
            else if select_mfList[row] == "Feet"
            {
                selected = 2
            }
            else
            {
                selected = 0
            }
        }
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String?
    {
        if textPickerView.tag == 1
        {
            return iosList[row]
        }
        else if textPickerView.tag == 2
        {
            return select_mfList[row]
        }
        return ""
    }
}
extension FlashRangeViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        if pickerView.tag == 1
        {
            return iosList.count
        }
        else if pickerView.tag == 2
        {
            return select_mfList.count
        }
        return 0
    }
}

