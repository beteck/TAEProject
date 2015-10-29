//
//  CustomCarCell.h
//  PersonifyYourCar1.0
//
//  Created by TAE on 28/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * A customed cell to display the attributes of a car
 *has place holders for 
 *car brand name
 *car model name
 *picture of the car
 
 */

@interface CustomCarCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *carBrandDisplay;
@property (strong, nonatomic) IBOutlet UILabel *carModelDisplay;
@property (strong, nonatomic) IBOutlet UIImageView *carImage;


@end
