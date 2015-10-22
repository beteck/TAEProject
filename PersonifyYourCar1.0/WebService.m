//
//  WebService.m
//  PersonifyYourCar1.0
//
//  Created by TAE on 20/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "WebService.h"


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)
#define WebAddress [NSURL URLWithString: @"https://cmshopper.herokuapp.com"]
#define MyToken @"8470b269c7ec97b8643f74879e9928d0"


@interface WebService()

+(NSArray*) extractAllEntitiesFromWeb;
+(NSString*)getCacheFolder;
+(NSData*)getDataFromUrl:(NSString*)url fromcache:(BOOL)fromCache;
@end

@implementation WebService

+(NSData*)addPerson:(NSArray *)personAttributes
{
    NSData* webPerson = [[NSData alloc]init];
    
    NSString* jsonURL = [NSString stringWithFormat:@"%@/items.json",WebAddress];
    NSURL* URL = [NSURL URLWithString:jsonURL];
    
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc]initWithURL:URL];
    
    //Set the HTTP specific properties
    [urlRequest addValue:MyToken forHTTPHeaderField:@"X-CM-Authorization"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"The URL request is: %@",urlRequest);
    
    //Create a dictionary containing data to send to the server formated in the structure of the data in server
    NSDictionary* person = @{
                             @"item": @{
                                     @"category" : @"Person",
                                     @"name" : personAttributes,
                                     }
                             
                             
                             
                             };
    
    
    
    //Convert foundamental data into jsonobject
    NSError* error;
    NSData* jsonObject =[NSJSONSerialization dataWithJSONObject:person options:NSJSONWritingPrettyPrinted error:&error];
    
    //Specify request body with data to be loaded to server
    [urlRequest setHTTPBody:jsonObject];
    
    //Load data to server
    NSURLResponse* loadResponse = nil;
    webPerson = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&loadResponse error:&error];
    
    
    //returning person as NSDATA
    return webPerson;
}


+(NSString*)convertNSDATAToHumanReadableFormat:(NSData *)nsdataObject
{
    NSString* webObject = [[NSString alloc]init];
    
    webObject = [[NSString alloc]initWithData:nsdataObject encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",webObject);
    
    return  webObject;
}


+(NSData*)addCar:(NSArray *)carAttributes
{
    NSData* webCar = [[NSData alloc]init];
    
    NSString* jsonURL = [NSString stringWithFormat:@"%@/items.json",WebAddress];
    NSURL* URL = [NSURL URLWithString:jsonURL];
    
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc]initWithURL:URL];
    
    //Set the HTTP specific properties
    [urlRequest addValue:MyToken forHTTPHeaderField:@"X-CM-Authorization"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"The URL request is: %@",urlRequest);
    
    //Create a dictionary containing data to send to the server formated in the structure of the data in server
    NSDictionary* person = @{
                             @"item": @{
                                     @"category" : @"Car",
                                     @"name" : carAttributes,
                                     }
                             
                             
                             
                             };
    
    //Convert foundamental data into jsonobject
    NSError* error;
    NSData* jsonObject =[NSJSONSerialization dataWithJSONObject:person options:NSJSONWritingPrettyPrinted error:&error];
    
    //Specify request body with data to be loaded to server
    [urlRequest setHTTPBody:jsonObject];
    
    //Load data to server
    NSURLResponse* loadResponse = nil;
    webCar = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&loadResponse error:&error];

    
    //web car in NSDATA
    return webCar;
}

