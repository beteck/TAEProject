//
//  LoginViewController.m
//  PersonifyYourCar1.0
//
//  Created by TAE on 28/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "LoginViewController.h"
#import "Person.h"
#import "CoreDataManager.h"
#import "WebService.h"
#import "UserDetailViewController.h"

/**
 *@discussion This file handles the login in to gain access to the service
 *It will accept users login detail and then compare it against
 *a list of registered user for validation
 */

@interface LoginViewController ()

@property(nonatomic)Person* currentUser;

-(BOOL)validateLoginDetails;
-(BOOL)isUserRegistered;
-(void)composedData:(NSString*)dataString;

@end

@implementation LoginViewController
{
    Person *tempPerson;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentUser = [[Person alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"logintodetailpersonview"])
    {
        UserDetailViewController* destinationViewController = segue.destinationViewController;
        destinationViewController.currentUser = self.currentUser;
    }
}


/*!
 *@brief Check that enough details have been provided for the login phase
 */
-(BOOL)validateLoginDetails
{
    BOOL valid = FALSE;
    
    if( self.emailAddTextField.text.length > 0 && self.passwordTextField.text.length > 0)
    {
        valid = TRUE;
    }
    
    return valid;
}

/*!
 *@brief  Validates the the user is registered with the service
 *param 
 *return
 */
-(BOOL)isUserRegistered
{
    BOOL isRegistered = FALSE;
    
    //Check on persitent store - coredata is user is known to device
    //NSArray* arrayOfAllPersonsOnPersistentStore = [CoreDataManager extractAllEntitiesOfSpecifiedType:@"Person"];
    NSArray* allRegisteredPersonsOnWeb = [WebService getAllEntitiesOfSpecifiedType:@"Person"];
    
    for(int i=0; i< [allRegisteredPersonsOnWeb count];i++)
    {
        [self composedData:[[allRegisteredPersonsOnWeb objectAtIndex:i]valueForKey:@"name"]];
        
        NSLog(@"registered member Email:%@  loggers's email:%@",self.currentUser.emailAdd,tempPerson.emailAdd);
        NSLog(@"registered member password:%@  loggers's password:%@",self.currentUser.passWord,tempPerson.passWord);
        
        if(/*[self.currentUser.emailAdd isEqualToString:tempPerson.emailAdd] &&*/ [self.currentUser.passWord isEqualToString:tempPerson.passWord])
        {
            return true;
        }
        
    }
    
    
    
    return isRegistered;
}

/*!
 *@discussion Construct a model user(Person) from the dictionary description of a person
 *that is return from the web server
 *@param a string that represents the data downloaded from the web
 */

-(void)composedData:(NSString *)dataString
{
    //Separate attributes into separate components  -brand name,model name,etc
    NSArray* attributesComponents = [dataString componentsSeparatedByString:@"-"];
    
    [self.currentUser setFirstName:attributesComponents[4]];
    [self.currentUser setLastName:attributesComponents[5]];
    [self.currentUser setAddress:attributesComponents[6]];
    [self.currentUser setEmailAdd:attributesComponents[7]];
    [self.currentUser setPhone:attributesComponents[8]];
    //[self.currentUser setPassWord:attributesComponents[9]];
    
    
    NSString* pw = [attributesComponents[9] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
//    NSLog(@"%@",pw);
    
    [self.currentUser setPassWord:[pw stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [self.currentUser setPassWord:[pw stringByReplacingOccurrencesOfString:@"\n" withString:@""]];

    
//    [carImageUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
 //   NSLog(@" current user's first name: %@",self.currentUser.firstName);
    
    
}

/*!
 @discussion Handles the login process
 *Verifies that enough details for login is provided
 *Verifies that the provided login details are registered with the service
 */

- (IBAction)loginButton:(id)sender
{
    if(![self validateLoginDetails])
    {
        self.loginResponseDisplay.text = @"You must enter all login fields";
        return;
    }
    
    
    //create temp person
    tempPerson = [[Person alloc]init];
    [tempPerson setEmailAdd:self.emailAddTextField.text];
    [tempPerson setPassWord:self.passwordTextField.text];
    
 
    
    //verify that provided login details is registered with service
    
   if( [self isUserRegistered])
   {
       //Transition to users detail view
       [self performSegueWithIdentifier:@"logintodetailpersonview" sender:sender];
   }
    else
    {
        //Display message to register
        self.loginResponseDisplay.text = @"You must be a registered member to use this service";
    }
    
    
    
    
}
@end
