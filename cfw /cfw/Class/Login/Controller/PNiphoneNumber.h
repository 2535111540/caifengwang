//
//  PNiphoneNumber.h
//  cfw
//
//  Created by 马军 on 16/9/27.
//  Copyright © 2016年 马军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNiphoneNumber : NSString


extern NSString *CTSettingCopyMyPhoneNumber();

+ (NSString *)myNumber;
@end