+(NSArray*) extractAllEntitiesFromWeb
{
    
    //prepare URL for targeted model
    NSString* jsonURL = [NSString stringWithFormat:@"%@/items.json",WebAddress];
    NSURL* URL = [NSURL URLWithString:jsonURL];
    
    //cerate a mutable URL request object so as to easily mutate the same url request object to accomodate different URL request
    //return a url request with default cache policy and timeout - 60s
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc]initWithURL:URL];
    
    //Set the HTTP specific properties
    [urlRequest addValue:MyToken forHTTPHeaderField:@"X-CM-Authorization"];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSLog(@"The URL request is: %@",urlRequest);
    
    //Load the the  URL request
    NSURLResponse* loadResponse = nil;
    NSError* loadError = nil;
    
    
    //Could this be spawn on a background thread?
    NSData* loadedData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&loadResponse error:&loadError];
    
    //Check if connection and loading is successful
    if(loadedData == nil)
    {
        NSLog(@"Connection/Load is Failed");
    }
    
    
    //Check the type of json object expected
    NSError* error = nil;
    
    // NSLog(@"%@",[[NSJSONSerialization JSONObjectWithData:loadedData options:(kNilOptions) error:&error]class]);
    
    //convert json data into foundation data
    
    NSMutableArray* arrayOfDictionaries = [NSJSONSerialization JSONObjectWithData:loadedData options:(kNilOptions) error:&error];
    //    NSLog(@"%@",arrayOfDictionaries);
    
    return arrayOfDictionaries;
    
    
}



+(NSArray*)getAllEntitiesOfSpecifiedType:(NSString *)objectType
{
    NSArray* arrayOfAllObjectsFromServer = [[NSArray alloc]init];
    
    NSMutableArray* arrayOfObjects = [[NSMutableArray alloc]init];
    
    arrayOfAllObjectsFromServer =[self extractAllEntitiesFromWeb];
    
    
    for(int i=0; i<[arrayOfAllObjectsFromServer count];i++)
    {
        NSLog(@"%@",[[arrayOfAllObjectsFromServer objectAtIndex:i]valueForKey:@"category"]);
        NSLog(@"%@",[arrayOfAllObjectsFromServer objectAtIndex:i]);
        
        if([[[arrayOfAllObjectsFromServer objectAtIndex:i]valueForKey:@"category"]isEqualToString:objectType])
        {
            [arrayOfObjects addObject:[arrayOfAllObjectsFromServer objectAtIndex:i]];
        }
    }
    
    return arrayOfObjects;
}

+(NSString*)getCacheFolder
{
    NSString* docDirectory = [[NSString alloc]init];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray* docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    docDirectory = [docPaths objectAtIndex:0];
    docDirectory = [docDirectory stringByAppendingPathComponent:@"/.tmp"];
    
    BOOL isDir;
    
    if(!([fileManager fileExistsAtPath:docDirectory isDirectory:&isDir] && isDir))
    {
        [fileManager createDirectoryAtPath:docDirectory withIntermediateDirectories:YES attributes:nil error:Nil];
    }
    
    
    return docDirectory;
}

+(NSData*)getDataFromUrl:(NSString *)url fromcache:(BOOL)fromCache
{
    NSData* urlData;
    
    if(url != nil && [url compare:@""]!= NSOrderedSame)
    {
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSString* furl = [NSString stringWithFormat:@"%@/%@",[self getCacheFolder],url];
        
        //NSLog(@"%@",[url stringByReplacingOccurrencesOfString:@"\\" withString:@"!!!!"]);
        
        if(fromCache && [fileManager fileExistsAtPath:furl]==YES)
        {
            urlData = [fileManager contentsAtPath:furl];
            
        }
        else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            
            //NSLog(@"The URL is: %@",url);
            
            
            NSURL * tempUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
          
                               
            //NSLog(@"The NSURL is: %@",tempUrl);

            
            
            NSError* error;
            urlData = [NSData dataWithContentsOfURL:tempUrl options:NSDataReadingMappedIfSafe error:&error];
            
            if(urlData && !error)
            {
                [fileManager createFileAtPath:furl contents:urlData attributes:Nil];
            }
            else{
                NSLog(@"%@",error);
            }
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
        
    }
    
    return urlData;
}

+(UIImage*)imageFromUrl:(NSString *)url fromcache:(BOOL)fromCache
{
    UIImage* imageData = [[UIImage alloc]init];
    
    if(url != nil && [url compare:@""]!= NSOrderedSame)
    {
        NSData* data = [self getDataFromUrl:url fromcache:fromCache];
        
        if(data)
        {
            imageData = [[UIImage alloc] initWithData:data];
        }
    }
    return imageData;
}

@end
