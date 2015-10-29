//
//  CoreDataManager.h
//  PersonifyYourCar
//
//  Created by TAE on 16/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface CoreDataManager : NSObject
+(void)addPerson:(NSArray*)arrayOfPersonAttributes;
+(void)addCar:(NSArray*)arrayOfCarAttributes;
+(void)createRelationship:(NSManagedObject*)object1 secondobject:(NSManagedObject*)object2 specifiedrealtion:(NSString*)relation;
+(NSArray*)extractAllEntitiesOfSpecifiedType:(NSString*)specifiedType;

@end
