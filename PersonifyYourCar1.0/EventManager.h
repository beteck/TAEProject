//
//  EventManager.h
//  PersonifyYourCar1.0
//
//  Created by TAE on 28/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface EventManager : NSObject
@property(nonatomic,strong) EKEventStore* evetStore;
@property(nonatomic)BOOL eventAccessGranted;
-(id)init;

@end
