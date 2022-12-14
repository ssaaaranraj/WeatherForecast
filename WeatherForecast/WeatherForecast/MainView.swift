//
//  MainView.swift
//  WeatherForecast
//
//  Created by ProV FSM on 07/12/22.
//

import UIKit

class MainView: UIView {


    var dataPassed: String! {
        didSet {
            cityLabel.text = dataPassed
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        self.addSubview(contentView)
        self.addSubview(contentView2)

    }
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupContentViewConstraints1()
    }
    
    fileprivate func setupContentViewConstraints1() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        contentView.addSubview(LocatioTitle)
        contentView.addSubview(cityLabel)
        contentView.addSubview(DateTime)
        contentView.addSubview(CountryLabel)
        contentView.addSubview(Temperature)



        contentView2.translatesAutoresizingMaskIntoConstraints = false
        contentView2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        contentView2.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        contentView2.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        contentView2.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    fileprivate func setupLabelConstraints() {
//        likeButton.translatesAutoresizingMaskIntoConstraints = false
//        likeButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
//        likeButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        
        LocatioTitle.translatesAutoresizingMaskIntoConstraints = false
        LocatioTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        LocatioTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        cityLabel.topAnchor.constraint(equalTo: LocatioTitle.topAnchor, constant: 10).isActive = true
        
        Temperature.translatesAutoresizingMaskIntoConstraints = false
        Temperature.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        Temperature.topAnchor.constraint(equalTo: LocatioTitle.topAnchor, constant: 10).isActive = true
        
        DateTime.translatesAutoresizingMaskIntoConstraints = false
        DateTime.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        DateTime.topAnchor.constraint(equalTo: LocatioTitle.topAnchor, constant: 10).isActive = true
        
        CountryLabel.translatesAutoresizingMaskIntoConstraints = false
        CountryLabel.leftAnchor.constraint(equalTo: cityLabel.leftAnchor, constant: 0).isActive = true
        CountryLabel.topAnchor.constraint(equalTo: cityLabel.topAnchor, constant: 10).isActive = true
    }

    
    
    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 13
        view.layer.borderColor = UIColor.lightGray.cgColor
//        view.backgroundColor = hexStringToUIColor(hex: "0000")
        return view
    }()
    let contentView2: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 13
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let LocatioTitle: UILabel = {
        let lb = UILabel(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 30, height: 35))
        lb.text = "Location Info"
        lb.textAlignment = .center
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.textColor = .white
        return lb
    }()
    
    let DateTime: UILabel = {
        let lb = UILabel(frame: CGRect(x: 10, y: 50, width: UIScreen.main.bounds.width - 50, height: 35))
        lb.text = "5.20PM sdf,msdf"
        lb.textAlignment = .right
        lb.textColor = .white
        return lb
    }()
    let cityLabel: UILabel = {
        let lb = UILabel(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width - 30, height: 45))
        lb.font = UIFont.systemFont(ofSize: 30)
        lb.textAlignment = .center
        lb.textColor = .white
//        lb.myLabel()
        return lb
    }()
    let Temperature: UILabel = {
        let lb = UILabel(frame: CGRect(x: 10, y: 150, width: UIScreen.main.bounds.width - 30, height: 45))
        lb.font = UIFont.systemFont(ofSize: 30)
        lb.textAlignment = .center
        lb.textColor = .white
//        lb.myLabel()
        return lb
    }()

    let CountryLabel: UILabel = {
        let lb = UILabel(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 35))
        lb.textAlignment = .center
        lb.textColor = .white
//        lb.myLabel()
        return lb
    }()
    

 

}
extension UILabel {
    func myLabel() {
        textAlignment = .left
        textColor = .black
        backgroundColor = .clear
        font = UIFont.systemFont(ofSize: 16)
        numberOfLines = 1
    }
}

