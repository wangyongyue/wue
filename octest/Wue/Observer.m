//
//  Observer.m
//  octest
//
//  Created by apple on 2021/6/18.
//


#import "Observer.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "NSObject+Auto.h"
#import <objc/message.h>

@interface Observer ()
@property(nonatomic,assign)SEL w_action;
@property(nonatomic,weak)id w_target;
@property(nonatomic,strong)NSMutableDictionary *w_propertys;

@end
@implementation Observer
- (void)addTarget:(nullable id)target action:(SEL)action{
    self.w_target = target;
    self.w_action = action;
    
}
- (void)callAction{
    if (self.w_target && self.w_action && [self.w_target respondsToSelector:self.w_action]) {
        ((void(*)(id,SEL,id))objc_msgSend)(self, self.w_action, nil);
    }
}
- (id)read{
    
    NSString *key =NSStringFromSelector(_cmd);
    if (key.length > 0) {
        key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
        key = [NSString stringWithFormat:@"set%@:",key];
    }
    id value = [self.w_propertys objectForKey:key];
    if (value) {
        return value;
    }
    NSDictionary *types = [self propertyTypeWithKeyAndValue];
    NSString *classStr = [types objectForKey:key];
    if (classStr && classStr.length > 0) {
        id obj = [[NSClassFromString(classStr) alloc]init];
        [self.w_propertys setObject:obj forKey:key];

        return obj;
    }
    return nil;
}
- (void)write:(id)value{
    NSString *key = NSStringFromSelector(_cmd);
    if (value) {
        [self.w_propertys setObject:value forKey:key];
    }
}
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selString = NSStringFromSelector(sel);
    if ([selString containsString:@"YYY"]) {
        [self addMethodWithIdentifier:@"YYY" sel:sel setSelector:@selector(write:) getSelector:@selector(read)];
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


+ (void)initialize
{
    if (self == [self class]) {
        [self swizzlingSettersAndGettersWithIdentifier:@"YYY"];
    }
}


- (NSMutableDictionary *)w_propertys{
    if (_w_propertys == nil) {
        _w_propertys = [NSMutableDictionary dictionary];
    }
    return _w_propertys;
}

@end

@implementation OBInteger
- (void)setValue:(NSInteger)value{
    _value = value;
    [self callAction];
}
- (void)callAction{
    if (self.w_target && self.w_action && [self.w_target respondsToSelector:self.w_action]) {
        ((void(*)(id,SEL,NSInteger))objc_msgSend)(self, self.w_action, self.value);
    }
}
@end

@implementation OBInt
- (void)setValue:(int)value{
    _value = value;
    [self callAction];
}
- (void)callAction{
    if (self.w_target && self.w_action && [self.w_target respondsToSelector:self.w_action]) {
        ((void(*)(id,SEL,int))objc_msgSend)(self.w_target, self.w_action, self.value);
    }
}
@end
@implementation OBFloat
- (void)setValue:(float)value{
    _value = value;
    [self callAction];
}
- (void)callAction{
    if (self.w_target && self.w_action && [self.w_target respondsToSelector:self.w_action]) {
        ((void(*)(id,SEL,float))objc_msgSend)(self.w_target, self.w_action, self.value);
    }
}
@end
@implementation OBDouble
- (void)setValue:(double)value{
    _value = value;
    [self callAction];
}
- (void)callAction{
    if (self.w_target && self.w_action && [self.w_target respondsToSelector:self.w_action]) {
        ((void(*)(id,SEL,double))objc_msgSend)(self.w_target, self.w_action, self.value);
    }
}
@end
@implementation OBArray
- (void)setValue:(NSArray*)value{
    _value = value;
    [self callAction];
}
- (void)callAction{
    if (self.w_target && self.w_action && [self.w_target respondsToSelector:self.w_action]) {
        ((void(*)(id,SEL,NSArray *))objc_msgSend)(self.w_target, self.w_action, self.value);
    }
}
@end
@implementation OBDictionary
- (void)setValue:(NSDictionary*)value{
    _value = value;
    [self callAction];
}
- (void)callAction{
    if (self.w_target && self.w_action && [self.w_target respondsToSelector:self.w_action]) {
        ((void(*)(id,SEL,NSDictionary *))objc_msgSend)(self.w_target, self.w_action, self.value);
    }
}
@end
@implementation OBString
- (void)setValue:(NSString*)value{
    _value = value;
    [self callAction];
}
- (void)callAction{
    if (self.w_target && self.w_action && [self.w_target respondsToSelector:self.w_action]) {
        ((void(*)(id,SEL,NSString *))objc_msgSend)(self.w_target, self.w_action, self.value);
    }
}
@end
@implementation OBBool
- (void)setValue:(BOOL)value{
    _value = value;
    [self callAction];
}
- (void)callAction{
    if (self.w_target && self.w_action && [self.w_target respondsToSelector:self.w_action]) {
        ((void(*)(id,SEL,BOOL))objc_msgSend)(self.w_target, self.w_action, self.value);
    }
}
@end

