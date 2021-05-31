//
//  Dog.m
//  octest
//
//  Created by apple on 2021/5/26.
//

#import "Dog.h"
#import <objc/runtime.h>
@interface Dog ()

@end
@implementation Dog
//自动存储
static Dog* center;
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[Dog alloc] init];
    });
    return center;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (center) {
        return center;
    }
    return [super allocWithZone:zone];
}
+ (void)load{
//    [self swizzlingSetters];
//    [self swizzlingGetters];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"resolve-- %@",NSStringFromSelector(sel));
    NSString *selString = NSStringFromSelector(sel);
    if ([selString containsString:@"setXXX"]) {
        Method exchangeM = class_getInstanceMethod([self class], @selector(write:));
        class_addMethod([self class],sel, class_getMethodImplementation(self, @selector(write:)), method_getTypeEncoding(exchangeM));
        return YES;
    }else if ([selString containsString:@"setIBQXXX"]) {
        Method exchangeM = class_getInstanceMethod([self class], @selector(writeIBQ:));
        class_addMethod([self class],sel, class_getMethodImplementation(self, @selector(writeIBQ:)), method_getTypeEncoding(exchangeM));
        return YES;
    }else if ([selString containsString:@"getXXX"]) {
        Method exchangeM = class_getInstanceMethod([self class], @selector(read));
        class_addMethod([self class],sel, class_getMethodImplementation(self, @selector(read)), method_getTypeEncoding(exchangeM));
        return YES;
    }else if ([selString containsString:@"getIBQXXX"]) {
        Method exchangeM = class_getInstanceMethod([self class], @selector(readIBQ));
        class_addMethod([self class],sel, class_getMethodImplementation(self, @selector(readIBQ)), method_getTypeEncoding(exchangeM));
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}
- (NSInteger)readIBQ{
    
    NSString *key =NSStringFromSelector(_cmd);
    if (key.length > 0) {
        key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
        key = [NSString stringWithFormat:@"set%@:",key];
    }
    NSLog(@"Current method get: %@",key);
    NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    NSLog(@"get %ld",value);
    return value;
}
- (id)read{
    
    NSString *key =NSStringFromSelector(_cmd);
    if (key.length > 0) {
        key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
        key = [NSString stringWithFormat:@"set%@:",key];
    }
    NSLog(@"Current method get: %@",key);
    NSObject *value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSLog(@"get %@",value);
    return value;
}
- (void)write:(id)value{
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *key =NSStringFromSelector(_cmd);
    NSLog(@"Current method: %@",key);
    NSLog(@"set %@",value);
    if (value) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    }
}
- (void)writeIBQ:(NSInteger)value{
    NSString *key =NSStringFromSelector(_cmd);
    NSLog(@"Current method: %@",key);
    NSLog(@"setIBQ %ld",value);
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];

}

+ (void)swizzlingSetters{
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        const char *propertyType = property_getAttributes(propertyList[i]);

        NSString *key = [NSString stringWithUTF8String:propertyName];
        NSString *type = [NSString stringWithUTF8String:propertyType];

        if (key.length > 0) {
            key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] capitalizedString]];
            key = [NSString stringWithFormat:@"set%@:",key];
        }
        NSLog(@"propertyName(%d) : %@", i, key);
        NSLog(@"propertyType(%d) : %@", i, type);

        if ([type containsString:@"NSString"]) {
            NSString *newMethod = [NSString stringWithFormat:@"setXXX%d:",i];
            [self swizzlingMethod:NSSelectorFromString(key) sMethod:NSSelectorFromString(newMethod)];
        }else if ([type hasPrefix:@"Ti"] || [type hasPrefix:@"TB"] || [type hasPrefix:@"Tq"]) {
            NSString *newMethod = [NSString stringWithFormat:@"setIBQXXX%d:",i];
            [self swizzlingMethod:NSSelectorFromString(key) sMethod:NSSelectorFromString(newMethod)];
        }
        

    }
}

+ (void)swizzlingGetters {
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        const char *propertyType = property_getAttributes(propertyList[i]);

        NSString *key = [NSString stringWithUTF8String:propertyName];
        NSString *type = [NSString stringWithUTF8String:propertyType];

        NSLog(@"propertyName(%d) : %@", i, key);
        
        if ([type containsString:@"NSString"]) {
            NSString *newMethod = [NSString stringWithFormat:@"getXXX%d:",i];
            [self swizzlingMethod:NSSelectorFromString(key) sMethod:NSSelectorFromString(newMethod)];
        }else if ([type hasPrefix:@"Ti"] || [type hasPrefix:@"TB"] || [type hasPrefix:@"Tq"]) {
            NSString *newMethod = [NSString stringWithFormat:@"getIBQXXX%d:",i];
            [self swizzlingMethod:NSSelectorFromString(key) sMethod:NSSelectorFromString(newMethod)];
        }
    }
}
+(void)swizzlingMethod:(SEL)originalSelector sMethod:(SEL)swizzledSelector{
   Class class = [self class];
   Method originalMethod = class_getInstanceMethod(class, originalSelector);
   Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
   method_exchangeImplementations(originalMethod, swizzledMethod);
}




@end
