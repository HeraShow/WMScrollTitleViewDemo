//
//  PublicHeader.h
//  WMScrollTitleViewDemo
//
//  Created by 冯文秀 on 16/12/7.
//  Copyright © 2016年 Hera. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h


#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWScale (KScreenWidth / 375.f)
#define KScreenHScale (KScreenHeight / 667.f)

#define ColorRGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
#define WMShopBg ColorRGB(240, 243, 245, 1)
#define WMBlueColor ColorRGB(16, 169, 235, 1)
#define WMHPDark ColorRGB(55, 59, 64, 1)


#define WMLightFont(FontSize) [UIFont fontWithName:@"PingFangSC-Light" size:FontSize]
#define WMBoldFont(FontSize) [UIFont fontWithName:@"PingFangSC-Bold" size:FontSize]
#define WMMediumFont(FontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize]
#define WMRegularFont(FontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize]

#endif /* PublicHeader_h */
