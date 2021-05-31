//
//  Cat.h
//  octest
//
//  Created by apple on 2021/4/9.
//

#import <Foundation/Foundation.h>
#import "Test.h"
NS_ASSUME_NONNULL_BEGIN

@interface Cat : Test
@property(nonatomic,copy)NSString *name;
- (void)go;
@end

NS_ASSUME_NONNULL_END
