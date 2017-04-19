//
//  AdvertCommentViewCell.h
//  FullHelp
//
//  Created by hhsoft on 17/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentInfo;
typedef void (^AdvertCommentViewCellSeeImgViewBlock)(NSMutableArray *arrImage, NSInteger index);

@interface AdvertCommentViewCell : UITableViewCell
@property (nonatomic,strong) AdvertCommentViewCellSeeImgViewBlock seeImgViewBlock;
@property (nonatomic,strong) CommentInfo *commentInfo;

+ (id)AdvertCommentViewCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
+ (CGFloat)cellHeightWithCommentInfo:(CommentInfo *)commentInfo;

@end
