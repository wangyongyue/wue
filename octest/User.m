//
//  User.m
//  octest
//
//  Created by apple on 2021/5/27.
//

#import "User.h"

@implementation User
- (Sub *)sub{
    if (_sub == nil) {
        _sub = [[Sub alloc]init];
    }
    return _sub;
}
@end
