//
//  ViewController.m
//  octest
//
//  Created by apple on 2021/4/9.
//

#import "ViewController.h"
#import "Cat.h"
#import <objc/runtime.h>
#import <UIImageView+WebCache.h>
#import "Dog.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
//    UIImageView *a = [[UIImageView alloc]init];
//    [self.view addSubview:a];
//    a.frame = CGRectMake(100, 100, 100, 100);
//
//    a.backgroundColor = [UIColor redColor];
//    NSString *url = @"https://bkimg.cdn.bcebos.com/pic/500fd9f9d72a6059252d031a487e239b033b5bb50cd2?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxODA=,g_7,xp_5,yp_5/format,f_auto";
//    [a sd_setImageWithURL:[NSURL URLWithString:url]];
//
//
//    [self test4];
//    
//    Cat *c = [[Cat alloc]init];
//    NSLog(@"%@",c);
//    
////
////    [c performSelector:@selector(go1)];
//    [c go];
//    c.name = @"catnamename";
//    NSLog(@"打印%@",c.name);
//
    
}

- (void)test4{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        NSLog(@"addOperationWithBlock");
        [NSThread sleepForTimeInterval:2];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"main");
        }];
    }];
   
    NSLog(@"end");
    
    
}
- (void)test3{
    
    NSInvocationOperation *iop = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run3) object:nil];
    NSBlockOperation *bop = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation %@",[NSThread currentThread]);
    }];
    [iop addDependency:bop];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:iop];
    [queue addOperation:bop];
    [queue addOperationWithBlock:^{
        NSLog(@"queue add block %@",[NSThread currentThread]);
    }];
    
    
}
- (void)run3{
    
    NSLog(@"NSInvocationOperation %@",[NSThread currentThread]);

}
- (void)test2{
    
    NSBlockOperation *iop = [NSBlockOperation blockOperationWithBlock:^{
        [self run1:@"blockOperationWithBlock"];
    }];
    [iop addExecutionBlock:^{
        [self run1:@"addExecutionBlock"];
    }];
    iop.completionBlock = ^{
        NSLog(@"completionBlock");
    };
    
    [iop start];
}
- (void)run1:(NSString *)str{
    NSLog(@"%@",str);
}
- (void)test1{
    
    NSInvocationOperation *iop = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run) object:nil];
    [iop start];
    
}
- (void)run{
    NSLog(@"%@",[NSThread currentThread]);
}


@end
