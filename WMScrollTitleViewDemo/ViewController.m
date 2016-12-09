//
//  ViewController.m
//  WMScrollTitleViewDemo
//
//  Created by 冯文秀 on 16/12/7.
//  Copyright © 2016年 Hera. All rights reserved.
//

#import "ViewController.h"
#import "WMModuleScrollView.h"
#import "WMSortHeadView.h"

@interface ViewController ()<ModuleScrollViewDelegate, SortViewDelegate>
@property (nonatomic, strong) WMModuleScrollView *moduleView;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) WMSortHeadView *sortHeadView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = WMShopBg;
    self.navigationItem.title = @"数据分析";
    self.navigationController.navigationBar.barTintColor = WMBlueColor;

    self.titleArray = @[@"昨天", @"前7天", @"前30天"];
    self.moduleView = [[WMModuleScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 48 * KScreenWScale)];
    CGFloat countSpace = KScreenWidth /self.titleArray.count / 6;
    self.moduleView.index = 0;
    self.moduleView.space = countSpace;
    self.moduleView.staticTitleArray = self.titleArray;
    self.moduleView.moduleDelegate = self;
    [self.view addSubview:_moduleView];
    
    self.sortHeadView = [[WMSortHeadView alloc]initWithFrame:CGRectMake(0, 150, KScreenWidth, 36)];
    self.sortHeadView.titleArray = @[@"价格", @"库存", @"销量"];
    self.sortHeadView.index = 0;
    self.sortHeadView.space = KScreenWidth /18;
    self.sortHeadView.sortDelegate = self;
    [self.view addSubview:_sortHeadView];

}

#pragma mark --- 滚动标签的代理方法 ---
- (void)moduleScrollView:(WMModuleScrollView *)moduleScrollView didSelectedTitleIndex:(NSInteger)titleIndex
{
    NSLog(@"moduleScrollView  titleIndex --- %ld", titleIndex);
}

#pragma mark --- 点击标题 排序代理方法 ---
- (void)sortView:(WMSortHeadView *)sortView didSelectedTitleIndex:(NSInteger)titleIndex
{
    NSLog(@"sortView   titleIndex --- %ld", titleIndex);
    for (UIImageView *imgView in sortView.subviews) {
        if (imgView.tag - 100 == titleIndex) {
            UIImage *img = imgView.image;
            if ([img isEqual:[UIImage imageNamed:@"wemart_sort_down"]]) {
                // 降序
            }
            else{
                // 升序
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
