import UIKit
import Foundation
class ExposureViewController: UIViewController{

    var clicked : Bool = false
    let fstops : [Double] = [0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.4, 1.6, 1.8, 2, 2.2, 2.5, 2.8, 3.2, 3.5, 4, 4.5, 5.0, 5.6, 6.3, 7.1, 8, 9, 10, 11, 13, 14, 16, 18, 20, 22, 27, 32, 38, 45, 54, 64, 76, 91, 108]
    let shutterSpeeds : [Double] = [1/8000.0, 1/6400.0, 1/5000.0, 1/4000.0, 1/3200.0, 1/2500.0, 1/2000.0, 1/1600.0, 1/1250.0, 1/1000.0, 1/800.0, 1/640.0, 1/500.0, 1/400.0, 1/320.0, 1/250.0, 1/200.0, 1/160.0, 1/125.0, 1/100.0, 1/80.0, 1/60.0, 1/50.0, 1/40.0, 1/30.0, 1/25.0, 1/20.0, 1/15.0, 1/13.0, 1/10.0, 1/8.0, 1/6.0, 1/5.0, 1/4.0, 0.3, 0.4, 0.5, 0.6, 0.8, 1, 1.3, 1.6, 2, 2.5, 3.2, 4, 5]
    let isos : [Double] = [50, 100, 125, 160, 200, 250, 320, 400, 500, 640, 800, 1000, 1250, 1600, 2000, 2500, 3200, 4000, 5000, 6400, 12800, 25600]
    
    var exposureValue : Double = 0
    
    @IBOutlet weak var aperture_et: UITextField!
    @IBOutlet weak var shutterspd_et: UITextField!
    @IBOutlet weak var iso_et: UITextField!
    
    @IBOutlet weak var calc_btn: UIButton!
    
    
    
    @IBAction func aperture(_ sender: Any) {
        calculate(position: 1)
    }
    
    @IBAction func shutterspeed(_ sender: Any) {
        calculate(position: 2)
    }
    
    @IBAction func iso(_ sender: Any) {
        calculate(position: 3)
    }
    
    
    @IBAction func calc_btn_clicked(_ sender: Any) {
        clicked = !clicked
        if clicked
        {
            calc_btn.setTitle("UnCalc", for: .normal)
        }
        else
        {
            calc_btn.setTitle("Calc", for: .normal)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        aperture_et.text = "8.0"
        shutterspd_et.text = "1/1000"
        iso_et.text = "100"
        clicked = false
        calculate(position: 0)
    }
}
extension ExposureViewController
{
    func calculateEv(n : Double, t : Double, s : Double)
    {
        let ev = Darwin.log2(n * n / t)
        exposureValue = ev - Darwin.log2(s / 100)
        updateDisplay(n: n, t: t, s: s)
    }
    func updateDisplay(n : Double, t : Double, s : Double)
    {
        var tt = roundToArray(val: t, array: shutterSpeeds)
        if tt < shutterSpeeds[0]
        {
            tt = shutterSpeeds[0]
        }
        if tt > shutterSpeeds[shutterSpeeds.count-1]
        {
            tt = shutterSpeeds[shutterSpeeds.count-1]
        }
        let nn = roundToArray(val: n, array: fstops)
        let ss = roundToArray(val: s, array: isos)
        if tt < 1
        {
            shutterspd_et.text = decimalToFraction(value: tt)
        }
        else
        {
            var vt : Double = 0
            if tt < 5
            {
                vt = round(tt * 10) / 10
            }
            else
            {
                vt = round(tt)
            }
            if tt == Double.infinity
            {
                shutterspd_et.text = "Infinite"
            }
            else
            {
                if (vt - Double(Int(vt))) == 0
                {
                    shutterspd_et.text = String(Int(vt))
                }
                else
                {
                    shutterspd_et.text = String(vt)
                }
            }
        }
        aperture_et.text = String(nn)
        iso_et.text = String(round(ss))
    }
    func updateApertureToFit(n : Double, t : Double, s : Double)
    {
        
        let nn = sqrt(t * pow(2, exposureValue + Darwin.log2(s / 100)))
        updateDisplay(n: nn, t: t, s: s)
    }
    func updateSpeedToFit(n : Double, t : Double, s : Double)
    {
        let tt = (n * n) / pow(2, exposureValue + Darwin.log2(s / 100))
        updateDisplay(n: n, t: tt, s: s)
    }
    func roundToArray(val : Double , array : [Double]) -> Double
    {
        if val < array[0] || val > array[array.count - 1]
        {
            return val
        }
        var best : Double = val
        var bestDiff : Double = Double.infinity
        var i = 1
        while i <= array.count
        {
            let diff = abs(array[i] - val)
            if diff <= bestDiff
            {
                best = array[i]
                bestDiff = diff
            }
            else
            {
                return best
            }
            i = i + 1
        }
        return best
    }
    func log2(x : Double) -> Double
    {
        return log(x) / 0.693
    }
    func decimalToFraction(value : Double) -> String
    {
        if value < 0.3
        {
            let v : Int = Int(1 / value)
            return String(format: "1/%d", v)
        }
        return String(value)
    }
    func fractionToDecimal(s : String) -> Double
    {
        var ret : Double = 0
        if s.isEqualToString(find: "Infinite")
        {
            return Double.infinity
        }
        if !s.contains("/")
        {
            return Double(s)!
        }
        let index = s.index(of: "/")
        let numerator = Int(s.substring(to: index!))
        let denominator = Int(s[s.index(after: index!) ..< s.endIndex])
        ret = Double(numerator!) / Double(denominator!)
        return ret
    }
    func calculate(position : Int)
    {
        var n : Double
        var t : Double
        var s : Double
        n = Double(aperture_et.text!)!
        t = fractionToDecimal(s: shutterspd_et.text!)
        s = Double(iso_et.text!)!
        if !clicked
        {
            calculateEv(n: n, t: t, s: s)
        }
        else
        {
            if position == 1 || position == 3
            {
                updateSpeedToFit(n: Double(n), t: Double(t), s: Double(s))
            }
            else if position == 2
            {
                updateApertureToFit(n: Double(n), t: Double(t), s: Double(s))
            }
        }
    }
    func roundTwoDecimals(d : Double) -> Double
    {
        let y = Double(round(100*d)/100)
        return y
    }
}
extension String
{
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
}

