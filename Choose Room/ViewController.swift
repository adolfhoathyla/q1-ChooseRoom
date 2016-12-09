//
//  ViewController.swift
//  Choose Room
//
//  Created by Adolfho Athyla on 02/12/16.
//  Copyright © 2016 a7hyla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var room: UILabel!
    @IBOutlet var age: UILabel!
    
    var room1Limit: Date?
    var room2Limit: Date?
    var room3limit: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateLimits()
        datePicker.maximumDate = Date()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func findRoom(_ sender: UIButton) {
        let age = calculateAge(dateOfBirth: datePicker.date)
        chooseRoom(age: age)
        
        let ageComponent = NSCalendar.current.dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: age)
        let ageText = "\(ageComponent.year!) anos, \(ageComponent.month!) meses, \(ageComponent.day!) dias"
        self.age.text = ageText
        if self.age.isHidden { self.age.isHidden = false }
        
    }
    
    private func generateLimits() {
        //generate room 1 limit
        var components1 = DateComponents()
        components1.year = 25
        components1.month = 2
        components1.day = 15
        room1Limit = Calendar.current.date(from: components1)
        
        //generate room 2 limit
        var components2 = DateComponents()
        components2.year = 45
        components2.month = 1
        room2Limit = Calendar.current.date(from: components2)
        
        
        //generate room 3 limit
        var components3 = DateComponents()
        components3.year = 65
        room3limit = Calendar.current.date(from: components3)
        
    }
    
    private func calculateAge(dateOfBirth: Date) -> Date {
        let calendar = Calendar.current
        
        var ageComponent = Calendar.current.dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: dateOfBirth, to: Date())
        
        if ageComponent.month == 0 {
            ageComponent.month = 1
        }
        
        let age = calendar.date(from: ageComponent)
        
        return age!
    }

    private func chooseRoom(age: Date) {
        if room1Limit!.compare(age) == .orderedDescending || room1Limit!.compare(age) == .orderedSame {
            room.text = "Sala 1"
        } else {
            if room2Limit!.compare(age) == .orderedDescending {
                room.text = "Sala 2"
            } else {
                if room3limit!.compare(age) == .orderedDescending {
                    room.text = "Sala 3"
                } else {
                    room.text = "Sala 4"
                }
            }
        }
        if room.isHidden { room.isHidden = false }
    }
    
}

