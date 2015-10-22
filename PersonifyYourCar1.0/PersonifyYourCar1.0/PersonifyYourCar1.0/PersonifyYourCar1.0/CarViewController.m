//
//  CarViewController.m
//  PersonifyYourCar
//
//  Created by TAE on 19/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "CarViewController.h"
#import "WebService.h"


@interface CarViewController()

@property NSString* carName;
@property(nonatomic)NSString* carModel;
@property(nonatomic)NSString* carPrice;

-(void)composeData:(NSInteger)index;

@end

@implementation CarViewController
{
    NSArray* cars;
    NSArray* dictionaryRepOfCars;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //initialize the cars to be displayed by downloading them from the web server.
    dictionaryRepOfCars = [WebService getAllEntitiesOfSpecifiedType:@"Car"];
  
    
//    NSString* testdata = [[dictionaryRepOfCars objectAtIndex:1]valueForKey:@"name"];
//    NSArray* data = [testdata componentsSeparatedByString:@"-"];
    
//    NSLog(@"%@",testdata);
//    NSLog(@"%@",[[dictionaryRepOfCars objectAtIndex:1]valueForKey:@"name"]);
//    NSArray* test = [WebService convertDictionaryToString:[dictionaryRepOfCars objectAtIndex:1]];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dictionaryRepOfCars count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self composeData:indexPath.row];
    
    
    
    //the cell identifier
    static NSString* carOnDisplay = @"CarOnDisplay";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:carOnDisplay];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carOnDisplay];
    }
    
    cell.textLabel.text = self.carName;
    
    return cell;
}

-(void)composeData:(NSInteger)index
{
    //get array of attributes
    NSString* carAttributes = [[dictionaryRepOfCars objectAtIndex:index]valueForKey:@"name"];
    
    //Separate attributes into separate components  -brand name,model name,etc
    NSArray* attributesComponents = [carAttributes componentsSeparatedByString:@"-"];
    
    self.carName = [attributesComponents objectAtIndex:4];
    self.carModel = [attributesComponents objectAtIndex:5];
    self.carPrice = [attributesComponents objectAtIndex:6];
    
}

@end
