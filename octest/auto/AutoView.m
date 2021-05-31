//
//  AutoView.m
//  octest
//
//  Created by apple on 2021/5/31.
//

#import "AutoView.h"
#import <objc/runtime.h>
#import "NSObject+Auto.h"

@interface AutoView ()
@property(nonatomic,strong)NSMutableDictionary *w_propertys;

@end

@implementation AutoView

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
        if ([obj isKindOfClass:[UIView class]]) {
            [self addSubview:obj];
        }

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
