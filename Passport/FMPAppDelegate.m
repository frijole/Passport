//
//  FMPAppDelegate.m
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import "FMPAppDelegate.h"

#import "FMPPassportViewController.h"
#import "FMPJournalViewController.h"

#import "FMPDataHandler.h"
#import "FMPAppearanceManager.h"

@implementation FMPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIWindow *tmpWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tmpTabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    
    // see if we have a first passport to load
    FMPPassport *tmpPassport = nil;
    NSArray *tmpPassports = [FMPDataHandler passports];
    if ( tmpPassports && tmpPassports.count > 0 ) {
        tmpPassport = [tmpPassports firstObject];
    }
    
    FMPPassportViewController *tmpListViewController = [[FMPPassportViewController alloc] initWithPassport:tmpPassport];
    UINavigationController *tmpListNavController = [[UINavigationController alloc] initWithRootViewController:tmpListViewController];
    FMPJournalViewController *tmpJournalViewController = [[FMPJournalViewController alloc] init];
    UINavigationController *tmpJournalNavController = [[UINavigationController alloc] initWithRootViewController:tmpJournalViewController];
    
    [tmpTabBarController setViewControllers:@[tmpListNavController, tmpJournalNavController]];
    
    [tmpWindow setRootViewController:tmpTabBarController];
    [self setWindow:tmpWindow];
    [self.window makeKeyAndVisible];
        
    [FMPAppearanceManager configureAppearance];
    
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
}

@end
