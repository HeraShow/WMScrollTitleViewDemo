//
//  WMModuleScrollView.h
//  StaticScrollTitle
//
//  Created by Zeus on 16/9/8.
//  Copyright © 2016年 Hera. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMModuleScrollView;
@protocol ModuleScrollViewDelegate <NSObject>

- (void)moduleScrollView:(WMModuleScrollView *)moduleScrollView didSelectedTitleIndex:(NSInteger)titleIndex;

@end
@interface WMModuleScrollView : UIScrollView

// 静态的标题数组
@property (nonatomic, strong) NSArray *staticTitleArray;
// 滚动的标题数组
@property (nonatomic, strong) NSArray *scrollTitleArr;

// 所有标题数组
@property (nonatomic, strong) NSMutableArray *totalLabelArray;

@property (nonatomic, assign) id<ModuleScrollViewDelegate> moduleDelegate;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat space;

- (instancetype)initWithFrame:(CGRect)frame;
#pragma mark --- 标题选中颜色 和 指示位置 ---
- (void)staticLabelSelectedColor:(UILabel *)titleLabel;

// 根据下表切换 
- (void)changeSelectedWithIndex:(NSInteger)index titleArray:(NSArray *)titleArray;

@end
