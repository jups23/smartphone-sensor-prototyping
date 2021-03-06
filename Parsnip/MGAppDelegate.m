//
//  MGAppDelegate.m
//  Parsnip
//
//  Created by Willi Müller on 28.03.14.
//  Copyright (c) 2014 UFMG. All rights reserved.
//

#import <SensePlatform/CSSensePlatform.h>
#import <SensePlatform/CSSettings.h>
#import "Factory.h"


#import "MGAppDelegate.h"

@implementation MGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	CSSettings* settings = [CSSettings sharedSettings];
	//Setup sense platform
    [CSSensePlatform initialize];
	
    //upload data to Common Sense every 15 minutes
    [settings setSettingType:kCSSettingTypeGeneral setting:kCSGeneralSettingUploadToCommonSense value:kCSSettingYES];
    [settings setSettingType:kCSSettingTypeGeneral setting:kCSGeneralSettingUploadInterval value:@"900"];
	
    //enable location sensor so we keep running in the background
    [settings setSettingType:kCSSettingTypeLocation setting:kCSLocationSettingAccuracy value:@"10000"];
    [settings setSensor:kCSSENSOR_LOCATION enabled:YES];
    
    [settings setSettingType:kCSSettingTypeGeneral setting:kCSGeneralSettingSenseEnabled value:kCSSettingYES];
    
    //continuous motion sensor sampling this is needed to do continuous fall detection, but this drains battery. Other modules work well with lower sample interval.
    [settings setSettingType:kCSSettingTypeSpatial setting:kCSSpatialSettingInterval value:@"0"];
	
    //Modules expect 50Hz sample rate, 3 a duration of three seconds works quite well for activity detection and step counting
    [settings setSettingType:kCSSettingTypeSpatial setting:kCSSpatialSettingFrequency value:@"50"];
    [settings setSettingType:kCSSettingTypeSpatial setting:kCSSpatialSettingNrSamples value:@"150"];
    [settings setSensor:kCSSENSOR_ACCELEROMETER enabled:YES];
    
    //acceleration is used by the Activity and stepcounter module
    [settings setSensor:kCSSENSOR_ACCELERATION enabled:YES];
    [settings setSensor:kCSSENSOR_ACCELERATION_BURST enabled:YES];
    
    //noise sensor is used to detect sleep
    [settings setSettingType:kCSSettingTypeAmbience setting:kCSAmbienceSettingInterval value:@"60"];
    [settings setSensor:kCSSENSOR_NOISE enabled:YES];

    //Let the factory instantiate all modules
    [Factory sharedFactory];	//Use this to enable/disable the whole sense platform

	return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//	[CSSensePlatform willTerminate];
}

@end
