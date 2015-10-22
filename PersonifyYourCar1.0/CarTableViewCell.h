//
//  CarTableViewCell.h
//  PersonifyYourCar1.0
//
//  Created by TAE on 21/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel* carNameLabel;
@property(nonatomic,weak)IBOutlet UILabel* carModelLabel;
@property(nonatomic,weak)IBOutlet UILabel* carPriceLabel;
@property(nonatomic,weak)IBOutlet UIImageView* carImage;

@end
