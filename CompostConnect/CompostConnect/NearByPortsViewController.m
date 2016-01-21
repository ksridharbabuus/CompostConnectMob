//
//  NearByPortsViewController.m
//  CompostConnect
//
//  Created by Honeywell International Inc on 1/21/16.
//  Copyright © 2016 Honeywell International Inc. All rights reserved.
//

#import "NearByPortsViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ZSPinAnnotation.h"
#import "ZSAnnotation.h"
#import "RestService.h"


@interface NearByPortsViewController (){
    NSMutableArray *annotationArray;
}

@end

@implementation NearByPortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


#pragma mark - MapKit

- (void)reloadMapWithNearbySitesInfo:(NSArray *) nearbySitesInfoArray{
    ZSAnnotation *annotation = nil;
    [nearByPortsMapView removeAnnotations:annotationArray];
    
    annotationArray = [[NSMutableArray alloc] init];
    for(NSMutableDictionary *addressDic in nearbySitesInfoArray){
        if (addressDic != nil && [addressDic count] >0) {
            annotation = [[ZSAnnotation alloc] init];
            
            annotation.coordinate = CLLocationCoordinate2DMake([[addressDic objectForKey:@"latitude"] doubleValue], [[addressDic objectForKey:@"longitude"] doubleValue]);
            
            /*if([[addressDic objectForKey:@"entityAddress"] isEqualToString:[selLocation objectForKey:@"entityAddress"]]){
             annotation.color = [UIColor redColor];
             }else{
             annotation.color = [UIColor blueColor];
             }*/
            
            annotation.color = [UIColor blueColor];
            annotation.title = [addressDic objectForKey:@"address"];
            [annotationArray addObject:annotation];
        }
    }
    
    // Center map
    nearByPortsMapView.visibleMapRect = [self makeMapRectWithAnnotations:annotationArray];
    
    // Add to map
    [nearByPortsMapView addAnnotations:annotationArray];
}

- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations {
    
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    return flyTo;
}

- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    
    // Don't mess with user location
    if(![annotation isKindOfClass:[ZSAnnotation class]])
        return nil;
    
    ZSAnnotation *a = (ZSAnnotation *)annotation;
    static NSString *defaultPinID = @"StandardIdentifier";
    
    // Create the ZSPinAnnotation object and reuse it
    ZSPinAnnotation *pinView = (ZSPinAnnotation *)[nearByPortsMapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (pinView == nil){
        pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    
    // Set the type of pin to draw and the color
    pinView.annotationType = ZSPinAnnotationTypeTagStroke;
    pinView.annotationColor = a.color;
    pinView.canShowCallout = YES;
    
    return pinView;
}


- (IBAction)getNearPorts:(id)sender {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"12.92" forKey:@"entityLatitude"];
    [dic setObject:@"77.478" forKey:@"entityLongitude"];
    [dic setObject:@"Bangalore" forKey:@"entityAddress"];
    
    [self fetchNearbyPortsInfo];
    //[self reloadMapWithNearbySitesInfo:[[NSMutableArray alloc] initWithObjects:dic, nil]];
}


- (void)fetchNearbyPortsInfo{
    if(true){
        NSString *address = @"http://compostconnect.azure-mobile.net/tables/Source";
        address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"Loading General Info URL --->: %@",address);
        [RestService requestPath:address RequestDics:nil onCompletion:^(NSData *generalInfoData, NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (generalInfoData.length > 0 && error == nil) {
                    NSString *string = [[NSString alloc] initWithData:generalInfoData encoding:NSUTF8StringEncoding];
                    NSArray *tempArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    
                    [self reloadMapWithNearbySitesInfo:tempArray];
                    
                }else{
                    NSLog(@"---ERROR---");
                }
            });
        }];
    }
}

- (IBAction)gotoLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
