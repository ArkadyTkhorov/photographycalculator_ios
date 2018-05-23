import Foundation
import UIKit
class FoVController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var ratioField: UITextField!
    @IBOutlet weak var focus_lengthField: UITextField!
    @IBOutlet weak var sensor_crop_editorField: UITextField!
    
    @IBOutlet weak var hori_field: UITextField!
    @IBOutlet weak var vert_field: UITextField!
    @IBOutlet weak var diag_field: UITextField!
    let ratioArray = ["3:2(Most DSLRs)","4:3(Some Camera Phones)","16:9(Some Camera Phones)"]
    var sensor_ratio_d : Double = 0.0
    var focus_length_d : Double = 0.0
    var sensor_crop_d : Double = 0.0
    
    
    var pickView = UIPickerView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickView.delegate = self
        pickView.dataSource = self
        ratioField.inputView = pickView
        ratioField.textAlignment = .center
        ratioField.placeholder = "3:2(Most DSLRs)"
        
        focus_lengthField.text = "28"
        sensor_crop_editorField.text = "1.0"
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return ratioArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ratioArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TODO
        ratioField.text = ratioArray[row]
        ratioField.resignFirstResponder()
        if ratioField.text == "3:2(Most DSLRs)"
        {
            sensor_ratio_d = 1.5
        }
        else if ratioField.text == "4:3(Some Camera Phones)"
        {
            sensor_ratio_d = 1.3333333334

        }
        else if ratioField.text == "16:9(Some Camera Phones)"
        {
            sensor_ratio_d = 1.781
        }
    }
    @IBAction func calbtnClicked(_ sender: UIButton) {
        let flen = Double(focus_lengthField.text!)
        var flen_mult = Double(sensor_crop_editorField.text!)
        let aspect = sensor_ratio_d
        var film_width_35 = 36.0
        var film_height_35 = 24.0
        let film_diag_35 = (sqrt(Double((film_width_35 * film_width_35) + (film_height_35 * film_height_35))))
        film_height_35 = sqrt( (film_diag_35*film_diag_35)/((aspect*aspect) + 1) );
        film_width_35 = aspect * film_height_35
        if (flen_mult?.isZero)! || flen_mult! <= 0.0
        {
            flen_mult = 1
        }
        let sensor_width = film_width_35/flen_mult!
        let sensor_height = film_height_35/flen_mult!
        let sensor_diag = (sqrt((sensor_width * sensor_width) + (sensor_height * sensor_height)))
        
        let fov_h : Double = (2 * atan(sensor_width / (2 * flen!)) * 180 / 3.141592)
        let fov_h_s : String = String(dec1(aNumber: fov_h))
        hori_field.text = ""
        hori_field.insertText(fov_h_s)
        
        let fov_v : Double = (2 * atan(sensor_height / (2 * flen!)) * 180 / 3.141592)
        let fov_v_s : String = String(dec1(aNumber: fov_v))
        vert_field.text = ""

        vert_field.insertText(fov_v_s)
        
        let fov_d : Double = (2 * atan(sensor_diag / (2 * flen!)) * 180 / 3.141592)
        let fov_d_s : String = String(dec1(aNumber: fov_d))
        diag_field.text = ""
        diag_field.insertText(fov_d_s)
        
    }
    
}
extension FoVController{
    func rnd(aNumber : Double, decimal_place : Double) -> Double {
        if aNumber.isNaN
        {
            return aNumber
        }
        let mult = pow(10,decimal_place)
        return round(aNumber*mult)/mult
    }
    func dec1(aNumber : Double) -> Double {
        return rnd(aNumber: aNumber, decimal_place: 1)
    }
}
