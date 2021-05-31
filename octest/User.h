//
//  User.h
//  octest
//
//  Created by apple on 2021/5/27.
//

#import "Wue.h"
#import "Sub.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : Wue
@property(nonatomic,strong)NSNumber *numberHidden;
@property(nonatomic,strong)UIColor *color;
@property(nonatomic,assign)BOOL isHidden;

@property(nonatomic,strong)Sub *sub;

@end

NS_ASSUME_NONNULL_END
