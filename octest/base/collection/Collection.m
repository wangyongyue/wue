//
//  Collection.m
//  octest
//
//  Created by apple on 2021/5/28.
//

#import "Collection.h"
@interface Collection ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)NSArray *w_array;
@property(nonatomic,copy)void(^rowBlock)(NSInteger index);
@property(nonatomic,copy)void(^scrollBlock)(CGPoint offset);

@end

@implementation Collection
- (void)reloadData:(NSArray *)array{
    self.w_array = array;
    [self reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeZero;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.w_array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSObject *obj = self.w_array[indexPath.row];
    if ([obj respondsToSelector:@selector(getClassIden)]) {
        Class aclass = [obj performSelector:@selector(getClassIden)];
        NSString *iden = NSStringFromClass(aclass);
        [collectionView registerClass:aclass forCellWithReuseIdentifier:iden];
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(setModel:)]) {
            [cell performSelector:@selector(setModel:) withObject:obj];
        }
        return cell;
    }
    return [[UICollectionViewCell alloc]init];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.scrollBlock) {
        self.scrollBlock(scrollView.contentOffset);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.rowBlock) {
        self.rowBlock(indexPath.row);
    }
}
- (void)didScrollOffset:(void(^)(CGPoint offset))offset{
    if(offset){
        self.scrollBlock = offset;
    }
}
- (void)didSelectRow:(void(^)(NSInteger index))row{
    if(row){
        self.rowBlock = row;
    }
}
- (void)itemSize:(CGSize)size{
    if ([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        layout.itemSize = size;
    }
}
- (void)scrollDirection:(UICollectionViewScrollDirection)direction{
    
    if ([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        layout.scrollDirection = direction;
    }
}
@end
