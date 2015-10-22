//
//  AddCarViewController.h
//  PersonifyYourCar
//
//  Created by TAE on 16/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCarViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *carBrandTextField;
@property (strong, nonatomic) IBOutlet UITextField *carModelTextField;
@property (strong, nonatomic) IBOutlet UITextField *imageUrlTextField;
@property (strong, nonatomic) IBOutlet UITextField *carPriceTextField;
- (IBAction)registerCar:(id)sender;

@end
