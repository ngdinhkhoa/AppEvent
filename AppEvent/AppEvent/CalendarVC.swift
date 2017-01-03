//
//  CalendarVC.swift
//  AppEvent
//
//  Created by Kata Mr on 1/3/17.
//  Copyright © 2017 Kata Mr. All rights reserved.
//

import UIKit

class CalendarVC: UIViewController {

    struct Color {
        static let selectedText = UIColor.whiteColor()
        static let text = UIColor.blackColor()
        static let textDisabled = UIColor.grayColor()
        static let selectionBackground = UIColor(red: 236/255, green: 0, blue: 56/255, alpha: 1.0)
        static let sundayText = text
        static let sundayTextDisabled = textDisabled
        static let sundaySelectionBackground = selectionBackground
    }
    @IBOutlet weak var lbMonthCurrent: UILabel!
    var animationFinished = true

    
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.title = "1"
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Settings"), style: .Plain, target: self, action: #selector(addTapped))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(addTapped))

        let leftButton = UIBarButtonItem(title: "Chiudi", style: .Plain, target: self, action: #selector(addTapped))
        let navigationItem = UINavigationItem()
        navigationItem.titleView = UIImageView(image: UIImage(named: "Settings"))
        navigationItem.leftBarButtonItem = leftButton
        
    }

    func addTapped(){
        print("hello")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        calendarMenuView.commitMenuViewUpdate()
        
        self.navigationItem.title = "aaaaaa"

    }
}

extension CalendarVC: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return true
    }
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    // MARK: Optional methods
    
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return UIColor.blackColor()
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        //        return shouldShowDaysOut
        return true
    }
    
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        let randomDay = 5
        if day == randomDay || day == 7 {
            return true
        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        return [Color.selectionBackground]
    }
    
    func dayOfWeekBackGroundColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    func didSelectDayView(dayView: DayView, animationDidFinish: Bool) {
        print(dayView.date.day,", ",dayView.date.globalDescription)
    }
    
//    func presentedDateUpdated(date: CVDate) {
//        
//        if lbMonthCurrent.text != date.globalDescription && self.animationFinished {
//            let updatedMonthLabel = UILabel()
//            updatedMonthLabel.textColor = lbMonthCurrent.textColor
//            updatedMonthLabel.font = lbMonthCurrent.font
//            updatedMonthLabel.textAlignment = .Center
//            updatedMonthLabel.text = date.globalDescription
//            updatedMonthLabel.sizeToFit()
//            updatedMonthLabel.alpha = 0
//            updatedMonthLabel.center = self.lbMonthCurrent.center
//            
//            let offset = CGFloat(44)
//            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
//            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
//            
//            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
//                self.animationFinished = false
//                self.lbMonthCurrent.transform = CGAffineTransformMakeTranslation(0, -offset)
//                self.lbMonthCurrent.transform = CGAffineTransformMakeScale(1, 0.1)
//                self.lbMonthCurrent.alpha = 0
//                
//                updatedMonthLabel.alpha = 1
//                updatedMonthLabel.transform = CGAffineTransformIdentity
//                
//            }) { _ in
//                
//                self.animationFinished = true
//                self.lbMonthCurrent.frame = updatedMonthLabel.frame
//                self.lbMonthCurrent.text = updatedMonthLabel.text
//                self.lbMonthCurrent.transform = CGAffineTransformIdentity
//                self.lbMonthCurrent.alpha = 1
//                updatedMonthLabel.removeFromSuperview()
//            }
//            
//            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.lbMonthCurrent)
//        }
//    }
    
    
}


// MARK: - CVCalendarViewAppearanceDelegate

extension CalendarVC: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
    
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFontOfSize(14) }
    
    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .Selected, _), (_, .Highlighted, _): return Color.selectedText
        case (.Sunday, .In, _): return Color.sundayText
        case (.Sunday, _, _): return Color.sundayTextDisabled
        case (_, .In, _): return Color.text
        default: return Color.textDisabled
        }
    }
    
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.Sunday, .Selected, _), (.Sunday, .Highlighted, _): return Color.sundaySelectionBackground
        case (_, .Selected, _), (_, .Highlighted, _): return Color.selectionBackground
        default: return nil
        }
    }
}
