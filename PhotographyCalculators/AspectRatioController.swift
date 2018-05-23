import UIKit

class AspectRatioController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var width_field: UITextField!
    @IBOutlet weak var height_field: UITextField!
    
    @IBOutlet weak var img_first_pixel_field: UITextField!
    @IBOutlet weak var img_sec_pixel_field: UITextField!
    
    var tagCnt : Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        width_field.delegate = self
        height_field.delegate = self
        img_first_pixel_field.delegate = self
        img_sec_pixel_field.delegate = self
        clearValue()
    }
    @IBAction func tfDidEndEditing(_ sender: UITextField) {
         tagCnt = sender.tag
    }
    @IBAction func calBtn(_ sender: Any) {
        calculate(position: tagCnt)
    }
    @IBAction func clear_valueBtn(_ sender: Any) {
        clearValue()
    }
}
extension AspectRatioController{
    func clearValue()
    {
        width_field.text = "4"
        height_field.text = "3"
        img_first_pixel_field.text = "800"
        img_sec_pixel_field.text = "600"
    }
    func calculate(position : Int) {
        var at, ab, tt, tb : Int
        at = Int(width_field.text!)!
        ab = Int(height_field.text!)!
        if (img_first_pixel_field.text?.isEmpty)!
        {
            tt = -1
        }
        else
        {
            tt = Int(img_first_pixel_field.text!)!
        }
        if(img_sec_pixel_field.text?.isEmpty)!
        {
            tb = -1
        }
        else
        {
            tb = Int(img_sec_pixel_field.text!)!
        }
        if position == 1 || position == 4
        {
            if ab == 0
            {
                tt = -1
            }
            else
            {
                tt = tb * at / ab
            }
            if tt == -1
            {
                img_first_pixel_field.text = "NaN"
            }
            else
            {
                img_first_pixel_field.text = String(tt)
            }
        }
        else if position == 2 || position == 3
        {
            if at == 0
            {
                tb = -1
            }
            else
            {
                tb = tt * ab / at
            }
            if tb == -1
            {
                img_sec_pixel_field.text = "NaN"
            }
            else
            {
                img_sec_pixel_field.text = String(tb)
            }
        }
    }
}
