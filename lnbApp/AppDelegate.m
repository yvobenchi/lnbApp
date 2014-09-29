//
//  AppDelegate.m
//  lnbApp
//
//  Created by Yves Benchimol on 26/09/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import "AppDelegate.h"

#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

#import "SignInViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    
    //set up parse app
    [Parse setApplicationId:@"6iVo3gbTKaYaDkVdfpdJpxTq5Qa8ikPxhr8W7zPN"
                  clientKey:@"pHjL4TxkIqaAJFFJYOQWRdzC2faeo7NqVzfTKtbc"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //set up fb
    [PFFacebookUtils initializeFacebook];
    
    //set up the first font view and the menu
    SignInViewController *signInViewController = [[SignInViewController alloc] init];
    self.window.rootViewController = signInViewController;
    
//    
//    RearTableViewController *rearTableViewController = [[RearTableViewController alloc] init];
//    
//    UINavigationController *fontNavigationController = [[UINavigationController alloc] initWithRootViewController:fontViewController];
//    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearTableViewController];
//    
//    //insert them into the revealController
//    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:fontNavigationController];
//    
//    revealController.delegate = self;
//    
//    self.viewController = revealController;
//    self.window.rootViewController = revealController;
//    
//    [self.window makeKeyAndVisible];
//    
    return YES;
}

//facebook function
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[PFFacebookUtils session] close];
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

@end
