//
//  WebService.h
//  PersonifyYourCar1.0
//
//  Created by TAE on 20/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

/**
 *This class handles the web services. It uses JSON to;
 *Retrieves models from the web server
 *Update models on the server
 *Add models on the server
 *Delete models stored on the server
 
 */

@interface WebService : NSObject
+(NSData*)addPerson:(NSArray*)personAttributes;
+(NSString*)convertNSDATAToHumanReadableFormat:(NSData*)nsdataObject;
+(NSData*)addCar:(NSArray*)carAttributes;
+(NSArray*)getAllEntitiesOfSpecifiedType:(NSString*)objectType;
+(UIImage*)imageFromUrl:(NSString*)url  fromcache:(BOOL)fromCache;

@end
