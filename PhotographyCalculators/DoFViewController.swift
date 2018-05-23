//
//  DoFViewController.swift
import UIKit
import APJTextPickerView

class DoFViewController: UIViewController {
    
    var selected : Int = 0
    var dist = 0.0, coc_mm = 0.0, coc = 0.0, flen_mm = 0.0, flen = 0.0, aperture : Double = 0.0
    var mm_2_feet = (1 / 304.8)
    var feet_2_mm = 304.8
    var d_near_dist = "", d_far_dist = "", d_depth_of_field = "", d_depth_of_focus : String  = ""
    
    @IBOutlet weak var select_mf: APJTextPickerView!
    
    @IBOutlet weak var subject_distance_field: UITextField!
    @IBOutlet weak var lens_focal_length_field: UITextField!
    @IBOutlet weak var lens_aperture_field: UITextField!
    @IBOutlet weak var circle_of_confusion_field: UITextField!
    
    
    @IBOutlet weak var near_focus_field: UITextField!
    @IBOutlet weak var far_focus_field: UITextField!
    @IBOutlet weak var depth_of_field: UITextField!
    @IBOutlet weak var depth_of_focus_field: UITextField!
    
    var select_mfList = ["Meters", "Feet"]
    @IBAction func calcuate_btn_clicked(_ sender: Any) {
        if selected == 2
        {
            dist = Double(subject_distance_field.text!)!
            coc_mm = Double(circle_of_confusion_field.text!)!
            coc = coc_mm * mm_2_feet
            flen_mm = Double(lens_focal_length_field.text!)!
            flen = flen_mm * mm_2_feet
            aperture = Double(lens_aperture_field.text!)!
            if flen_mm.isNaN || coc_mm.isNaN || dist.isNaN || aperture.isNaN
            {
                return;
            }
            let tmp = (aperture * coc * (dist - flen)) / (flen * flen)
            
            var dist_far : String
            if tmp >= 1
            {
                dist_far = "inf"
            }
            else
            {
                dist_far = String(dist / (1 - tmp))
            }
            
            let dist_near : Double = dist / (1 + tmp)
            var depth_of_field : String
            if tmp < 1
            {
                depth_of_field = String(Double(dist_far)! - dist_near);
            }
            else
            {
                depth_of_field = "inf"
            }
            let hyper_focal : Double = (flen * flen) / (aperture * coc)
            
            let depth_of_focus : Double = (flen * flen * dist) / (hyper_focal * (dist - flen))
            
            d_near_dist = feet_inches(aNumber: dist_near)
            if depth_of_field == "inf"
            {
                d_far_dist = "inf"
            }
            else
            {
                d_far_dist = feet_inches(aNumber: Double(dist_far)!)
            }
            if depth_of_field == "inf"
            {
                d_depth_of_field = "inf"
            }
            else
            {
                d_depth_of_field = feet_inches(aNumber: Double(depth_of_field)!)
            }
            d_depth_of_focus = String(dec4(aNumber: depth_of_focus * 12)) + "\""
        }
        else if selected == 1
        {
            dist = Double(subject_distance_field.text!)!
            dist = dist * 1000 * mm_2_feet
            coc_mm = Double(circle_of_confusion_field.text!)!
            coc = coc_mm * mm_2_feet;
            flen_mm = Double(lens_focal_length_field.text!)!
            flen = flen_mm * mm_2_feet;
            aperture = Double(lens_aperture_field.text!)!
            if flen_mm.isNaN || coc_mm.isNaN || dist.isNaN || aperture.isNaN
            {
                return;
            }
            let tmp = (aperture * coc * (dist - flen)) / (flen * flen)
            var dist_far : String = ""
            if tmp >= 1
            {
                dist_far = "inf"
            }
            else
            {
                dist_far = String(dist / (1 - tmp))
            }
            let dist_near = dist / (1 + tmp)
            var depth_of_field : String
            if tmp < 1
            {
                depth_of_field = String(Double(dist_far)! - dist_near)
            }
            else
            {
                depth_of_field = "inf"
            }
            let hyper_focal = (flen * flen) / (aperture * coc)
            let depth_of_focus = (flen * flen * dist) / (hyper_focal * (dist - flen))
            d_near_dist = meters(aNumber: dist_near)
            if depth_of_field == "inf"
            {
                d_far_dist = "inf"
            }
            else
            {
                d_far_dist = meters(aNumber: Double(dist_far)!)
            }
            if depth_of_field == "inf"
            {
                d_depth_of_field = "inf"
            }
            else
            {
                d_depth_of_field = meters(aNumber: Double(depth_of_field)!)
            }
            d_depth_of_focus = String(dec4(aNumber: (feet_2_mm * depth_of_focus)/10)) + "cm"
        }
        near_focus_field.text = d_near_dist
        far_focus_field.text = d_far_dist
        depth_of_field.text = d_depth_of_field
        depth_of_focus_field.text = d_depth_of_focus
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextStringsPickerView()
        subject_distance_field.text = "5"
        lens_focal_length_field.text = "50"
        lens_aperture_field.text = "8.0"
        circle_of_confusion_field.text = "0.030"
    }
    private func initTextStringsPickerView() {
        select_mf.type = .strings
        select_mf.pickerDelegate = self as APJTextPickerViewDelegate
        select_mf.dataSource = self as APJTextPickerViewDataSource
        select_mf.placeholder = "Meters"
    }

}
extension DoFViewController: APJTextPickerViewDelegate {
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
//        print("City Selected: \(strings[row])")
        textPickerView.resignFirstResponder()
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
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        return select_mfList[row]
    }
}

extension DoFViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        return select_mfList.count
    }
}
extension DoFViewController{
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
    func dec2(aNumber : Double) -> Double {
        return rnd(aNumber: aNumber, decimal_place: 2)
    }
    func dec4(aNumber : Double) -> Double {
        return rnd(aNumber: aNumber, decimal_place: 4)
    }
    func meters(aNumber : Double) -> String{
        if aNumber.isNaN
        {
            return (String(aNumber) + "")
        }
        let mm = aNumber * feet_2_mm
        let m = floor(mm / 1000)
//        2.5.truncatingRemainder(dividingBy: 1.1)
        let cm = dec2(aNumber: (mm / 10).truncatingRemainder(dividingBy: 100))
        return String(Int(m)) + "m " + String(cm) + "cm"
    }
    func feet_inches(aNumber : Double) -> String{
        if aNumber.isNaN
        {
            return (String(aNumber) + "")
        }
        let feet = floor(aNumber)
        let inches = dec1(aNumber: (aNumber.truncatingRemainder(dividingBy: 1)) * 12)
        return String(Int(feet)) + "' " + String(Int(inches)) + "\""
    }
}
