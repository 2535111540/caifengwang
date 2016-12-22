//
//  PageContentView.m
//  QFB
//
//  Created by yl on 2016/11/3.
//  Copyright © 2016年 shujuyun. All rights reserved.
//

#import "PageContentView.h"
#define kCellID @"cell"
@interface PageContentView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGFloat startOffsetX;
    CGFloat currentOffsetX;
    NSInteger beforTitleIndex;
    NSInteger targetTitleIndex;
    CGFloat progress;
//    BOOL isForbidScrollDelegate;
}
@property (nonatomic,strong) NSMutableArray *childVcs;
@property (nonatomic,strong) UIViewController *parentViewController;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation PageContentView

// 懒加载创建collectionView
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.bounces = NO;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellID];
        
        self.collectionView = collectionView;
    }
    return _collectionView;
}


- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSMutableArray *)childVcs parentViewController:(UIViewController *)parentViewController
{
    _childVcs = childVcs;
    _parentViewController = parentViewController;
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
//        isForbidScrollDelegate = NO;
    }
    return self;
}

- (void)setupUI
{
    for (UIViewController *childVc in self.childVcs) {
        [self.parentViewController addChildViewController:childVc];
    }
    [self addSubview:self.collectionView];
    self.collectionView.frame = self.bounds;
}


#pragma mark ----- 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    UIViewController *VC = self.childVcs[indexPath.item];
//    VC.view.backgroundColor = [UIColor randomColor];
    VC.view.backgroundColor = [UIColor whiteColor];
    VC.view.frame = self.bounds;
    [cell.contentView addSubview:VC.view];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startOffsetX = scrollView.contentOffset.x;
//    isForbidScrollDelegate = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 判断是点击还是滑动 (判断是否是点击)，如果是点击直接return;
//    if (isForbidScrollDelegate) {
//        return;
//    }
    
    progress = 0;
    beforTitleIndex = 0;
    targetTitleIndex = 0;
    CGFloat scrollW = scrollView.width;
    
    // 判断是向左滑还是向右滑
    currentOffsetX = scrollView.contentOffset.x;
    if (startOffsetX < currentOffsetX) { // 向左滑
        
        progress = currentOffsetX / scrollW - floor(currentOffsetX / scrollW);
        beforTitleIndex = (NSInteger)currentOffsetX / scrollW;
        targetTitleIndex = beforTitleIndex + 1;
        
        // 判断越界
        if (targetTitleIndex >= _childVcs.count) {
            targetTitleIndex = _childVcs.count - 1;
        }
        
        // 完全滑过去的时候
        if (currentOffsetX - startOffsetX == scrollW) {
            progress = 1.0;
            targetTitleIndex = beforTitleIndex;
        }
    }else { // 向右滑
        progress = 1 - (currentOffsetX / scrollW - floor(currentOffsetX / scrollW));
        targetTitleIndex = (NSInteger)currentOffsetX / scrollW;
        beforTitleIndex = targetTitleIndex + 1;
        
        // 判断越界
        if (beforTitleIndex >= _childVcs.count) {
            beforTitleIndex = _childVcs.count - 1;
        }
    }
    if ([self.delegate respondsToSelector:@selector(pageContentViewProgress:beforeIndex:targetIndex:)]) {
        [self.delegate pageContentViewProgress:progress beforeIndex:beforTitleIndex targetIndex:targetTitleIndex];
    }
}

// 对外暴露一个方法
- (void)setPageContentViewChangeCurrentIndex:(NSInteger)currentIndex
{
    // 记录需要禁止的代理方法
//    isForbidScrollDelegate = YES;
    
    CGFloat offsetX = (CGFloat)currentIndex * self.collectionView.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0)];
}

@end
