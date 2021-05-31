//
//  Collection.h
//  octest
//
//  Created by apple on 2021/5/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Collection : UICollectionView
- (void)scrollDirection:(UICollectionViewScrollDirection)direction;
- (void)itemSize:(CGSize)size;

- (void)reloadData:(NSArray *)array;
- (void)didSelectRow:(void(^)(NSInteger index))row;
- (void)didScrollOffset:(void(^)(CGPoint offset))offset;

@end

NS_ASSUME_NONNULL_END
