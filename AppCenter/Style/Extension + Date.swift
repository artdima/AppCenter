//
//  Extension + Date.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

extension Date {
    static func getFormattedDate(string: String) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
                                                                                    
        guard let date = dateFormatterGet.date(from: string) else { return nil}
        return dateFormatterPrint.string(from: date)
    }
}
