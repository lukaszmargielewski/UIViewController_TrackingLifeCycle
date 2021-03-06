//
//  AppDelegate.m
//  UIVCTrackingExample
//
//  Created by Lukasz Margielewski on 16/10/15.
//  Copyright © 2015 Lukasz Margielewski. All rights reserved.
//

#import "AppDelegate.h"
#import "LMStatsTracker.h"
#import "ViewController.h"
#import "LMStatsReporter.h"

@interface AppDelegate ()
@property (nonatomic, strong) LMStatsTracker *statsTracker;
@property (nonatomic, strong) LMStatsPersistense *statsPersistence;
@property (nonatomic, strong) LMStatsReporter *statsReporter;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.statsPersistence = [[LMStatsPersistense alloc] init];
    self.statsTracker = [[LMStatsTracker alloc] init];
    self.statsTracker.persistance = self.statsPersistence;
    
    self.statsReporter = [[LMStatsReporter alloc] initWithLMStatsPersistense:self.statsPersistence];
    [UIViewController setTrackerDelegate:self.statsTracker];
    
    ViewController *vc = [[ViewController alloc] init];
    vc.tracker.trackedInfo = @{@"stack" : @(0)};
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nc;
    
    [self.window makeKeyAndVisible];
    
    [self.statsReporter reportAllUnreportedStats];
    
    return YES;
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
