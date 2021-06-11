//
//  Test1Cell.h
//  octest
//
//  Created by apple on 2021/5/31.
//

#import <UIKit/UIKit.h>
#import "AutoCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface Test1Cell : AutoCollectionViewCell

@end
@interface Test1Model : NSObject
@property(nonatomic,copy)NSString *name;

@end
NS_ASSUME_NONNULL_END
