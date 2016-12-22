//
//  PageTitleView.h
//  QFB
//
//  Created by yl on 2016/11/3.
//  Copyright © 2016年 shujuyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageTitleViewDelegate <NSObject>
- (void)pageTitleViewCurrentIndex:(NSInteger)currentIndex;
@end

@interface PageTitleView : UIView
@property (nonatomic,assign) id<PageTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
- (void)setTitleChangeProgress:(CGFloat)progress beforeIndex:(NSInteger)beforIndex targetIndex:(NSInteger)targetIndex;
@end
