//
//  Wue.m
//  octest
//
//  Created by apple on 2021/5/27.
//

#import "Wue.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "NSObject+Auto.h"
#import <objc/message.h>

@interface Wue ()
@property(nonatomic,strong)NSMutableDictionary *w_propertys;
@property(nonatomic,strong)NSMutableDictionary *w_targetDic;
@property(nonatomic,strong)NSMutableDictionary *w_actionDic;
@property(nonatomic,copy)NSString *w_sel;

@end
@implementation Wue
- (void)addTarget:(nullable id)target action:(SEL)action{
    if (self.w_sel != nil && self.w_sel.length > 0) {
        [self.w_targetDic setObject:target forKey:self.w_sel];
        NSString *actionStr = NSStringFromSelector(action);
        [self.w_actionDic setObject:actionStr forKey:self.w_sel];
        self.w_sel = nil;
    }
    
}
- (void)actionWith:(NSString *)key value:(id)value{
    id target = [self.w_targetDic objectForKey:key];
    id action = [self.w_actionDic objectForKey:key];
    if (target && action && [target respondsToSelector:NSSelectorFromString(action)]) {
        [target performSelector:NSSelectorFromString(action) withObject:value];
    }
}

- (Wue *)read{
    
    NSString *key =NSStringFromSelector(_cmd);
    if (key.length > 0) {
        key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
        key = [NSString stringWithFormat:@"set%@:",key];
    }
    self.w_sel = key;
    id value = [self.w_propertys valueForKey:key];
    return self;
}
- (void)write:(id)value{
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *key = NSStringFromSelector(_cmd);
    if (value) {
        [self.w_propertys setValue:value forKey:key];
        [self actionWith:key value:value];
    }
}

+ (NSArray *)supportType{
    return @[@"NSString",
             @"UIColor",
             @"UIFont",
             @"NSArray",
             @"NSDictionary",
             @"NSNumber",
    ];
}
+ (BOOL)isType:(NSString *)type key:(NSString *)key{
    
    NSArray *types = [self supportType];
    for (NSString *ty in types) {
        if ([type containsString:ty]
            && ![key containsString:@"setHash"]
            && ![key containsString:@"hash"]
            && ![key containsString:@"setSuperclass"]
            && ![key containsString:@"superclass"]
            && ![key containsString:@"setDescription"]
            && ![key containsString:@"description"]
            && ![key containsString:@"setDebugDescription"]
            && ![key containsString:@"debugDescription"]
            && ![key containsString:@"setW_sel"]
            && ![key containsString:@"w_sel"]

        ) {
            return  YES;
        }
    }
    return NO;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selString = NSStringFromSelector(sel);
    if ([selString containsString:@"XXX"]) {
        [self addMethodWithIdentifier:@"XXX" sel:sel setSelector:@selector(write:) getSelector:@selector(read)];
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
+ (void)initialize
{
    if (self == [self class]) {
        [self swizzlingSettersAndGettersWithIdentifier:@"XXX"];
    }
}
- (NSMutableDictionary *)w_propertys{
    if (_w_propertys == nil) {
        _w_propertys = [NSMutableDictionary dictionary];
    }
    return _w_propertys;
}

- (NSMutableDictionary *)w_targetDic{
    if (_w_targetDic == nil) {
        _w_targetDic = [NSMutableDictionary dictionary];
    }
    return _w_targetDic;
}
- (NSMutableDictionary *)w_actionDic{
    if (_w_actionDic == nil) {
        _w_actionDic = [NSMutableDictionary dictionary];
    }
    return _w_actionDic;
}

@end

