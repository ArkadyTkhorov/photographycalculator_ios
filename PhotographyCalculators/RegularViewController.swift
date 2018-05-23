import Foundation
import UIKit

class RegularViewController: UIViewController {

    
    @IBOutlet weak var editText: UITextField!
    
    var sum:String! = ""
    var one:String! = ""
    var two:String! = ""
    var three:String! = ""
    var four:String! = ""
    var five:String! = ""
    var six:String! = ""
    var seven:String! = ""
    var eight:String! = ""
    var nine:String! = ""
    var dec_string:String! = ""
    var zero:String! = ""
    var hex_string:String! = ""
    var oct_string:String! = ""
    var pi : String! = "3.1416"
    var countOne:Int! = 0
    var dec_num:Int! = 0
    var result:Float! = 0
    var result_mul:Float! = 1
    var result_div:Float! = 1
    var pressCount:Int! = 1
    var sumZero:Int! = 0
    var dec_flag:Int! = 0
    var c:Int! = 0
    var i:Int! = 0
    var press:String! = ""
    var EditTextMsg:String! = ""
    var bin_num:String! = ""
    var hex_num:String! = ""
    var oct_num:String! = ""
    var floatEditTextMsg : Float! = 0.0
    var doubleEditTextMsg: Double! = 0.0
    var afterSin: Double! = 0.0
    var after_cos: Double! = 0.0
    var after_tan: Double! = 0.0
    var toRadian_doubleEditTextMsg: Double! = 0.0
    var after_squared_2: Double! = 0.0
    var after_root: Double! = 0.0
    var after_qube: Double! = 0.0
    
    
    @IBAction func button0(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        if sum != ""
        {
            zero = "0"
            sum = sum + zero
            editText.text = String(sum)
        }
        else
        {
            sum = "0"
            editText.text = "0"
        }
    }
    
    @IBAction func button1(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        one = "1"
        sum = sum + one
        editText.text = String(sum)
    }
    
    @IBAction func button2(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        
        if press == "="
        {
            buttonEqual(sender)
        }
        two = "2"
        sum = sum + two
        editText.text = String(sum)
    }
    
    @IBAction func button3(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        three = "3"
        sum = sum + three
        editText.text = String(sum)
    }
    
    @IBAction func button4(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        
        four = "4"
        sum = sum + four
        editText.text = String(sum)
    }
    
    @IBAction func button5(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        
        five = "5"
        sum = sum + five
        editText.text = String(sum)
    }

    @IBAction func button6(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        six = "6"
        sum = sum + six
        editText.text = String(sum)
    }
    
    @IBAction func button7(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        
        seven = "7"
        sum = sum + seven
        editText.text = String(sum)
    }
    
    @IBAction func button8(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        eight = "8"
        sum = sum + eight
        editText.text = String(sum)
    }
    
    @IBAction func button9(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        
        nine = "9"
        sum = sum + nine
        editText.text = String(sum)
    }
    
    @IBAction func buttonPoint(_ sender: Any) {
        var error : Int = 0
        if sum != nil
        {
            var i = 1
            while(i == sum.count)
            {
                if sum.charAt(at: i) == "."
                {
                    error = 1
                    break
                }
                i = i + 1
            }
        }
        if error == 0
        {
            if sum == nil
            {
                sum = sum + "0."
            }
            else
            {
                sum = sum + "."
            }
        }
        editText.text = String(sum)
    }
    
    @IBAction func buttonEqual(_ sender: Any) {
        
        if press == "+"
        {
            buttonPlus(sender)
        }
        else if press == "-"
        {
            buttonMinus(sender)
        }
        else if press == "*"
        {
            buttonMultiply(sender)
        }
        else if press == "/"
        {
            buttonDivide(sender)
            
        }
        press = "="

    }
    
    @IBAction func buttonPlus(_ sender: Any) {
        if press == "-"
        {
            buttonEqual(sender)
        }
        else if press == "*"
        {
            buttonEqual(sender)
        }
        else if press == "/"
        {
            buttonEqual(sender)
        }
        press = "+"
        
        if sum != ""
        {
            result = Float(result) + Float(editText.text!)!
            editText.text = String(result)
            result_mul = result
            result_div = Float(result)
            sum = ""
        }
        else
        {
            editText.text = String(result)
            result_mul = result
            result_div = Float(result)
            sum = ""
        }
    }
    
