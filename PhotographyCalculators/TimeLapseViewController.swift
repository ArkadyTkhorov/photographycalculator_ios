
import UIKit

class TimeLapseViewController: UIViewController {

    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var fps: UITextField!
    @IBOutlet weak var frames: UITextField!
    var one = true, two = true, three : Bool = false
    var Min = 0.0, Fps = 0.0, Frames : Double = 0.0
    
    
    @IBAction func calculate(_ sender: Any)
    {
        var total = totalNum()
        if total != 1
        {

        }
        else
        {
            if one == false
            {
                var ans : String = "" + String(Frames / Fps)
                output.text = ans
            }
            else if two == false
            {
                var ans : String = "" + String(Frames / Min)
                output.text = ans
            }
            else if three == false
            {
                var ans : String = "" + String(Min * Fps)
                output.text = ans
            }
        }
    }
    
    @IBOutlet weak var output: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func duration_changed(_ sender: UITextField)
    {
        var cur : String = duration.text!
        if cur.isEqualToString(find: "") || cur.isEqualToString(find: " ")
        {
            Min = -1
        }
        else if cur.isEqualToString(find: ".")
        {
            Min = 0.5
        }
        else
        {
            Min = Double(cur)!
        }
        one = Min != -1
        output.text = "___________________"
    }
    
    @IBAction func fps_changed(_ sender: UITextField)
    {
        var cur : String = fps.text!
        if cur.isEqualToString(find: "") || cur.isEqualToString(find: " ")
        {
            Fps = -1
        }
        else if cur.isEqualToString(find: ".")
        {
            Fps = 0.5
        }
        else
        {
            Fps = Double(cur)!
        }
        two = Fps != -1
        output.text = "___________________"
    }
    
    @IBAction func frames_changed(_ sender: UITextField)
    {
        
        var cur : String = frames.text!
        if cur.isEqualToString(find: "") || cur.isEqualToString(find: " ")
        {
            Frames = -1
        }
        else if cur.isEqualToString(find: ".")
        {
            Frames = 0.5
        }
        else
        {
            Frames = Double(cur)!
        }
        three = Frames != -1
        output.text = "___________________"
        
    }
    
    func totalNum() -> Int
    {
        var a = 0, b = 0, c : Int = 0
        if one == true
        {
            a = 0
        }
        else
        {
            a = 1
        }
        if two == true
        {
            b = 0
        }
        else
        {
            b = 1
        }
        if three == true
        {
            c = 0
        }
        else
        {
            c = 1
        }
        var total : Int = a + b + c
        return total
    }
}
