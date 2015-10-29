//
//  EventManager.m
//  PersonifyYourCar1.0
//
//  Created by TAE on 28/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "EventManager.h"

@implementation EventManager

-(id)init
{
    self = [super init];
    if(self)
    {
        self.evetStore = [[EKEventStore alloc]init];
        
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        
        //check if event access granted value exist in user defaults dictionary
        if([userDefaults valueForKey:@"eventkit_events_access_granted"] != Nil)
        {
            //if value exist assign it to property
            // self.eventAccessGranted = [[userDefaults valueForKey:@"eventkit_events_access_granted"]i];
            self.eventAccessGranted = [userDefaults boolForKey:@"eventkit_events_access_granted"];
        }
        else
        {
            //set default value
            self.eventAccessGranted = NO;
            
        }
    }
    
    return self;
}

-(void)setEventAccessGranted:(BOOL)eventAccessGranted
{
    _eventAccessGranted = eventAccessGranted;
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithBool:eventAccessGranted] forKey:@"eventkit_events_access_granted"];
}

@end
