//
//  TestCell.m
//  octest
//
//  Created by apple on 2021/5/31.
//

#import "TestCell.h"
@interface TestCell()
@property(nonatomic,strong)UILabel *au_label;
@end
@implementation TestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.au_label.frame = CGRectMake(0, 0, 100, 50);        
        self.au_label.textColor = [UIColor redColor];
    }
    return self;
}
- (void)setModel:(id)model{
    
    if ([model isMemberOfClass:[TestModel class]]) {
        
        TestModel *m = (TestModel *)model;
        self.au_label.text = m.name;
    }
}

@end
@implementation TestModel

- (Class)getClassIden{
    return [TestCell class];
}

@end
