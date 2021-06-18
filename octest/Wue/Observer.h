//
//  Observer.h
//  octest
//
//  Created by apple on 2021/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Observer : NSObject
- (void)addTarget:(nullable id)target action:(SEL)action;
@end
@interface OBInteger : Observer
@property(nonatomic,assign)NSInteger value;
@end
@interface OBBool : Observer
@property(nonatomic,assign)BOOL value;
@end
@interface OBInt : Observer
@property(nonatomic,assign)int value;
@end
@interface OBFloat : Observer
@property(nonatomic,assign)float value;
@end
@interface OBDouble : Observer
@property(nonatomic,assign)double value;
@end
@interface OBArray : Observer
@property(nonatomic,strong)NSArray* value;
@end
@interface OBDictionary : Observer
@property(nonatomic,strong)NSDictionary* value;
@end
@interface OBString : Observer
@property(nonatomic,copy)NSString* value;
@end
NS_ASSUME_NONNULL_END
