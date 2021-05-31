//
//  Cat.m
//  octest
//
//  Created by apple on 2021/4/9.
//

#import "Cat.h"
#import <objc/runtime.h>
@implementation Cat

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"resolve-- %@",NSStringFromSelector(sel));
    if ([super resolveInstanceMethod:sel]) {
        Method exchangeM = class_getInstanceMethod([self class], @selector(test));
        class_addMethod([self class], sel, class_getMethodImplementation(self, @selector(test)), method_getTypeEncoding(exchangeM));
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}
- (void)test{
    NSLog(@"resolve-- test");

}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    return  [super forwardingTargetForSelector:aSelector];
}
- (void)go{
    NSLog(@"go");
    
    [self swizzlingMethod:@selector(setName:)];
}
+ (void)load{
    
    NSLog(@"cat load");
    
}

- (void)setUpPropertys{
    unsigned int count;
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"method(%d) : %@", i, NSStringFromSelector(method_getName(method)));
    }
  
}
-(void)swizzlingMethod:(SEL)originalSelector{
   // 当前类
   Class class = [self class];
   // 原方法名 和 替换方法名
//   SEL originalSelector = @selector(originalFunction);
    SEL swizzledSelector = @selector(swizzledFunction:);
   // 原方法结构体 和 替换方法结构体
   Method originalMethod = class_getInstanceMethod(class, originalSelector);
   Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
   
   // 调用交换两个方法的实现
   method_exchangeImplementations(originalMethod, swizzledMethod);
}
- (void)swizzledFunction:(id)value {
    NSLog(@"swizzledFunction---- %@",value);
    [self swizzledFunction:@"sdf"];
}
- (void)setName:(NSString *)name{
    _name = name;
}

@end
