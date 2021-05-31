//
//  Wue.h
//  octest
//
//  Created by apple on 2021/5/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Wue : NSObject
- (void)addTarget:(nullable id)target action:(SEL)action;
@end

@interface NSString (wue)
- (void)addTarget:(nullable id)target action:(SEL)action;
@end

@interface NSAttributedString (wue)
- (void)addTarget:(nullable id)target action:(SEL)action;
@end

@interface UIColor (wue)
- (void)addTarget:(nullable id)target action:(SEL)action;
@end

@interface UIFont (wue)
- (void)addTarget:(nullable id)target action:(SEL)action;
@end

@interface UIImage (wue)
- (void)addTarget:(nullable id)target action:(SEL)action;
@end

@interface NSArray (wue)
- (void)addTarget:(nullable id)target action:(SEL)action;
@end

@interface NSDictionary (wue)
- (void)addTarget:(nullable id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
