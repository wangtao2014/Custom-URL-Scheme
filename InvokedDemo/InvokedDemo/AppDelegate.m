//
//  AppDelegate.m
//  InvokedDemo
//
//  Created by wangtao on 14-3-6.
//  Copyright (c) 2014年 hello. All rights reserved.
//

#import "AppDelegate.h"
#import "WTInvokedViewController.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if ([[launchOptions objectForKey:UIApplicationLaunchOptionsSourceApplicationKey] isEqualToString:@"com.hello.InvokingDemo"])
    {
        return YES;
    }
    MainViewController *mainController = [[MainViewController alloc] init];
    self.window.rootViewController = mainController;
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
    NSLog(@"application=%@", application);
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"%@", url);
    NSLog(@"annotation=%@,sourceApplication=%@", annotation, sourceApplication);
    if ([[url scheme] isEqualToString:@"invoked"]) {
        if ([[url host] isEqualToString:@"com.hello"]) {
            NSString *query = [url query];
            NSArray *array = [query componentsSeparatedByString:@"&"];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
            for (NSString *item in array) {
                NSArray *valueArray = [item componentsSeparatedByString:@"="];
                [dic setValue:[valueArray objectAtIndex:1] forKey:[valueArray objectAtIndex:0]];
            }
            WTInvokedViewController *invokedController = [[WTInvokedViewController alloc] init];
            invokedController.callBack = [dic objectForKey:@"callback"];
            self.window.rootViewController = invokedController;
        }
        return YES;
    }
    return NO;
}

@end
