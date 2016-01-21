//
//  UserRegViewController.m
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import "UserRegViewController.h"

@interface UserRegViewController ()

@end

@implementation UserRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [password setSecureTextEntry:YES];
    [firstName setPlaceholder:@"First Name"];
    [lastName setPlaceholder:@"Last Name"];
    [email setPlaceholder:@"Email ID"];
    
    [contactNo setPlaceholder:@"Contact Number"];
    [userType setPlaceholder:@"User Type"];
    [password setPlaceholder:@"password"];
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

- (IBAction)gotoLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
