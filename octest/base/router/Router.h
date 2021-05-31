//
//  Router.h
//  octest
//
//  Created by apple on 2021/5/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Router : NSObject
+ (void)push:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)pop:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
