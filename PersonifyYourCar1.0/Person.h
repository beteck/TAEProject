//
//  Person.h
//  PersonifyYourCar1.0
//
//  Created by TAE on 28/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property(strong,nonatomic)NSString* firstName;
@property(strong,nonatomic)NSString* lastName;
@property(strong,nonatomic)NSString* emailAdd;
@property(strong,nonatomic)NSString* passWord;
@property(strong,nonatomic)NSString* address;
@property(strong,nonatomic)NSString* phone;
//store the name of user's cars
@property(strong,nonatomic)NSMutableArray* carFleet;


@end
