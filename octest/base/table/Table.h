//
//  Table.h
//  octest
//
//  Created by apple on 2021/5/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Table : UITableView
- (void)reloadData:(NSArray *)array;
- (void)didSelectRow:(void(^)(NSInteger index))row;
@end

NS_ASSUME_NONNULL_END
