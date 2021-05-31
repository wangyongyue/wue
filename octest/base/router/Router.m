//
//  Router.m
//  octest
//
//  Created by apple on 2021/5/28.
//

#import "Router.h"

@implementation Router
+ (void)push:(UIViewController *)viewController animated:(BOOL)animated{
    [[Router getCurrentVC].navigationController pushViewController:viewController animated:YES];
}
+ (void)pop:(BOOL)animated{
    [[Router getCurrentVC].navigationController popViewControllerAnimated:animated];
}
+ (UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;
    UIViewController *currentVC = [Router getCurrentVCFrom:rootViewController];
    return currentVC;
    
}
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController])
    {
        rootVC = [rootVC presentedViewController];
    } if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

@end
