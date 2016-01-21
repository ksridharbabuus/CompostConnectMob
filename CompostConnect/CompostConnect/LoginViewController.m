//
//  LoginViewController.m
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import "LoginViewController.h"
#import "RestService.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    password.secureTextEntry = TRUE;
    userName.text = @"Provider@honeywell.com";
    password.text = @"P@ssw0rd!";

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

- (IBAction)singIn:(id)sender {
    //PortsConViewSegue
    //[self performSegueWithIdentifier:@"PortsConViewSegue" sender:nil];
    //[self performSegueWithIdentifier:@"NearByPortsConViewSegue" sender:nil];
    
    [self fetchNearbyPortsInfo];
    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"PortsConViewSegue"]){
        //HomeViewController *homeConView = [segue destinationViewController];
    }else{
        
    }
}


- (void)fetchNearbyPortsInfo{
    if(true){
        NSString *address = @"http://compostconnect.azure-mobile.net/tables/User";
        address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"Loading General Info URL --->: %@",address);
        [RestService requestPath:address RequestDics:nil onCompletion:^(NSData *generalInfoData, NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (generalInfoData.length > 0 && error == nil) {
                    NSString *string = [[NSString alloc] initWithData:generalInfoData encoding:NSUTF8StringEncoding];
                    NSArray *tempArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    for(NSMutableDictionary *dic in tempArray){
                        if([[[dic objectForKey:@"email"] lowercaseString] isEqualToString:[userName.text lowercaseString]] && [[dic objectForKey:@"password"] isEqualToString:password.text]){
                            //[self singIn:[dic objectForKey:@"userType"]];
                            if([[dic objectForKey:@"userType"] isEqualToString:@"Consumer"]){
                                [self performSegueWithIdentifier:@"NearByPortsConViewSegue" sender:nil];
                            }else{
                                [self performSegueWithIdentifier:@"PortsConViewSegue" sender:nil];
                            }
                        }
                    }
                    
                }else{
                    NSLog(@"---ERROR---");
                }
            });
        }];
    }
}

@end
