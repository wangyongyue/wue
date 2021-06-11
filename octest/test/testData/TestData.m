//
//  TestData.m
//  octest
//
//  Created by apple on 2021/5/31.
//

#import "TestData.h"
#import "TestCell.h"
@implementation TestData

- (void)request{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        TestModel *model = [[TestModel alloc]init];
        model.name = [NSString stringWithFormat:@"name__%d",i];
        [arr addObject:model];
    }
    self.array = arr;
}
@end
