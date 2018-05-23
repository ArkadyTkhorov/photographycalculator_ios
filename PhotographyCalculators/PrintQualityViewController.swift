

import UIKit

class PrintQualityViewController: UIViewController {
    
    
    @IBOutlet weak var input_width_et: UITextField!
    @IBOutlet weak var input_height_et: UITextField!
    
    @IBOutlet weak var mega_pixel_et: UITextField!
    @IBOutlet weak var op_w1_et: UITextField!
    @IBOutlet weak var op_h1_et: UITextField!
    @IBOutlet weak var op_w2_et: UITextField!
    @IBOutlet weak var op_h2_et: UITextField!
    @IBOutlet weak var op_w3_et: UITextField!
    @IBOutlet weak var op_h3_et: UITextField!
    
    var sizemb = 0.0,printw = 0.0, printh = 0.0, printw2 = 0.0, printh2 = 0.0, printw3 = 0.0, printh3 : Double = 0.0
    var wpix = 0.0, hpix : Double = 0.0
    
    @IBAction func calc_btn_clicked(_ sender: Any) {
//        try {
        wpix = Double(input_width_et.text!)!
        hpix = Double(input_height_et.text!)!
//        }catch (NumberFormatException e)
//        {
//        wpix = 0;
//        hpix = 0;
//        }
        sizemb = (((wpix * hpix) / 1000000) * 100) / 100
        printw = (((wpix / 300) * 10)) / 10
        printh = (((hpix / 300) * 10)) / 10
        printw2 = (((wpix / 150) * 10)) / 10
        printh2 = (((hpix / 150) * 10)) / 10
        printw3 = (((wpix / 115) * 10)) / 10
        printh3 = (((hpix / 115) * 10)) / 10
        mega_pixel_et.text = String(format: "%.2f", sizemb)
        op_w1_et.text = String(format: "%.2f", printw)
        op_h1_et.text = String(format: "%.2f", printh)
        op_w2_et.text = String(format: "%.2f", printw2)
        op_h2_et.text = String(format: "%.2f", printh2)
        op_w3_et.text = String(format: "%.2f", printw3)
        op_h3_et.text = String(format: "%.2f", printh3)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input_width_et.text = "0"
        input_height_et.text = "0"
    }
}