    @IBAction func buttonMinus(_ sender: Any) {
        if press == "+"
        {
            buttonEqual(sender)
        }
        else if press == "*"
        {
            buttonEqual(sender)
        }
        else if press == "/"
        {
            buttonEqual(sender)
        }
        press = "-"
        EditTextMsg = editText.text!
        floatEditTextMsg = Float(EditTextMsg)!
        if sum == "" && result == 0
        {
            sum = sum + "-"
        }
        else if sum != ""
        {
            if result == 0
            {
                result = Float(sum)! - result
                editText.text = String(result)
                result_mul = result
                result_div = Float(result)
                sum = ""
            }
            else
            {
                result = Float(result) - Float(sum)!
                editText.text = String(result)
                result_mul = result
                result_div = Float(result)
                sum = ""
            }
        }
    }
    
    @IBAction func buttonMultiply(_ sender: Any) {
        if press == "/"
        {
            buttonEqual(sender)
        }
        else if press == "+"
        {
            buttonEqual(sender)
        }
        else if press == "-"
        {
            buttonEqual(sender)
        }
        
        press = "*"
        EditTextMsg = editText.text!
        floatEditTextMsg = Float(EditTextMsg)!
        if sum != ""
        {
            result_mul = result_mul * floatEditTextMsg
            result = result_mul
            result_div = Float(result_mul)
            editText.text = String(result_mul)
            sum = ""
        }
        else
        {
            editText.text = EditTextMsg
            sum = ""
        }
    }
    
    @IBAction func buttonDivide(_ sender: Any) {
        if press == "+"
        {
            buttonEqual(sender)
        }
        else if press == "-"
        {
            buttonEqual(sender)
        }
        else if press == "*"
        {
            buttonEqual(sender)
        }
        press = "/"
        EditTextMsg = editText.text!
        floatEditTextMsg = Float(EditTextMsg)!
        if sum != "" && result_div == 1
        {
            //int c=0;
            if c == 0
            {
                result_div = floatEditTextMsg / result_div
                c = c+1
            }
            else
            {
                result_div = result_div / floatEditTextMsg
            }
            result = result_div
            result_mul = result_div
            editText.text = String(result_div)
            sum = ""
        }
        else if sum != "" && result_div != 1
        {
            result_div = result_div / floatEditTextMsg
            result = result_div
            result_mul = result_div
            editText.text = String(result_div)
            sum = ""
        }
        else
        {
            editText.text = (EditTextMsg)
            sum = ""
        }
    }
    
    @IBAction func buttonReset(_ sender: Any) {
        sum = ""
        countOne = 0
        result = 0
        result_mul = 1
        result_div = 1
        press = " "
        c = 0
        editText.text = String(result)
    }
    
    @IBAction func buttonExit(_ sender: Any) {

        
    }
    
    @IBAction func button_sin(_ sender: Any) {
        
        EditTextMsg = editText.text!
        doubleEditTextMsg = Double(EditTextMsg)!//degree
        toRadian_doubleEditTextMsg = degreesToRadians(degrees: doubleEditTextMsg)
        afterSin = sin(toRadian_doubleEditTextMsg)
        editText.text = String(afterSin)
        EditTextMsg = editText.text!
        result = Float(EditTextMsg)!
        result_mul = Float(EditTextMsg)!
        result_div = Float(EditTextMsg)!
        sum = ""
        
    }
    
    @IBAction func button_cos(_ sender: Any) {
        
        EditTextMsg = editText.text!
        doubleEditTextMsg = Double(EditTextMsg)!//degree
        toRadian_doubleEditTextMsg = degreesToRadians(degrees: doubleEditTextMsg)
        after_cos = cos(toRadian_doubleEditTextMsg)
        editText.text = String(after_cos)
        EditTextMsg = editText.text!
        result = Float(EditTextMsg)!
        result_mul = Float(EditTextMsg)!
        result_div = Float(EditTextMsg)!
        sum = ""
    }
    
    @IBAction func button_tan(_ sender: Any) {
        
        EditTextMsg = editText.text!
        doubleEditTextMsg = Double(EditTextMsg)!//degree
        toRadian_doubleEditTextMsg = (doubleEditTextMsg)
        after_tan = tan(toRadian_doubleEditTextMsg)
        editText.text = String(after_tan)
        EditTextMsg = editText.text!
        result = Float(EditTextMsg)!
        result_mul = Float(EditTextMsg)!
        result_div = Float(EditTextMsg)!
        sum = ""
    }
    
