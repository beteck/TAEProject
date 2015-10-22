//
//  CarViewController.m
//  PersonifyYourCar
//
//  Created by TAE on 19/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "CarViewController.h"
#import "WebService.h"
#import "CarTableViewCell.h"


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
    NSString* carImageUrl;
    UIImage* carImage;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //initialize the cars to be displayed by downloading them from the web server.
    dictionaryRepOfCars = [WebService getAllEntitiesOfSpecifiedType:@"Car"];
    
    carImageUrl = @"http://www.autotrader.co.uk/content/2016-nissan-leaf-30kwh-first-drive";
    
    
    for(int i=0; i<[dictionaryRepOfCars count];i++)
    {
        NSObject* obj = [dictionaryRepOfCars objectAtIndex:i];
        NSLog(@"%@",obj);
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dictionaryRepOfCars count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self composeData:indexPath.row];
    
    
    
    //the cell identifier
    static NSString* carCell = @"CarDisplayCell";
    
    CarTableViewCell* cell = (CarTableViewCell*)[tableView dequeueReusableCellWithIdentifier:carCell];
    
    if(cell == nil)
    {
        //cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carCell];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CarDisplayCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        

    }
    
    carImage = [WebService imageFromUrl:carImageUrl fromcache:TRUE];
    
    cell.carNameLabel.text = self.carName;
    cell.carImage.image = carImage;
    cell.carModelLabel.text = self.carModel;
    cell.carPriceLabel.text = self.carPrice;
    
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
    carImageUrl = [attributesComponents objectAtIndex:7];
    carImageUrl = [carImageUrl stringByReplacingOccurrencesOfString:@"@" withString:@"-"];
    carImageUrl = [carImageUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    carImageUrl = [carImageUrl stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
}

@end
