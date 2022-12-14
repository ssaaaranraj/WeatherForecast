//
//  ViewController.swift
//  WeatherForecast
//
//  Created by ProV FSM on 02/12/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   
    var currentDtTime = ""
    var weathericon = ""

    var weathericonAr = [String]()
    var min_tempAr = [Double]()
    var max_tempAr = [Double]()

    let weatherTableView = UITableView()

    var mainView: MainView { return self.view as! MainView }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.backgroundColor = .white
        
        mainView.contentView2.addSubview(weatherTableView)
        
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        
        weatherTableView.topAnchor.constraint(equalTo:mainView.contentView2.topAnchor).isActive = true
        weatherTableView.leftAnchor.constraint(equalTo:mainView.contentView2.leftAnchor).isActive = true
        weatherTableView.rightAnchor.constraint(equalTo:mainView.contentView2.rightAnchor).isActive = true
        weatherTableView.bottomAnchor.constraint(equalTo:mainView.contentView2.bottomAnchor).isActive = true
        weatherTableView.backgroundColor = .clear
        weatherTableView.dataSource = self
        weatherTableView.delegate = self

        
//      contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "contactCell")
        bgImageCurrentDtTime()
        ApiCall()
       
    }
    
    func bgImageCurrentDtTime(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg")
        backgroundImage.contentMode = .scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
       
        //current DtTime
        let mytime = Date()
        let format = DateFormatter()
        format.timeStyle = .short
        format.dateStyle = .medium
        print(format.string(from: mytime))
        mainView.DateTime.text = format.string(from: mytime)
//        mainView.contentView.backgroundColor = hexStringToUIColor(hex: "#4294CD")
    }
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min_tempAr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! WeatherTableViewCell
        cell.backgroundColor = .clear
//      cell.textLabel?.text = contacts[indexPath.row].name
//        cell.contact = forecastarray[indexPath.row]
        let mintemp = min_tempAr[indexPath.row]
        let maxtemp = max_tempAr[indexPath.row]
        let weathericons = weathericonAr[indexPath.row]

        cell.nameLabel.text = "\(mintemp) - \(maxtemp)"
        
        DispatchQueue.global(qos: .background).async {
                   do{
                           let data = try Data.init(contentsOf: URL.init(string:"https:\(weathericons)")!)
                          DispatchQueue.main.async {
                                 let image: UIImage? = UIImage(data: data)
                              cell.profileImageView.image = image
                          }
                    }
                   catch let errorLog {
                        debugPrint(errorLog.localizedDescription)
                  }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func ApiCall(){
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=522db6a157a748e2996212343221502&q=chennai&days=7&aqi=no&alerts=no"

        let url = URL(string:urlString)
        URLSession.shared.dataTask(with: url!){  (data,response,error) in
            if error != nil{
                print(error!)
            }
            else{
                do{
                    self.min_tempAr.removeAll()
                    self.max_tempAr.removeAll()
                    self.weathericonAr.removeAll()
                    let dicts = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                    if let location = dicts! ["location"] as? NSDictionary{
                        if let current =  dicts! ["current"] as? NSDictionary{
                        if let condition = current ["condition"] as? NSDictionary{
                                
//                            let textCloud =
                        if let forecast = dicts! ["forecast"] as? NSDictionary{
                            if let content = forecast ["forecastday"] as? NSArray{
                                for forecastday in content{
                                    if let forecastDict = forecastday as? NSDictionary{
                                        if let day = forecastDict ["day"] as? NSDictionary{
                                            let maxtemp_c = day ["maxtemp_c"] as! Double
                                            let mintemp_c = day ["mintemp_c"] as! Double
//                                            forecastDict.setValue(maxtemp_c, forKey: "maxTemp")
                                            self.min_tempAr.append(mintemp_c)
                                            self.max_tempAr.append(maxtemp_c)

//                                            max_tempAr.append(maxtemp_c)
                                             print(maxtemp_c)
                                            if let conditionDict = day ["condition"] as? NSDictionary{
                                                let icon = conditionDict["icon"] as! String
                                                self.weathericonAr.append(icon)
                                                let captionTxt = conditionDict["text"] as! String
                                                print(captionTxt)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        DispatchQueue.main.async {
                          // your code here
                            self.mainView.cityLabel.text=(location["name"] as? String)!
                            self.mainView.CountryLabel.text=(location["country"] as? String)!
                            self.mainView.Temperature.text = condition["text"] as! String
                            self.weatherTableView.reloadData()
                            }
                          }
                            
                        }
                    }
                }
                catch let error as NSError{
                    print(error)
                }
            }
        }.resume()
    }
}
extension ViewController{
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}




