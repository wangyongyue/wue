//
//  TextView.m
//  octest
//
//  Created by apple on 2021/5/31.
//

#import "TextView.h"
@interface TextView ()
@property(nonatomic,strong)UILabel *au_label;

@end
@implementation TextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.au_label.text = @"sdf";
        self.au_label.frame = CGRectMake(0, 0, 100, 30);
        self.au_label.textColor = [UIColor blackColor];
        
    }
    return self;
}

@end
