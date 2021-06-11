//
//  Test1Cell.m
//  octest
//
//  Created by apple on 2021/5/31.
//


#import "Test1Cell.h"
@interface Test1Cell()
@property(nonatomic,strong)UILabel *au_label;
@end
@implementation Test1Cell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.au_label.frame = CGRectMake(0, 0, 80, 80);
        self.au_label.textColor = [UIColor redColor];
    }
    return self;
}
- (void)setModel:(id)model{
    
    if ([model isMemberOfClass:[Test1Model class]]) {
        
        Test1Model *m = (Test1Model *)model;
        self.au_label.text = m.name;
    }
}

@end
@implementation Test1Model

- (Class)getClassIden{
    return [Test1Cell class];
}

@end
