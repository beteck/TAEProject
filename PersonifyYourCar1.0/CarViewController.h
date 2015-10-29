//
//  CarViewController.h
//  PersonifyYourCar
//
//  Created by TAE on 19/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *@brief Displays all the cars currently available for trading
 *@brief Downloads from the web server all cars and display them in a table view
 */

@interface CarViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@end
