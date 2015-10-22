//
//  AddCarViewController.m
//  PersonifyYourCar
//
//  Created by TAE on 16/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "AddCarViewController.h"
#import "WebService.h"



@interface AddCarViewController()

-(NSArray*)convertStringsToArrayOfstrings;

@end

@implementation AddCarViewController

-(NSArray*)convertStringsToArrayOfstrings
{
    NSArray* carAttributes = [[NSArray alloc]init];
    
    NSString* concatAttributes= [NSString stringWithFormat:@"%@|%@|%@",self.carBrandTextField.text,self.carModelTextField.text,self.carPriceTextField.text];
    carAttributes = [concatAttributes componentsSeparatedByString:@"|"];
    
    return carAttributes;
}

- (IBAction)registerCar:(id)sender
{
    
    NSArray* carAttributes = [self convertStringsToArrayOfstrings];
    
    NSData* addedCar = [WebService addCar:carAttributes];
    
    NSString* addedCarHumanReadable = [WebService convertNSDATAToHumanReadableFormat:addedCar];
    
    
}
@end
