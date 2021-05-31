//
//  TextView.m
//  octest
//
//  Created by apple on 2021/5/31.
//

#import "TextView.h"
@interface TextView ()
@property(nonatomic,strong)UILabel *labelView;

@end
@implementation TextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.labelView.text = @"sdf";
        self.labelView.frame = CGRectMake(0, 0, 100, 30);
        self.labelView.textColor = [UIColor blackColor];
        
    }
    return self;
}

@end
