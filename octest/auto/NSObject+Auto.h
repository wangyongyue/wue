//
//  NSObject+Auto.h
//  octest
//
//  Created by apple on 2021/5/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Auto)
+ (void)swizzlingSettersAndGettersWithIdentifier:(NSString *)identifier;
+ (BOOL)isType:(NSString *)type key:(NSString *)key;
+ (void)addMethodWithIdentifier:(NSString *)identifier sel:(SEL)sel setSelector:(SEL)setSelector getSelector:(SEL)getSelector;
- (NSDictionary *)propertyTypeWithKeyAndValue;

@end

NS_ASSUME_NONNULL_END
