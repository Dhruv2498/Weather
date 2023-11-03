import SwiftyJSON
import UIKit
import Alamofire
import AlamofireImage
class ViewController: UIViewController {
    @IBOutlet weak var lblwhether: UILabel!
    @IBOutlet weak var MyImageView: UIImageView!
    @IBOutlet weak var Timelbl: UILabel!
    @IBOutlet weak var mylabel: UILabel!
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
      
        startUpdatingTime()
    }
    func startUpdatingTime() {
      
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=23.033863&lon=72.585022&appid=0a21ee0329ffff6513b975ca1ff7c4ef"
        AF.request(url, method: .get).responseJSON{
            (response) in
            switch response.result{
            case .success:
               
                let myresult = try? JSON(data: response.data!)
                let resultArray = myresult!["main"]
                
                
                let temp = resultArray["temp"].doubleValue
                let a = temp - 273.15
                let final = Int(a)
                
                let Hour = Calendar.current.component(.hour, from: Date())
                
                if (Hour >= 6 && Hour <= 8){
                    self.MyImageView.image = UIImage(named: "sunrise.jpg")
                    
                }
               
                else if(Hour >= 9 && Hour <= 11){
                    self.MyImageView.image = UIImage(named: "sun.jpg")
                }
               
                else if (Hour >= 12 && Hour <= 17){
                    self.MyImageView.image = UIImage(named: "sun.jpg")
                }
               
                else if (Hour >= 18 && Hour <= 20 ){
                    self.MyImageView.image = UIImage(named: "sunset.jpg")
                }
              
                else{
                    self.MyImageView.image = UIImage(named: "moon.jpg")
                }
                
                if (Hour >= 5 && Hour <= 11){
                    self.mylabel.text = ("Good Morning")
                }
                else if (Hour >= 12 && Hour <= 18){
                    self.mylabel.text = ("Good Afternoon")
                }
                else if(Hour >= 19 && Hour <= 24){
                    self.mylabel.text = ("Good Evening")
                }
                else{
                    self.mylabel.text = ("Good Night")
                }
                
                self.lblwhether.text = (("\(final)°C"))
                
                print("\(temp - 273.15)C")
                
                break
            case .failure:
                break
            }
        }
    }
    @objc func updateTime() {
           let dateFormatter = DateFormatter()
           dateFormatter.timeStyle = .medium
           dateFormatter.timeZone = TimeZone(identifier: "India Standard Time")

           let currentTime = dateFormatter.string(from: Date())
           Timelbl.text = currentTime
       }
       
      
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           timer?.invalidate()
           
       }
}

