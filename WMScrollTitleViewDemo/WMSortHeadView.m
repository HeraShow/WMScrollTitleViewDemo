//
//  WMSortHeadView.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/8.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMSortHeadView.h"

#define KIndicatorHeight 2.f

@interface WMSortHeadView ()
@property (nonatomic, strong) UILabel *staticLabel;
@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UIImageView *selectedImg;

@property (nonatomic, strong) UIImageView *sortImgView;
@property (nonatomic, assign) BOOL titleState;

@end
@implementation WMSortHeadView
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

#pragma mark --- 重写标题的setter ---
- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    CGFloat commonWidth = (KScreenWidth - 70)/titleArray.count;
    CGFloat labelX = 15;
    CGFloat labelY = 0;
    CGFloat labelWidth = commonWidth - 45;
    CGFloat labelHeight = self.frame.size.height - KIndicatorHeight;
    self.totalLabelArray = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        self.staticLabel = [[UILabel alloc]init];
        _staticLabel.userInteractionEnabled = YES;
        _staticLabel.textAlignment = NSTextAlignmentRight;
        _staticLabel.text = titleArray[i];
        _staticLabel.font = WMMediumFont(12);
        _staticLabel.tag = i+1;
        _staticLabel.textColor = WMHPDark;
        
        _staticLabel.highlightedTextColor = WMBlueColor;
        labelX = i * commonWidth + 50;
        _staticLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        // 装入数组
        [self.totalLabelArray addObject:_staticLabel];
        
        // 添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(staticLabelClick:)];
        [_staticLabel addGestureRecognizer:tap];
        
        self.sortImgView = [[UIImageView alloc] init];
        _sortImgView.tag = i + 100;
        _sortImgView.frame = CGRectMake(labelX + labelWidth + 7, labelY/2 + labelHeight/2 - 3 , 8, 6);
        _sortImgView.hidden = YES;
        [self addSubview:_sortImgView];
        
        // 默认选中第一个
        if (i == self.index) {
            _titleState = NO;
            _staticLabel.highlighted = YES;
            _staticLabel.textColor = WMBlueColor;
            _selectedLabel = _staticLabel;
            _sortImgView.image = [UIImage imageNamed:@"wemart_sort_down"];
            _sortImgView.hidden = NO;
            _selectedImg = _sortImgView;
        }
        [self addSubview:_staticLabel];
    }
    
}

- (void)staticLabelClick:(UITapGestureRecognizer *)tap
{
    UILabel *titleLabel = (UILabel *)tap.view;
    [self staticLabelSelectedColor:titleLabel];
    
    NSInteger index = titleLabel.tag - 1;
    if ([self.sortDelegate respondsToSelector:@selector(sortView:didSelectedTitleIndex:)]) {
        [self.sortDelegate sortView:self didSelectedTitleIndex:index];
    }
}

#pragma mark --- 标题选中颜色 和 image ---
- (void)staticLabelSelectedColor:(UILabel *)titleLabel
{
    _selectedLabel.highlighted = NO;
    _selectedLabel.textColor = [UIColor blackColor];
    
    _selectedImg.hidden = YES;

    
    titleLabel.highlighted = YES;
    titleLabel.textColor = WMBlueColor;
    
    if ([_selectedLabel isEqual:titleLabel]) {
        _titleState = !_titleState;
    }
    else{
        _titleState = NO;
    }
    
    for (UIImageView *imgView in self.subviews) {
        if (imgView.tag - 100 == titleLabel.tag - 1) {
            imgView.hidden = NO;
            if (_titleState) {
                imgView.image = [UIImage imageNamed:@"wemart_sort_up"];
            }
            else{
                imgView.image = [UIImage imageNamed:@"wemart_sort_down"];
            }
            _selectedImg = imgView;
        }
    }
    _selectedLabel = titleLabel;
}


@end
