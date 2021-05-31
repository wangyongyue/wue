//
//  Dog.h
//  octest
//
//  Created by apple on 2021/5/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject

@property(nonatomic,copy)NSString *name1;
@property(nonatomic,copy)NSString *name2;
@property(nonatomic,copy)NSString *name3;
@property(nonatomic,copy)NSString *name4;
@property(nonatomic,copy)NSString *name5;

@property(nonatomic,assign)int age;
@property(nonatomic,assign)BOOL age1;
@property(nonatomic,assign)double age2;
@property(nonatomic,assign)float age3;
@property(nonatomic,assign)NSInteger age4;
@property(nonatomic,assign)CGFloat age5;
@property(nonatomic,assign)long int age6;



+ (instancetype)shared;
@end

NS_ASSUME_NONNULL_END
