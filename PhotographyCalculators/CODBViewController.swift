
import UIKit

class CODBViewController: UIViewController {

    @IBOutlet weak var etxtOffice: UITextField!
    @IBOutlet weak var etxtPhone: UITextField!
    @IBOutlet weak var etxtPhoto: UITextField!
    @IBOutlet weak var etxtComputer: UITextField!
    @IBOutlet weak var etxtBroad: UITextField!
    @IBOutlet weak var etxtWebhostin: UITextField!
    @IBOutlet weak var etxtVehicle: UITextField!
    @IBOutlet weak var etxtOfficeSupplies: UITextField!
    @IBOutlet weak var etxtPostage: UITextField!
    @IBOutlet weak var etxtProfessional: UITextField!
    @IBOutlet weak var etxtAdvertising: UITextField!
    @IBOutlet weak var etxtSubscriptions: UITextField!
    @IBOutlet weak var etxtEquipmentBusiness1: UITextField!
    @IBOutlet weak var etxtHealth: UITextField!
    @IBOutlet weak var etxtLegal: UITextField!
    @IBOutlet weak var etxtTaxes: UITextField!
    @IBOutlet weak var etxtOfficeAssistance: UITextField!
    @IBOutlet weak var etxtUtilities: UITextField!
    @IBOutlet weak var etxtTravel: UITextField!
    @IBOutlet weak var etxtDesired: UITextField!
    @IBOutlet weak var etxtNonassignment: UITextField!
    @IBOutlet weak var etxtNumberofdays: UITextField!
    
    @IBOutlet weak var txtTotalAnnualExpenses: UILabel!
    @IBOutlet weak var txtWeeklyCost: UILabel!
    @IBOutlet weak var txtOverheadCost: UILabel!
    
    var total : Float = 0
    var weaklycost : Float = 0
    var noofDays : Int = 0
    @IBAction func set_default_clicked(_ sender: Any) {
        
        etxtOffice.text = "6000"
        etxtPhone.text = "2400"
        etxtPhoto.text = "8000"
        etxtComputer.text = "500"
        etxtBroad.text = "1200"
        etxtWebhostin.text = "200"
        etxtVehicle.text = "5000"
        etxtOfficeSupplies.text = "1500"
        etxtPostage.text = "300"
        etxtProfessional.text = "500"
        etxtAdvertising.text = "2500"
        etxtSubscriptions.text = "300"
        etxtEquipmentBusiness1.text = "1200"
        etxtHealth.text = "3600"
        etxtLegal.text = "300"
        etxtTaxes.text = "5000"
        etxtOfficeAssistance.text = "1000"
        etxtUtilities.text = "1800"
        etxtTravel.text = "1500"
        etxtDesired.text = "20000"
        etxtNonassignment.text = "0"
        etxtNumberofdays.text = "40"
        txtTotalAnnualExpenses.text = "$ "+"63300.00"
        txtWeeklyCost.text = "$ "+"1217.30"
        txtOverheadCost.text = "$ "+"1582.50"
    }
    
    @IBAction func calc_btn_clicked(_ sender: Any) {
        
        total = Float(etxtOffice.text!)!
        total = total + Float(etxtPhone.text!)!
        total = total + Float(etxtPhoto.text!)!
        total = total + Float(etxtComputer.text!)!
        total = total + Float(etxtBroad.text!)!
        total = total + Float(etxtWebhostin.text!)!
        total = total + Float(etxtVehicle.text!)!
        total = total + Float(etxtOfficeSupplies.text!)!
        total = total + Float(etxtPostage.text!)!
        total = total + Float(etxtProfessional.text!)!
        total = total + Float(etxtAdvertising.text!)!
        total = total + Float(etxtSubscriptions.text!)!
        total = total + Float(etxtEquipmentBusiness1.text!)!
        total = total + Float(etxtHealth.text!)!
        total = total + Float(etxtLegal.text!)!
        total = total + Float(etxtTaxes.text!)!
        total = total + Float(etxtOfficeAssistance.text!)!
        total = total + Float(etxtUtilities.text!)!
        total = total + Float(etxtTravel.text!)!
        total = total + Float(etxtDesired.text!)!
        total = total - Float(etxtNonassignment.text!)!
        
        var weaklycost = total / 50
        var noofDays = Int(etxtNumberofdays.text!)!
        txtTotalAnnualExpenses.text = "$ " + String(format: "%.2f", total)
        txtWeeklyCost.text = "$ " + String(format: "%.2f", weaklycost)
        txtOverheadCost.text = "$ " + String(format: "%.2f", total / Float(noofDays))
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        etxtOffice.text = "6000"
        etxtPhone.text = "2400"
        etxtPhoto.text = "8000"
        etxtComputer.text = "500"
        etxtBroad.text = "1200"
        etxtWebhostin.text = "200"
        etxtVehicle.text = "5000"
        etxtOfficeSupplies.text = "1500"
        etxtPostage.text = "300"
        etxtProfessional.text = "500"
        etxtAdvertising.text = "2500"
        etxtSubscriptions.text = "300"
        etxtEquipmentBusiness1.text = "1200"
        etxtHealth.text = "3600"
        etxtLegal.text = "300"
        etxtTaxes.text = "5000"
        etxtOfficeAssistance.text = "1000"
        etxtUtilities.text = "1800"
        etxtTravel.text = "1500"
        etxtDesired.text = "20000"
        etxtNonassignment.text = "0"
        etxtNumberofdays.text = "40"
        txtTotalAnnualExpenses.text = "$ "+"63300.00"
        txtWeeklyCost.text = "$ "+"1217.30"
        txtOverheadCost.text = "$ "+"1582.50"
    }
}
