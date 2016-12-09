//
//  WMSortHeadView.h
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/8.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMSortHeadView;
@protocol SortViewDelegate <NSObject>

- (void)sortView:(WMSortHeadView *)sortView didSelectedTitleIndex:(NSInteger)titleIndex;

@end
@interface WMSortHeadView : UIView
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *totalLabelArray;

@property (nonatomic, assign) id<SortViewDelegate> sortDelegate;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat space;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)staticLabelSelectedColor:(UILabel *)titleLabel;
@end
