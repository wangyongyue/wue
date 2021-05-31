//
//  AppDelegate.m
//  octest
//
//  Created by apple on 2021/4/9.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MainVC alloc]init];
    [self.window makeKeyAndVisible];
    return YES;
}




@end
