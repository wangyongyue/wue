//
//  MainVC.m
//  octest
//
//  Created by apple on 2021/5/26.
//

#import "MainVC.h"
#import "Cat.h"
#import <objc/runtime.h>
#import <UIImageView+WebCache.h>
#import "Dog.h"
#import "User.h"
#import "Wue.h"
#import "Bird.h"
#import "TextView.h"

@interface MainVC ()
@property(nonatomic,strong)UILabel *au_label;
@property(nonatomic,strong)UILabel *au_label1;
@property(nonatomic,strong)User *au_user;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
       
    NSLog(@"viewDidLoad");
    self.au_label.textColor = [UIColor blackColor];
    [self.view addSubview:self.au_label];
    self.au_label.frame = CGRectMake(100, 100, 100, 30);

    
    self.au_label1.textColor = [UIColor blackColor];
    [self.view addSubview:self.au_label1];
    self.au_label1.frame = CGRectMake(100, 200, 100, 30);

    
    
    
    [self.au_user.sub.name addTarget:self.au_label action:@selector(setText:)];
    [self.au_user.sub.age addTarget:self.au_label1 action:@selector(setText:)];
    [self.au_user.color addTarget:self action:@selector(change:)];

    self.au_user.sub.name = @"sdfsd1231";
    self.au_user.sub.age = @"ageddddd";
    self.au_user.color = [UIColor redColor];
    
    TextView *t = [[TextView alloc]init];
    [self.view addSubview:t];
    t.frame = CGRectMake(100, 300, 100, 50);
    t.backgroundColor = [UIColor redColor];
    
   
}
- (void)change:(UIColor *)value{
    NSLog(@"%@",value);
    self.au_label.textColor = value;
    
}
@end
