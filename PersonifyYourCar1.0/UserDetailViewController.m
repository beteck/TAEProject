//
//  UserDetailViewController.m
//  PersonifyYourCar1.0
//
//  Created by TAE on 28/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "UserDetailViewController.h"
#import "WebService.h"
#import "Car.h"
#import "CustomCarCell.h"


@interface UserDetailViewController ()
/**
 *Array to hold all the cars that belongs to the user
 *Cars are in the dictionary format that is return from the web server
 */
@property(strong,nonatomic)NSMutableArray* carsInGarage;

-(void)getCarsInUsersGarage;
-(Car*)composedCar:(NSString*)webCar;

@end

@implementation UserDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentUser = [[Person alloc]init];
    self.carsInGarage = [[NSMutableArray alloc]init];
    
    [self getCarsInUsersGarage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *Etracts a list of cars link to a particular individual
 *Retrieves all the cars stored on the web server
 * And then extract from it a list of cars that have been picked by the user
 */

-(void)getCarsInUsersGarage
{
    //Extract all cars linked to user
    NSArray* allcars = [WebService getAllEntitiesOfSpecifiedType:@"Car"];
    
    for(int i=0; i<[allcars count];i++)
    {
        
        
        [self.carsInGarage addObject:[allcars objectAtIndex:1]];
        
        
//        for(int j=0; j<[self.currentUser.carFleet count];j++)
//        {
//            [self composedCar:[[allcars objectAtIndex:i]valueForKey:@"name" ]];
//            
////            if([allcars objectAtIndex:i]valueForKey:<#(NSString *)#>)
////            {
////                
////            }
//        }
        
        
        
        
    }
}

/**
 *Construct a car model from the dictionary representation of the car thats return via json
 *@param format in which the car is returned from the web server
 *@return a car model
 */

-(Car*)composedCar:(NSString *)webCar
{
    Car* car = [[Car alloc]init];
    
    NSString* carDescription = [webCar valueForKey:@"name"];
    
    NSArray* carAttributes = [carDescription componentsSeparatedByString:@"-"];
    
    [car setCarBrand:[carAttributes objectAtIndex:4]];
    [car setCarModel:[carAttributes objectAtIndex:5]];
    [car setCarPrice:[carAttributes objectAtIndex:6]];
    [car setCarImage:[carAttributes objectAtIndex:7]];
    
    
    car.carImage = [car.carImage stringByReplacingOccurrencesOfString:@"@" withString:@"-"];
    car.carImage = [car.carImage stringByReplacingOccurrencesOfString:@" " withString:@""];
    car.carImage = [car.carImage stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return car;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.carsInGarage count];
}

-(CustomCarCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CarViewCell";
    
    CustomCarCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Car* car = [self composedCar:[self.carsInGarage objectAtIndex:indexPath.row]];
    
    //NSString* carImage =
    
    cell.carBrandDisplay.text = car.carBrand;
    cell.carModelDisplay.text = car.carModel;
    
    cell.carImage.image = [WebService imageFromUrl:car.carImage fromcache:TRUE];
    
    
    return cell;
}
@end
