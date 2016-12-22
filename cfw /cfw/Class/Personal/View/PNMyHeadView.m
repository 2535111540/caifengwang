//
//  PNMyHeadView.m
//  cfw
//
//  Created by 马军 on 16/9/26.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNMyHeadView.h"


@interface PNMyHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UILabel *userIphoneNum;
@property (weak, nonatomic) IBOutlet UILabel *authLevel;
@end
@implementation PNMyHeadView

-(void)awakeFromNib{
    [super awakeFromNib];
    _iconImage.layer.cornerRadius = self.iconImage.bounds.size.width / 2;
    _iconImage.layer.borderWidth = 3;
    _iconImage.layer.borderColor = [UIColor redColor].CGColor;
    _iconImage.layer.masksToBounds = YES;
}

@end
