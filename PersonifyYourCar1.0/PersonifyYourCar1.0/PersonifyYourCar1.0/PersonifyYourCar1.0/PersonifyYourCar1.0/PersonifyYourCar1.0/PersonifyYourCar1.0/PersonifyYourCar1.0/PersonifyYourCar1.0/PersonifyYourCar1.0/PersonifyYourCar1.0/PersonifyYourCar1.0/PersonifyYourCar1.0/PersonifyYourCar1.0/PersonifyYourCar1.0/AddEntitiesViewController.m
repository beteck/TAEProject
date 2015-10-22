//
//  AddEntitiesViewController.m
//  PersonifyYourCar
//
//  Created by TAE on 16/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "AddEntitiesViewController.h"
#import "WebService.h"


@interface AddEntitiesViewController()

-(NSArray*)convertStringsToArrayOfstrings;

@end

@implementation AddEntitiesViewController

-(NSArray*)convertStringsToArrayOfstrings
{
    
    NSArray* arrayOfStrings = [[NSArray alloc]init];
    
    
    NSString* concatAttributes= [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%d",self.firstNameTextField.text,self.lastNameTextField.text,self.addressTextField.text,self.emailTextField.text,self.phoneTextField.text,self.passwordTextField.text,0];
    
    
    //convert concat string into array of attribute
    arrayOfStrings = [concatAttributes componentsSeparatedByString:@"|"];
    
    return arrayOfStrings;
}

- (IBAction)registerPerson:(id)sender
{
    NSArray* personAttributes = [self convertStringsToArrayOfstrings];
    
    NSData* addedPerson = [WebService addPerson:personAttributes];
    
    NSString* addedPersonReadable =[WebService convertNSDATAToHumanReadableFormat:addedPerson];
    
    NSLog(@"%@",addedPersonReadable);
    
    
    
}


@end
