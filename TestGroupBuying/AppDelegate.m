//
//  AppDelegate.m
//  TestGroupBuying
//
//  Created by SMartP on 16/1/5.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FirstViewController.h"
#import "MyNavController.h"
#import "DPAPI.h"
#import <MapKit/MapKit.h>

#define CategoriesFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"categories.data"]

@interface AppDelegate ()<DPRequestDelegate,CLLocationManagerDelegate>
{
    UIAlertController *_alert;
}

@property (nonatomic , strong) CLLocationManager *locationManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self getCategories];
    [_locationManager setDelegate:self];
    [self getLocation];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    FirstViewController *fvc = [[FirstViewController alloc] init];
    MyNavController *nav = [[MyNavController alloc] initWithRootViewController:fvc];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)getLocation
{
    if ([CLLocationManager locationServicesEnabled]) {
        if (!_locationManager) {
            _locationManager = [[CLLocationManager alloc]init];
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];
            }
            [_locationManager setDelegate:self];
            [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            [_locationManager setDistanceFilter:1000];
            [_locationManager startUpdatingLocation];
        }
    }
    else{
//        if (!_alert) {
//            _alert = [UIAlertController alertControllerWithTitle:nil message:@"定位服务未开启" preferredStyle:UIAlertControllerStyleAlert];
//        }
//        [_alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [self presentViewController:_alert animated:YES completion:nil];
//        });
        NSLog(@"shibai");
    }
}

- (void)getCategories
{
    //请求categories
    DPAPI *api = [[DPAPI alloc]init];
    [api requestWithURL:@"v1/metadata/get_categories_with_deals" params:nil delegate:self];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    [self reverseGeocoder:location];
    [_locationManager stopUpdatingLocation];
}

//反地理编码
- (void)reverseGeocoder:(CLLocation *)currentLocation {
    
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(error || placemarks.count == 0){
            NSLog(@"error");
        }else{
            
            CLPlacemark * placemark = placemarks.firstObject;
//            NSLog(@"placemark:%@",[[placemark addressDictionary] objectForKey:@"City"]);
            NSString *fullCity = [[placemark addressDictionary] objectForKey:@"City"];
            NSArray *strs = [fullCity componentsSeparatedByString:@"市"];
            NSString *city = strs[0];
//            NSLog(@"%@",city);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cityDidChanged" object:nil userInfo:@{@"cityName":city}];
        }
        
    }];
}

#pragma mark - DPRequestDelegate
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"DLCategories.plist" ofType:nil];
    NSDictionary *res = result;
    NSArray *arr = [res objectForKey:@"categories"];
//    [arr writeToFile:path atomically:YES];
    [NSKeyedArchiver archiveRootObject:arr toFile:CategoriesFilePath];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
