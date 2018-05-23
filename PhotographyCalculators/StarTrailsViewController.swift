import Foundation
import UIKit
import APJTextPickerView
class StarTrailsViewController: UIViewController
{
    
    @IBOutlet weak var sensor_field: APJTextPickerView!
    @IBOutlet weak var iso_field: APJTextPickerView!
    @IBOutlet weak var aperture: APJTextPickerView!
    @IBOutlet weak var focal_length: APJTextPickerView!
    @IBOutlet weak var speed_time_tv: UILabel!
    @IBOutlet weak var warning_tv: UILabel!
    
    let sensorList = ["Full-Frame", "ASP-C", "ASP-H", "4:3", "1"]
    let focal_lengthList =
        ["8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20mm","24mm","28mm","35mm","50mm","55mm","70mm","85mm","100mm","105mm","135mm","200mm","300mm","400mm","500mm","600mm","800mm","1000mm","1500mm","2000mm"]
    let apertureList = ["1","1.1","1.2","1.4","1.6","1.8","2","2.2","2.5","2.8","3.3","3.5","4","4.5","5","5.6","6.3","7.1","8","9","10","11","13","14","16","18","20","22","32"]
    let isoList = ["25","50","64","100","200","400","800","1000","1600","3200","6400","12800","25600","51200"]
    var sensor_field_str : String = ""
    var focal_num : Double = 0.0
    var apecture_num : Double = 0.0
    var iso_num : Double = 0.0
    
    var sensor_field_d :Double = 0
    var focal_length_d : Double = 0
    var aperture_d : Double = 0
    var iso_d : Double = 0
    
    var recommendedISO : Double = 0.0
    var recommendedShutterspeed : Double = 0.0
    var ISOFactor : Double = 0.0
    
