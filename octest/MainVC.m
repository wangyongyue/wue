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
#import "Table.h"
#import "TestData.h"
#import "Test1Cell.h"
#import "Collection.h"
#import "Test1Data.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface MainVC ()
@property(nonatomic,strong)UILabel *au_label;
@property(nonatomic,strong)UILabel *au_label1;
@property(nonatomic,strong)User *au_user;
@property(nonatomic,strong)Table *au_table;
@property(nonatomic,strong)Collection *au_collection;
@property(nonatomic,strong)TestData *au_test;
@property(nonatomic,strong)Test1Data *au_test1;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
       
    NSLog(@"viewDidLoad");
    
    //style
    self.au_label.textColor = [UIColor blackColor];
    self.au_label1.textColor = [UIColor blackColor];


    //layout
    self.au_label.frame = CGRectMake(100, 100, 100, 30);
    self.au_label1.frame = CGRectMake(100, 200, 100, 30);

    
    
    //bind
    [self.au_user.sub.name addTarget:self.au_label action:@selector(setText:)];
    [self.au_user.sub.age addTarget:self.au_label1 action:@selector(setText:)];
    [self.au_user.color addTarget:self action:@selector(change:)];

        
    //data
    self.au_user.sub.name = @"sdfsd1231";
    self.au_user.sub.age = @"ageddddd";
    self.au_user.color = [UIColor redColor];
    
    
    //组件
   
    
    //table
    self.au_table.frame = CGRectMake(200, 300, 200, 300);
    [self.au_test.array addTarget:self.au_table action:@selector(reloadData:)];
    
    [self.au_test request];
    
    
    
    //collection
    self.au_collection.frame = CGRectMake(200, 100, 250, 80);
    [self.au_collection itemSize:CGSizeMake(80, 80)];
    [self.au_collection scrollDirection:UICollectionViewScrollDirectionHorizontal];

    [self.au_test1.array addTarget:self.au_collection action:@selector(reloadData:)];
    [self.au_test1 request];
   
  

}

- (void)change:(UIColor *)value{
    NSLog(@"%@",value);
    self.au_label.textColor = value;
    
}
@end
