//
//  AppDelegate.m
//  HackerBooks
//
//  Created by Alberto Di Martino on 3/31/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "AppDelegate.h"
#import "ADMBook.h"
#import "ADMBookViewController.h"
#import "ADMLibrary.h"
#import "ADMLibraryTableViewController.h"
#import "ADMSimplePDFViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    //Remember this is initialized with the json dictionary
    ADMLibrary *library = [[ADMLibrary alloc] init];
   
    //Detect the type of screen
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //Tablet
        [self configureForPad:library];
    }else{
        //It is a phone or iphone plus
        [self configureForPhone:library];
    }
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [[self window] makeKeyAndVisible];
    
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

-(void) configureForPad:(ADMLibrary *) library{
    
    ADMLibraryTableViewController *libVC = [[ADMLibraryTableViewController alloc] initWithModel:library style:UITableViewStylePlain];
    
    ADMBookViewController *bVC = [[ADMBookViewController alloc ] initWithModel:[library firstBook]];
    
    
    //Navigation controllers
    UINavigationController *lNav = [UINavigationController new];
    UINavigationController *bNav = [UINavigationController new];
    [lNav pushViewController:libVC animated:NO];
    [bNav pushViewController:bVC animated:NO];
    
    
    UISplitViewController *sVC = [UISplitViewController new];
    sVC.viewControllers = @[lNav,bNav];
    
    //Set delegates
    sVC.delegate = bVC;
    libVC.delegate = bVC;
    
    self.window.rootViewController = sVC;
}

-(void)configureForPhone:(ADMLibrary*) library{
    
    //Create controler
    ADMLibraryTableViewController *lVC = [[ADMLibraryTableViewController alloc] initWithModel:library style:UITableViewStylePlain];
    
    //create container
    UINavigationController *navVC = [UINavigationController new];
    [navVC pushViewController:lVC animated:NO];
    
    //assigne delegates
    lVC.delegate = lVC;
    
    
    //make it root
    self.window.rootViewController = navVC;
    
}

@end
