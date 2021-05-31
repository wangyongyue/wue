//
//  NSObject+Auto.m
//  octest
//
//  Created by apple on 2021/5/31.
//

#import "NSObject+Auto.h"
#import <objc/runtime.h>

@implementation NSObject (Auto)

+ (void)addMethodWithIdentifier:(NSString *)identifier sel:(SEL)sel setSelector:(SEL)setSelector getSelector:(SEL)getSelector{
    NSString *selString = NSStringFromSelector(sel);
    if ([selString hasPrefix:[NSString stringWithFormat:@"set%@",identifier]]) {
        Method exchangeM = class_getInstanceMethod([self class], setSelector);
        class_addMethod([self class],sel, class_getMethodImplementation(self, setSelector), method_getTypeEncoding(exchangeM));
    }else if ([selString hasPrefix:[NSString stringWithFormat:@"get%@",identifier]]) {
        Method exchangeM = class_getInstanceMethod([self class], getSelector);
        class_addMethod([self class],sel, class_getMethodImplementation(self, getSelector), method_getTypeEncoding(exchangeM));
    }
}

+ (void)swizzlingSettersAndGettersWithIdentifier:(NSString *)identifier{
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        const char *propertyType = property_getAttributes(propertyList[i]);

        NSString *key = [NSString stringWithUTF8String:propertyName];
        NSString *type = [NSString stringWithUTF8String:propertyType];

        if (key.length > 0) {
            NSString *hHey = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
            NSString *setKey = [NSString stringWithFormat:@"set%@:",hHey];
            NSString *getKey = [NSString stringWithFormat:@"%@",key];

            [self loadNewMethodSetter:setKey type:type index:i identifier:identifier];
            [self loadNewMethodGetter:getKey type:type index:i identifier:identifier];
        }
    }
    
}
+ (void)loadNewMethodSetter:(NSString *)key type:(NSString *)type index:(int)index identifier:(NSString *)identifier{
    if ([self isType:type key:key]) {
        NSString *newMethod = [NSString stringWithFormat:@"set%@%d:",identifier,index];
        [self swizzlingMethod:NSSelectorFromString(key) sMethod:NSSelectorFromString(newMethod)];
    }
}
+ (void)loadNewMethodGetter:(NSString *)key type:(NSString *)type index:(int)index identifier:(NSString *)identifier{
    if ([self isType:type key:key]) {
        NSString *newMethod = [NSString stringWithFormat:@"get%@%d:",identifier,index];
        [self swizzlingMethod:NSSelectorFromString(key) sMethod:NSSelectorFromString(newMethod)];
    }
}

+(void)swizzlingMethod:(SEL)originalSelector sMethod:(SEL)swizzledSelector{
   Class class = [self class];
   Method originalMethod = class_getInstanceMethod(class, originalSelector);
   Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
   method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (NSDictionary *)propertyTypeWithKeyAndValue{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        const char *propertyType = property_getAttributes(propertyList[i]);

        NSString *key = [NSString stringWithUTF8String:propertyName];
        NSString *type = [NSString stringWithUTF8String:propertyType];

        if (key.length > 0) {
            NSString *hHey = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
            NSString *setKey = [NSString stringWithFormat:@"set%@:",hHey];
            if ([type hasPrefix:@"T@"]) {
                NSArray *strArray = [type componentsSeparatedByString:@"\""];
                if (strArray.count >= 3) {
                    NSString *objType = strArray[1];
                    [dic setObject:objType forKey:setKey];
                }
            }
        }
    }
    return dic
    ;
}




@end
