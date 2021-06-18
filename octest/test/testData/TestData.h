//
//  TestData.h
//  octest
//
//  Created by apple on 2021/5/31.
//

#import "Wue.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestData : Wue
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,copy)NSString *name;

- (void)request;
@end

NS_ASSUME_NONNULL_END
