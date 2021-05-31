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

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
       
    NSLog(@"viewDidLoad");
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 100, 30);

    
    UILabel *label1 = [[UILabel alloc]init];
    label1.textColor = [UIColor blackColor];
    [self.view addSubview:label1];
    label1.frame = CGRectMake(100, 200, 100, 30);

    User *ue = [[User alloc]init];
//    ue.sub.name.w_text(label);
//    ue.sub.name.w_text(label1);
//    ue.color.w_backgroundColor(label);
    [ue.sub.name addTarget:label action:@selector(setText:)];
    [ue.color addTarget:self action:@selector(change:)];

    ue.sub.name = @"sdfsd1231";
    ue.color = [UIColor redColor];
    
    TextView *t = [[TextView alloc]init];
    [self.view addSubview:t];
    t.frame = CGRectMake(100, 300, 100, 50);
    t.backgroundColor = [UIColor redColor];

}
- (void)change:(UIColor *)value{
    NSLog(@"%@",value);
    
}
@end
