//
//  Person.m
//  PersonifyYourCar1.0
//
//  Created by TAE on 28/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "Person.h"

@implementation Person

-(id)init
{
    
    self = [super init];
    if(self)
    {
        self.firstName = [[NSString alloc]init];
        self.lastName = [[NSString alloc]init];
        self.emailAdd = [[NSString alloc]init];
        self.passWord = [[NSString alloc]init];
        self.address = [[NSString alloc]init];
        self.phone = [[NSString alloc]init];
        self.carFleet = [[NSMutableArray alloc]init];
    }
    
    return self;
}

@end
