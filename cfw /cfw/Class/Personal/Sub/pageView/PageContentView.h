//
//  PageContentView.h
//  QFB
//
//  Created by yl on 2016/11/3.
//  Copyright © 2016年 shujuyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageContentViewDelegate <NSObject>

-(void)pageContentViewProgress:(CGFloat)progress beforeIndex:(NSInteger)beforIndex targetIndex:(NSInteger)targetIndex;

@end

@interface PageContentView : UIView
@property (nonatomic,assign) id<PageContentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSMutableArray *)childVcs parentViewController:(UIViewController *)parentViewController;

- (void)setPageContentViewChangeCurrentIndex:(NSInteger)currentIndex;

@end
