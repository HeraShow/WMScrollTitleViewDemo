//
//  WMModuleScrollView.m
//  StaticScrollTitle
//
//  Created by Zeus on 16/9/8.
//  Copyright © 2016年 Hera. All rights reserved.
//

#import "WMModuleScrollView.h"
#define KTitleLabelXSpace 15.f
#define KIndicatorHeight 2.f
#define SG_screenWidth [UIScreen mainScreen].bounds.size.width

@interface WMModuleScrollView ()
@property (nonatomic, strong) UILabel *staticLabel;
@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UIView *indicatorView;


@end
@implementation WMModuleScrollView

- (NSMutableArray *)totalTitleArray
{
    if (_totalLabelArray == nil) {
        _totalLabelArray = [NSMutableArray array];
    }
    return _totalLabelArray;
}

- (instancetype)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}


/**
 *  计算文字尺寸
 *
 *  @param text    文字内容
 *  @param font    字体
 *  @param maxSize 最大尺寸
 *
 *  @return 自适应尺寸
 */
- (CGSize)boundsSizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil].size;
}

#pragma mark --- 重写静止标题的setter ---
- (void)setStaticTitleArray:(NSArray *)staticTitleArray
{
    _staticTitleArray = staticTitleArray;
    CGFloat scrollViewWith = KScreenWidth;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelWidth = scrollViewWith/staticTitleArray.count;
    CGFloat labelHeight = self.frame.size.height - KIndicatorHeight;
    self.totalLabelArray = [NSMutableArray array];
    for (int i = 0; i < staticTitleArray.count; i++) {
        self.staticLabel = [[UILabel alloc]init];
        _staticLabel.userInteractionEnabled = YES;
        _staticLabel.textAlignment = NSTextAlignmentCenter;
        _staticLabel.text = staticTitleArray[i];
        _staticLabel.font = WMLightFont(14);
        _staticLabel.tag = i+1;
        _staticLabel.textColor = WMHPDark;
        
        _staticLabel.highlightedTextColor = WMBlueColor;
        labelX = i * labelWidth;
        _staticLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        // 装入数组
        [self.totalLabelArray addObject:_staticLabel];
        
        // 添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(staticLabelClick:)];
        [_staticLabel addGestureRecognizer:tap];
        
        // 默认选中
        if (i == self.index) {
            _staticLabel.highlighted = YES;
            _staticLabel.textColor = WMBlueColor;
            _selectedLabel = _staticLabel;
        }
        [self addSubview:_staticLabel];
    }

    // 添加指示器
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = WMBlueColor;
    
    CGFloat XSpace = 0;
    XSpace = self.space + labelWidth * self.index;
    _indicatorView.frame = CGRectMake(XSpace, labelHeight, labelWidth - self.space*2, KIndicatorHeight);
    [self addSubview:_indicatorView];
}

- (void)staticLabelClick:(UITapGestureRecognizer *)tap
{
    UILabel *titleLabel = (UILabel *)tap.view;
    [self staticLabelSelectedColor:titleLabel];
    
    NSInteger index = titleLabel.tag - 1;
    if ([self.moduleDelegate respondsToSelector:@selector(moduleScrollView:didSelectedTitleIndex:)]) {
        [self.moduleDelegate moduleScrollView:self didSelectedTitleIndex:index];
    }
}

- (void)changeSelectedWithIndex:(NSInteger)index titleArray:(NSArray *)titleArray
{
    for (id objc in self.subviews) {
        if ([objc isKindOfClass:[UILabel class]]) {
            UILabel *titleLab = objc;
            if ([titleLab.text isEqualToString:titleArray[index]]) {
                [self staticLabelSelectedColor:titleLab];
                if ([self.moduleDelegate respondsToSelector:@selector(moduleScrollView:didSelectedTitleIndex:)]) {
                    [self.moduleDelegate moduleScrollView:self didSelectedTitleIndex:index];
                }
            }
        }
    }
}

#pragma mark --- 标题选中颜色 和 指示位置 ---
- (void)staticLabelSelectedColor:(UILabel *)titleLabel
{
    _selectedLabel.highlighted = NO;
    _selectedLabel.textColor = [UIColor blackColor];
    
    titleLabel.highlighted = YES;
    titleLabel.textColor = WMBlueColor;
    _selectedLabel = titleLabel;
    [UIView animateWithDuration:0.20 animations:^{
        CGFloat XSpace = 0;
        XSpace = self.space + KScreenWidth/_staticTitleArray.count * (titleLabel.tag - 1);
        _indicatorView.frame = CGRectMake(XSpace, self.frame.size.height - KIndicatorHeight, KScreenWidth/_staticTitleArray.count - self.space*2, KIndicatorHeight);
    }];
}







@end
