//
//  Table.m
//  octest
//
//  Created by apple on 2021/5/28.
//

#import "Table.h"
@interface Table ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *w_array;
@property(nonatomic,copy)void(^rowBlock)(NSInteger index);

@end
@implementation Table
- (void)reloadData:(NSArray *)array{
    self.w_array = array;
    [self reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creat];
    }
    return self;
}
- (void)creat{
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.estimatedRowHeight = YES;
    
}
- (NSInteger)numberOfSections{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.w_array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSObject *obj = self.w_array[indexPath.row];
    if ([obj respondsToSelector:@selector(getClassIden)]) {
        Class aclass = [obj performSelector:@selector(getClassIden)];
        NSString *iden = NSStringFromClass(aclass);
        [tableView registerClass:aclass forCellReuseIdentifier:iden];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([cell respondsToSelector:@selector(setModel:)]) {
            [cell performSelector:@selector(setModel:) withObject:obj];
        }
        return cell;
    }
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.rowBlock){
        self.rowBlock(indexPath.row);
    }
}
- (void)didSelectRow:(void(^)(NSInteger index))row{
    if(row){
        self.rowBlock = row;
    }
}
@end
