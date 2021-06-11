//
//  Test1Data.m
//  octest
//
//  Created by apple on 2021/5/31.
//

#import "Test1Data.h"
#import "Test1Cell.h"

@implementation Test1Data
- (void)request{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        Test1Model *model = [[Test1Model alloc]init];
        model.name = [NSString stringWithFormat:@"name__%d",i];
        [arr addObject:model];
    }
    self.array = arr;
}
@end
