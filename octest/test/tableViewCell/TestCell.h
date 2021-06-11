//
//  TestCell.h
//  octest
//
//  Created by apple on 2021/5/31.
//

#import <UIKit/UIKit.h>
#import "AutoTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface TestCell : AutoTableViewCell

@end
@interface TestModel : NSObject
@property(nonatomic,copy)NSString *name;

@end

NS_ASSUME_NONNULL_END