    @IBAction func button_del(_ sender: Any) {
        if sum != ""
        {
            let builder:String = sum
            sum = builder.substring(from: 0, to: builder.lengthOfBytes(using: .utf8) - 1)
            editText.text = sum
        }
    }
    
    @IBAction func button_bin(_ sender: Any) {
        
        EditTextMsg = editText.text!
        var i = 1
        while(i <= EditTextMsg.count)
        {
            if EditTextMsg.charAt(at: i) == "."
            {
                break;
            }
            else
            {
                dec_string = dec_string + String(EditTextMsg.charAt(at: i))
            }
            i = i + 1
        }
        dec_num = Int(dec_string)!
        editText.text = String(dec_num, radix: 2)
        dec_string = ""
        EditTextMsg = ""
        bin_num = ""
        sum = ""
    }
    
    @IBAction func button_dec(_ sender: Any) {
        EditTextMsg = editText.text!
        for i in 0...EditTextMsg.count
        {
            let unicode_value = EditTextMsg.charAt(at: i).unicodeScalarCodePoint()
            if unicode_value > 49 || unicode_value < 48
            {
                dec_flag = 1
                break
            }
        }
        if dec_flag == 0
        {
            editText.text = String(dec_num, radix: 2)
            EditTextMsg = editText.text!
            sum = ""
        }
        else
        {
            editText.text = "input error"
            sum = ""
        }
    }
    
    @IBAction func buttonHex(_ sender: Any) {
        
        EditTextMsg = editText.text!
        var i = 1
        while (i <= EditTextMsg.count)
        {
            if EditTextMsg.charAt(at: i) == "."
            {
                break;
            }
            else
            {
                hex_string = hex_string + String(EditTextMsg.charAt(at: i))
            }
            i = i + 1
        }
        dec_num = Int(hex_string)!
        hex_num = String(dec_num, radix: 16)
        
        editText.text = String(hex_num)
        dec_string = ""
        hex_string = ""
        EditTextMsg = ""
        bin_num = ""
        hex_num = ""
        sum = ""
    }
    
    @IBAction func buttonOct(_ sender: Any) {
        
        EditTextMsg = editText.text!
        for i in 1...EditTextMsg.count
        {
            if EditTextMsg.charAt(at: i) == "."
            {
                break;
            }
            else
            {
                oct_string = oct_string + String(EditTextMsg.charAt(at: i))
            }
        }
        dec_num = Int(oct_string)!
        editText.text = String(dec_num, radix: 8)
        dec_string = ""
        hex_string = ""
        oct_string = ""
        EditTextMsg = ""
        bin_num = ""
        hex_num = ""
        oct_num = ""
        sum = ""
    }
    
    @IBAction func button_pi(_ sender: Any) {
        if press == "="
        {
            buttonReset(sender)
        }
        sum = pi
        editText.text = (pi)
    }
    
    @IBAction func buttonCubed(_ sender: Any) {
        
        EditTextMsg = editText.text!
        doubleEditTextMsg = Double (EditTextMsg)!//degree
        after_qube = pow(doubleEditTextMsg, 3)
        editText.text = String(after_qube)
        EditTextMsg = editText.text!
        result = Float(EditTextMsg)!
        result_mul = Float(EditTextMsg)!
        result_div = Float(EditTextMsg)!
        sum = ""
    }
    
    @IBAction func button_squared_2(_ sender: Any) {
        
        EditTextMsg = editText.text!
        doubleEditTextMsg = Double (EditTextMsg)!//degree
        after_squared_2 = pow(doubleEditTextMsg, 2)
        editText.text = String(after_squared_2)
        EditTextMsg = editText.text!
        result = Float(EditTextMsg)!
        result_mul = Float(EditTextMsg)!
        result_div = Float(EditTextMsg)!
        sum = ""
    }
    
    @IBAction func button_root(_ sender: Any) {
        
        EditTextMsg = editText.text!
        doubleEditTextMsg = Double (EditTextMsg)!//degree
        after_root = sqrt(doubleEditTextMsg)
        editText.text = String(after_root)
        EditTextMsg = editText.text!
        result = Float(EditTextMsg)!
        result_mul = Float(EditTextMsg)!
        result_div = Float(EditTextMsg)!
        
        sum = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editText.text = String(result)
    }
    func degreesToRadians(degrees: Double ) -> Double {
        return degrees * Double.pi / 180
    }
}
extension String {
    func charAt(at: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self[charIndex]
    }
}

extension Character {
    func unicodeScalarCodePoint() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return scalars[scalars.startIndex].value
    }
}