    var width : Double =  0.0
    var cropFactor : Double = 0.0
    var height : Double = 0.0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTextStringsPickerView()
    }
    func CalcExposure()
    {
        var starTrails : Bool = false
        var otherISO : Bool = false
        if sensor_field_str == "FX" || sensor_field_str == "35mm"
        {
            width = 36.0
            height = 24.0
            cropFactor = 1.0
        }
        else if sensor_field_str == "NkAPSC"
        {
            width = 23.6
            height = 15.8
            cropFactor = 1.52
        }
        else if sensor_field_str == "SoAPSC"
        {
            width = 23.5
            height = 15.6
            cropFactor = 1.52
        }
        else if sensor_field_str == "PeAPSC"
        {
            width = 23.4
            height = 15.6
            cropFactor = 1.53
        }
        else if sensor_field_str == "CaAPSC"
        {
            width = 22.3
            height = 14.9
            cropFactor = 1.6
        }
        else if sensor_field_str == "CaAPSH"
        {
            width = 34.5
            height = 28.7
            cropFactor = 1.26
        }
        else if sensor_field_str == "FourThirds4/3"
        {
            width = 17.3
            height = 13.0
            cropFactor = 2.0
        }
        else if sensor_field_str == "1inch"
        {
            width = 13.2
            height = 8.8
            cropFactor = 2.7
        }
        else
        {
            width = 36.0
            height = 24.0
            cropFactor = 1.0
        }
        let FL : Double = focal_num
        recommendedShutterspeed = 500.0 / FL / cropFactor
        if apecture_num <= 0.7
        {
            recommendedISO = 400.0
        }
        else if apecture_num <= 1.0
        {
            recommendedISO = 800.0
        }
        else if apecture_num <= 1.4
        {
            recommendedISO = 1600.0
        }
        else if apecture_num <= 2.0
        {
            recommendedISO = 3200.0
        }
        else if apecture_num <= 2.8
        {
            recommendedISO = 6400.0
        }
        else if apecture_num <= 4.0
        {
            recommendedISO = 12800.0
        }
        else if apecture_num <= 5.6
        {
            recommendedISO = 25600.0
        }
        else
        {
            recommendedISO = 51200.0
        }
        if recommendedShutterspeed >= 60.0
        {
            ISOFactor = -1.0
        }
        else if recommendedShutterspeed >= 20.0
        {
            ISOFactor = 0.0
        }
        else if recommendedShutterspeed >= 10.0
        {
            ISOFactor = 1.0
        }
        else if recommendedShutterspeed >= 5.0
        {
            ISOFactor = 2.0
        }
        else
        {
            ISOFactor = 3.0
        }
        
        recommendedISO = pow(2, ISOFactor) * recommendedISO
        var Exposure = 6000.0 * (apecture_num * apecture_num) / iso_num
        var EV = (log(apecture_num * apecture_num / Exposure) / 0.693) - (log(iso_num / 100.0) / 0.693)
        while ( EV > -7.7 )
        {
            Exposure *= 1.25
            EV = (log(apecture_num * apecture_num / Exposure) / 0.693) - (log(iso_num / 100.0) / 0.693)
        }
        getCameraExposure(expo: Exposure)
        
        if Exposure > recommendedShutterspeed
        {
            starTrails = true
        }
        if recommendedISO > iso_num
        {
            otherISO = true
        }
        if Exposure > recommendedShutterspeed
        {
            starTrails = true
        }
        if recommendedISO > iso_num
        {
            otherISO = true
        }
        if starTrails == true
        {
            if otherISO == true
            {
                let warning1 : String = "WARNING:\nThe shutter speed above will result in star trailing. Use a higher ISO or wider aperture lens. The recommended shutter speed is "
                let warning2 : String = "s or faster.For your Focal Length and Aperture, the suggested ISO value is "
                warning_tv.text = warning1 + String(format : "%.2f",recommendedShutterspeed) + warning2 + String(recommendedISO) + "."
            }
            else
            {
                warning_tv.text = "WARNING:\nThe shutter speed above will result in star trailing. Use a higher ISO or wider aperture lens. The recommended shutter speed is " + String(format : "%.2f",recommendedShutterspeed) + "s or faster."
            }
        }
        else if otherISO == true
        {
            warning_tv.text = "Notice:\nThe recommended ISO value is " + String(recommendedISO) + "."
        }
        else
        {
            warning_tv.text = ""
        }
    }
    func getCameraExposure(expo : Double)
    {
        var exposure : String
        let range : Double = 1.0 / expo
        
        if range > 1
        {
            if range > 8000
            {
                exposure = "1/8000+"
            }
            else if range > 7200
            {
                exposure = "1/8000"
            }
            else if range > 5700
            {
                exposure = "1/6400"
            }
            else if range > 4500
            {
                exposure = "1/5000"
            }
            else if range > 3600
            {
                exposure = "1/4000"
            }
            else if range > 2850
            {
                exposure = "1/3200"
            }
            else if range > 2250
            {
                exposure = "1/2500"
            }
            else if range > 1800
            {
                exposure = "1/2000"
            }
            else if range > 1525
            {
                exposure = "1/1600"
            }
            else if range > 1125
            {
                exposure = "1/1250"
            }
            else if range > 900
            {
                exposure = "1/1000"
            }
            else if range > 720
            {
                exposure = "1/800"
            }
            else if range > 570
            {
                exposure = "1/640"
            }
            else if range > 450
            {
                exposure = "1/500"
            }
            else if range > 360
            {
                exposure = "1/400"
            }
            else if range > 285
            {
                exposure = "1/320"
            }
            else if range > 225
            {
                exposure = "1/250"
            }
            else if range > 180
            {
                exposure = "1/200"
            }
            else if range > 142
            {
                exposure = "1/160"
            }
            else if range > 112
            {
                exposure = "1/125"
            }
            else if range > 90
            {
                exposure = "1/100"
            }
            else if range > 70
            {
                exposure = "1/80"
            }
            else if range > 55
            {
                exposure = "1/60"
            }
            else if range > 45
            {
                exposure = "1/50"
            }
            else if range > 35
            {
                exposure = "1/40"
            }
            else if range > 27
            {
                exposure = "1/30"
            }
            else if range > 22
            {
                exposure = "1/25"
            }
            else if range > 17
            {
                exposure = "1/20"
            }
            else if range > 14
            {
                exposure = "1/15"
            }
            else if range > 11
            {
                exposure = "1/13"
            }
            else if range > 9
            {
                exposure = "1/10"
            }
            else if range > 7
            {
                exposure = "1/8"
            }
            else if range > 5
            {
                exposure = "1/6"
            }
            else if range > 4
            {
                exposure = "1/5"
            }
            else if range > 3
            {
                exposure = "1/4"
            }
            else if range > 2.75
            {
                exposure = "1/3"
            }
            else if range > 2.25
            {
                exposure = "1/2.5"
            }
            else if range > 1.8
            {
                exposure = "1/2"
            }
            else if range > 1.45
            {
                exposure = "1/1.6"
            }
            else if range > 1.15
            {
                exposure = "1/1.3"
            }
            else
            {
                exposure = "1"
            }
        }
        else
        {
            exposure = String(round(expo))
        }
 
        if range > 1
        {
//            if exposure == "nan" {
//                speed_time_tv.text = "0s"
//            }
//            else
//            {
                speed_time_tv.text = exposure + " s"
//            }
        }
        else
        {
            let CheckValue = Double(exposure)!
            if CheckValue < 60
            {
//                if exposure == "nan" {
//                    speed_time_tv.text = "0s"
//                }
//                else
//                {
                    speed_time_tv.text = String(roundTwoDecimals(d: Double(exposure)!)) + "s"
//                }
            }
            else
            {
//                if exposure == "nan" {
//                    speed_time_tv.text = "0 min"
//                }
//                else
//                {
                speed_time_tv.text = String(roundTwoDecimals(d: Double(exposure)! / 60)) + " min"
//                }
            }
        }
    }
    func roundTwoDecimals(d : Double) -> Double
    {
        let y = Double(round(100 * d) / 100)
        return y
    }
    func initTextStringsPickerView() {
        sensor_field.type = .strings
        sensor_field.pickerDelegate = self as APJTextPickerViewDelegate
        sensor_field.dataSource = self as APJTextPickerViewDataSource
        sensor_field.placeholder = "Full-Frame"
        
        focal_length.type = .strings
        focal_length.pickerDelegate = self as APJTextPickerViewDelegate
        focal_length.dataSource = self as APJTextPickerViewDataSource
        focal_length.placeholder = "20mm"
        
        aperture.type = .strings
        aperture.pickerDelegate = self as APJTextPickerViewDelegate
        aperture.dataSource = self as APJTextPickerViewDataSource
        aperture.placeholder = "1"
        
        iso_field.type = .strings
        iso_field.pickerDelegate = self as APJTextPickerViewDelegate
        iso_field.dataSource = self as APJTextPickerViewDataSource
        iso_field.placeholder = "25"
    }
}
extension StarTrailsViewController: APJTextPickerViewDelegate {

    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        if textPickerView.tag == 1
        {
            return sensorList[row]
        }
        else if textPickerView.tag == 2
        {
            return focal_lengthList[row]
        }
        else if textPickerView.tag == 3
        {
            return apertureList[row]
        }
        else if textPickerView.tag == 4
        {
            return isoList[row]
        }
        else
        {
            return ""
        }
    }
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {

        if textPickerView.tag == 1
        {
            sensor_field.text = sensorList[row]
            sensor_field.resignFirstResponder()
            if sensor_field.text == "Full-Frame"
            {
                sensor_field_str = "FX"
            }
            else if sensor_field.text == "APS-C"
            {
                sensor_field_str = "CaAPSC"
            }
            else if sensor_field.text == "APS-H"
            {
                sensor_field_str = "CaAPSH"
            }
            else if sensor_field.text == "4:3"
            {
                sensor_field_str = "FourThirds4/3"
            }
            else
            {
                sensor_field_str = "1inch"
            }
        }
        else if textPickerView.tag == 2
        {
            focal_length.text = focal_lengthList[row]
            focal_length.resignFirstResponder()
            if focal_length.text == "8mm"
            {
                focal_num = 8.0
            }
            else if focal_length.text == "9mm"
            {
                focal_num = 9.0
            }
            else if focal_length.text == "10mm"
            {
                focal_num = 10.0
            }
            else if focal_length.text == "12mm"
            {
                focal_num = 12.0
            }
            else if focal_length.text == "11mm"
            {
                focal_num = 11.0
            }
            else if focal_length.text == "13mm"
            {
                focal_num = 13.0
            }
            else if focal_length.text == "14mm"
            {
                focal_num = 14.0
            }
            else if focal_length.text == "15mm"
            {
                focal_num = 15.0
            }
            else if focal_length.text == "16mm"
            {
                focal_num = 16.0
            }
            else if focal_length.text == "17mm"
            {
                focal_num = 17.0
            }
            else if focal_length.text == "18mm"
            {
                focal_num = 18.0
            }
            else if focal_length.text == "19mm"
            {
                focal_num = 19.0
            }
            else if focal_length.text == "20mm"
            {
                focal_num = 20.0
            }
            else if focal_length.text == "24mm"
            {
                focal_num = 24.0
            }
            else if focal_length.text == "28mm"
            {
                focal_num = 28.0
            }
            else if focal_length.text == "35mm"
            {
                focal_num = 35.0
            }
            else if focal_length.text == "50mm"
            {
                focal_num = 50.0
            }
            else if focal_length.text == "55mm"
            {
                focal_num = 55.0
            }
            else if focal_length.text == "70mm"
            {
                focal_num = 70.0
            }
            else if focal_length.text == "85mm"
            {
                focal_num = 85.0
            }
            else if focal_length.text == "100mm"
            {
                focal_num = 100.0
            }
            else if focal_length.text == "105mm"
            {
                focal_num = 105.0
            }
            else if focal_length.text == "135mm"
            {
                focal_num = 135.0
            }
            else if focal_length.text == "200mm"
            {
                focal_num = 200.0
            }
            else if focal_length.text == "300mm"
            {
                focal_num = 300.0
            }
            else if focal_length.text == "400mm"
            {
                focal_num = 400.0
            }
            else if focal_length.text == "500mm"
            {
                focal_num = 500.0
            }
            else if focal_length.text == "600mm"
            {
                focal_num = 600.0
            }
            else if focal_length.text == "800mm"
            {
                focal_num = 800.0
            }
            else if focal_length.text == "1000mm"
            {
                focal_num = 1000.0
            }
            else if focal_length.text == "1500mm"
            {
                focal_num = 1500.0
            }
            else if focal_length.text == "2000mm"
            {
                focal_num = 2000.0
            }
            else
            {
                focal_num = 8.0
            }
        }
        else if textPickerView.tag == 3
        {
            aperture.text = apertureList[row]
            aperture.resignFirstResponder()
            if aperture.text == "1"
            {
                apecture_num = 1.0
            }
            else if aperture.text == "1.1"
            {
                apecture_num = 1.1
            }
            else if aperture.text == "1.2"
            {
                apecture_num = 1.2
            }
            else if aperture.text == "1.4"
            {
                apecture_num = 1.4
            }
            else if aperture.text == "1.6"
            {
                apecture_num = 1.6
            }
            else if aperture.text == "1.8"
            {
                apecture_num = 1.8
            }
            else if aperture.text == "2"
            {
                apecture_num = 2.0
            }
            else if aperture.text == "2.2"
            {
                apecture_num = 2.2
            }
            else if aperture.text == "2.5"
            {
                apecture_num = 2.5
            }
            else if aperture.text == "2.8"
            {
                apecture_num = 2.8
            }
            else if aperture.text == "3.3"
            {
                apecture_num = 3.3
            }
            else if aperture.text == "3.5"
            {
                apecture_num = 3.5
            }
            else if aperture.text == "4"
            {
                apecture_num = 4.0
            }
            else if aperture.text == "4.5"
            {
                apecture_num = 4.5
            }
            else if aperture.text == "5"
            {
                apecture_num = 5.0
            }
            else if aperture.text == "5.6"
            {
                apecture_num = 5.6
            }
            else if aperture.text == "6.3"
            {
                apecture_num = 6.3
            }
            else if aperture.text == "7.1"
            {
                apecture_num = 7.1
            }
            else if aperture.text == "8"
            {
                apecture_num = 8.0
            }
            else if aperture.text == "9"
            {
                apecture_num = 9.0
            }
            else if aperture.text == "10"
            {
                apecture_num = 10.0
            }
            else if aperture.text == "11"
            {
                apecture_num = 11.0
            }
            else if aperture.text == "13"
            {
                apecture_num = 13.0
            }
            else if aperture.text == "14"
            {
                apecture_num = 14.0
            }
            else if aperture.text == "16"
            {
                apecture_num = 16.0
            }
            else if aperture.text == "18"
            {
                apecture_num = 18.0
            }
            else if aperture.text == "20"
            {
                apecture_num = 20.0
            }
            else if aperture.text == "22"
            {
                apecture_num = 22.0
            }
            else if aperture.text == "32"
            {
                apecture_num = 32.0
            }
            else
            {
                apecture_num = 1.0
            }
        }
        else if textPickerView.tag == 4
        {
            iso_field.text = isoList[row]
            iso_field.resignFirstResponder()
            if iso_field.text == "25"
            {
                iso_num = 25.0
            }
            else if iso_field.text == "50"
            {
                iso_num = 50.0
            }
            else if iso_field.text == "64"
            {
                iso_num = 64.0
            }
            else if iso_field.text == "100"
            {
                iso_num = 100.0
            }
            else if iso_field.text == "200"
            {
                iso_num = 200.0
            }
            else if iso_field.text == "400"
            {
                iso_num = 400.0
            }
            else if iso_field.text == "800"
            {
                iso_num = 800.0
            }
            else if iso_field.text == "1000"
            {
                iso_num = 1000.0
            }
            else if iso_field.text == "1600"
            {
                iso_num = 1600.0
            }
            else if iso_field.text == "3200"
            {
                iso_num = 3200.0
            }
            else if iso_field.text == "6400"
            {
                iso_num = 6400.0
            }
            else if iso_field.text == "12800"
            {
                iso_num = 12800.0
            }
            else if iso_field.text == "25600"
            {
                iso_num = 25600.0
            }
            else if iso_field.text == "51200"
            {
                iso_num = 51200.0
            }
            else
            {
                iso_num = 25.0
            }
        }
        CalcExposure()
    }
}

extension StarTrailsViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        if pickerView.tag == 1
        {
            return sensorList.count
        }
        else if pickerView.tag == 2
        {
            return focal_lengthList.count
        }
        else if pickerView.tag == 3
        {
            return apertureList.count
        }
        else if pickerView.tag == 4
        {
            return isoList.count
        }
        else
        {
            return 0
        }
    }
}

