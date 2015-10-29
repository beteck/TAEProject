//
//  Car.m
//  PersonifyYourCar1.0
//
//  Created by TAE on 28/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "Car.h"

@implementation Car

-(id)init
{
    self = [super init];
    
    if(self)
    {
        self.carBrand = [[NSString alloc]init];
        self.carImage = [[NSString alloc]init];
        self.carModel = [[NSString alloc]init];
        self.carPrice = [[NSString alloc]init];
    }
    
    return self;
}

@end
