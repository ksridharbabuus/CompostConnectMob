//
//  PortsListViewController.m
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import "PortsListViewController.h"
#import "CompostPortsTableViewCell.h"
#import "RestService.h"

@interface PortsListViewController (){
    NSMutableArray *compostArray;
    NSMutableArray *compostValueArray;
    CGFloat screenWidth;
}

@end

@implementation PortsListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    compostArray = [[NSMutableArray alloc] init];
    
    [self fetchSensorInfo];
    //[self fetchSensorDataInfo];
    
    compostPortsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [compostPortsTableView setDataSource:self];
    [compostPortsTableView setDelegate:self];
    
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
#pragma Search Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [compostArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CompostPortsTableCell";
    CompostPortsTableViewCell *cell = (CompostPortsTableViewCell *)[compostPortsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[CompostPortsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display siteLocation in the table cell
    // NSMutableDictionary *sbgInfoDic = [siteLocSearchArray objectAtIndex:indexPath.row];
    // cell.siteLocation.text = [sbgInfoDic objectForKey:@"entityPlace"];
    // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *sensorVal = [[NSString alloc] init];
    NSMutableDictionary *portsDic = [compostArray objectAtIndex:indexPath.row];
    cell.compostPortName.text = [portsDic objectForKey:@"sensorName"];
    if(compostValueArray != nil && [compostValueArray count] >0){
        for(NSMutableDictionary *portsValDic in compostValueArray){
            if([[portsValDic objectForKey:@"sensorId"] isEqualToString:[portsDic objectForKey:@"id"]]){
                sensorVal = [portsValDic objectForKey:@"sensorVal"];
            }
        }
    }
    cell.status.text = sensorVal;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.status.text = @"full";
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *nearbyHeaderView;
        nearbyHeaderView = [[UIView alloc] initWithFrame:CGRectMake(10, compostPortsTableView.frame.origin.y, screenWidth-20, 50)];
        
        UILabel *nearbyHeaderText = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, screenWidth-20, 30)];
        [nearbyHeaderText setText:@"Composts Ports"];
        [nearbyHeaderText setFont:[UIFont fontWithName:@"Helvetica-light" size:20]];
        [nearbyHeaderText setTextColor:[UIColor colorWithRed:117/255.0 green:116/255.0 blue:116/255.0 alpha:1]];
        
        [nearbyHeaderView addSubview:nearbyHeaderText];
        [nearbyHeaderView setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1]];
    return nearbyHeaderView;
}




- (IBAction)gotoRegCompostPorts:(id)sender {
}

- (IBAction)gotoLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)fetchSensorInfo{
    if(true){
        NSString *address = @"http://compostconnect.azure-mobile.net/tables/Sensor";
        address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"Loading General Info URL --->: %@",address);
        [RestService requestPath:address RequestDics:nil onCompletion:^(NSData *generalInfoData, NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (generalInfoData.length > 0 && error == nil) {
                    NSString *string = [[NSString alloc] initWithData:generalInfoData encoding:NSUTF8StringEncoding];
                    NSArray *tempArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    compostArray = (NSMutableArray *)tempArray;
                    //if(compostValueArray != nil && [compostValueArray count] >0 && compostArray != nil && [compostArray count] >0){
                        [compostPortsTableView reloadData];
                    //}
                }else{
                    NSLog(@"---ERROR---");
                }
            });
        }];
    }
}

- (void)fetchSensorDataInfo{
    if(true){
        NSString *address = @"http://compostconnect.azure-mobile.net/tables/SensorTrans";
        address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"Loading General Info URL --->: %@",address);
        [RestService requestPath:address RequestDics:nil onCompletion:^(NSData *generalInfoData, NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (generalInfoData.length > 0 && error == nil) {
                    NSString *string = [[NSString alloc] initWithData:generalInfoData encoding:NSUTF8StringEncoding];
                    NSArray *tempArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    compostValueArray = (NSMutableArray *)tempArray;
                    if(compostValueArray != nil && [compostValueArray count] >0 && compostArray != nil && [compostArray count] >0){
                        [compostPortsTableView reloadData];
                    }
                }else{
                    NSLog(@"---ERROR---");
                }
            });
        }];
    }
}

@end
