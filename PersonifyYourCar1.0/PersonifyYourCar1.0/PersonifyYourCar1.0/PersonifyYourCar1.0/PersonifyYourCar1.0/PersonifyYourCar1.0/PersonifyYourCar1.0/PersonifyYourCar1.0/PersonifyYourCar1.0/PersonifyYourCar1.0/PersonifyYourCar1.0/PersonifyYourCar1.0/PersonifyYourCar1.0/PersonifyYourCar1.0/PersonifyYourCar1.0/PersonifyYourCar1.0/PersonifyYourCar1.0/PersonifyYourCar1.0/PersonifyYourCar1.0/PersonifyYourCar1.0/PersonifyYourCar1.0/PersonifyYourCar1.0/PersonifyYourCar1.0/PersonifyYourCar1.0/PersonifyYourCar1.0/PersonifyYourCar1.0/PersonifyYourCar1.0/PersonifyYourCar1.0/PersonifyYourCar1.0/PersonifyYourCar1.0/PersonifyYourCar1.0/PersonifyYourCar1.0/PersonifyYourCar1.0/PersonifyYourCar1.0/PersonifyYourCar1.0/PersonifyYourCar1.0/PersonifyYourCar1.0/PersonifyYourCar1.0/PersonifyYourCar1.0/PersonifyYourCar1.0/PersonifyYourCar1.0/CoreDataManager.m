//
//  CoreDataManager.m
//  PersonifyYourCar
//
//  Created by TAE on 16/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"

@implementation CoreDataManager


//Retrieved the managed object context from AppDelegate

+(NSManagedObjectContext*)managedObjectContext{
    
    NSManagedObjectContext* context = nil;
    
    id delegate = [[UIApplication sharedApplication]delegate];
    
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return  context;
}

+(void)addPerson:(NSArray *)arrayOfPersonAttributes
{
    
    //Get the managed Object Context
    NSManagedObjectContext* moc = [self managedObjectContext];
    
    //Create a new managed object with the entity structure or definition
    //This creates in managed object context a structure for our entity
    NSManagedObject* newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc];

    //Now write the values to our entity
    [newPerson setValue:[arrayOfPersonAttributes objectAtIndex:0] forKey:@"lastName"];
    [newPerson setValue:[arrayOfPersonAttributes objectAtIndex:1] forKey:@"firstName"];
    [newPerson setValue:[arrayOfPersonAttributes objectAtIndex:2] forKey:@"address"];
    [newPerson setValue:[arrayOfPersonAttributes objectAtIndex:3] forKey:@"email"];
    [newPerson setValue:[arrayOfPersonAttributes objectAtIndex:4] forKey:@"phone"];
    [newPerson setValue:[arrayOfPersonAttributes objectAtIndex:5] forKey:@"carCount"];
    
    //Verify the addition was successfull
    NSError* error = nil;
    //Save new person to persisten storage
    if(![moc save:&error])
    {
        NSLog(@"FAILED to add %@",[arrayOfPersonAttributes objectAtIndex:0]);
    }
    else{
        NSLog(@"SUCCESS! %@  has been added to store",[arrayOfPersonAttributes objectAtIndex:0]);
    }
    
    
}

+(void)addCar:(NSArray *)arrayOfCarAttributes
{
    
    //Get the managed Object Context
    NSManagedObjectContext* moc = [self managedObjectContext];
    
    //Create a new managed object with the entity structure or definition
    //This creates in managed object context a structure for our entity
    NSManagedObject* newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc];
    
    //Now write the values to our entity
    [newPerson setValue:[arrayOfCarAttributes objectAtIndex:0] forKey:@"brandName"];
    [newPerson setValue:[arrayOfCarAttributes objectAtIndex:1] forKey:@"modelName"];
    [newPerson setValue:[arrayOfCarAttributes objectAtIndex:2] forKey:@"linkCount"];
   
    
    //Verify the addition was successfull
    NSError* error = nil;
    //Save new person to persisten storage
    if(![moc save:&error])
    {
        NSLog(@"FAILED to add %@",[arrayOfCarAttributes objectAtIndex:0]);
    }
    else{
        NSLog(@"SUCCESS! %@  has been added to store",[arrayOfCarAttributes objectAtIndex:0]);
    }
    
    
    
}
//creates a relationship between two core data entities
//relationship to be created is specified by the relation
+(void)createRelationship:(NSManagedObject *)object1 secondobject:(NSManagedObject *)object2 specifiedrealtion:(NSString *)relation
{
    
    [object1 setValue:[NSSet setWithObjects:object2, nil] forKey:relation];
    
    NSError*error = nil;
    
    if([object1.managedObjectContext save:&error])
    {
        NSLog(@"Creating relationship:Failed");
        NSLog(@"%@ %@",error,error.localizedDescription);
    }
    
}

@end
