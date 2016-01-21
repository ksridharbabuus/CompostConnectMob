//
//  RegSourceViewController.m
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import "RegSourceViewController.h"

@interface RegSourceViewController ()

@end

@implementation RegSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [address setPlaceholder:@"Address"];
    [contactName setPlaceholder:@"Contact Name"];
    [contactNum setPlaceholder:@"Contact Number"];
    [altContactNum1 setPlaceholder:@"alternative Contact Number1"];
    [altContactNum2 setPlaceholder:@"alternative Contact Number2"];
    [sourceType setPlaceholder:@"sourceType"];
    [longitude setPlaceholder:@"longitude"];
    [latitude setPlaceholder:@"latitude"];
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

- (IBAction)gotoHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
