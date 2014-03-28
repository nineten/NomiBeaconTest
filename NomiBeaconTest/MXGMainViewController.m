//
//  MXGMainViewController.m
//  NomiBeaconTest
//
//  Created by Jayden.Ma on 28/3/14.
//  Copyright (c) 2014 Maxus. All rights reserved.
//

#import "MXGMainViewController.h"
#import <NomiBeaconSDK/NomiBeaconSDK.h>

@interface MXGMainViewController () <NomiBeaconManagerDelegate>

@end

@implementation MXGMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize Nomi SDK
    NomiBeaconManager *beaconManager = [NomiBeaconManager sharedInstance];
    [beaconManager setDelegate:self];
    
    // Set API environment (Use NOMI_SDK_PROD for release)
    [beaconManager setNomiEnvironment:NOMI_SDK_DEV];
    
    // Use the App ID supplied to you by Nomi for this application
    [beaconManager startBeaconMonitoringWithAppID:@"532731c7d2bfa82af32b2c6e" authKey:@"e0c6f9540da445cf2ebe02d50d6191d8"];
    
    // Recommended: You can submit user-specific data from your app to
    // Nomi to have more granular queries on your tracked data
    // Any data can be submitted but suggested
    // * user_id (email, or other unique user identifier)
    // * name
    // * dob (date of birth)
    // *sex
    NSDictionary *userInfo = @{
                               @"user_id" : @"nomi@suburban.com",
                               @"name" : @"Nomi",
                               @"dob" : @"10/22/13",
                               @"sex" : @"male"
                               };
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NomiBeaconManagerDelegate callbacks
- (void)didEnterLocation:(NomiLocation*)location
{
    // Welcome user to a location with a notification
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = [NSString stringWithFormat:@"Welcome to %@!", location.name];
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)didExitLocation:(NomiLocation*)location afterTime:(NSTimeInterval)seconds
{
    // If this is the userâ€™s first visit and she/he spent
    // more than five minutes at the location, say â€œFarewellâ€
    if (location.stats.visits.count == 1 && seconds > 300)
    {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Farewell";
        notification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}

@end
