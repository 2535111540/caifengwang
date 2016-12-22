//
//  PNtestViewController.h
//  cfw
//
//  Created by majun on 16/12/20.
//  Copyright © 2016年 马军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import <UIKit/UIKit.h>

@interface PNtestViewController : UITableViewController
{
    //声明变量
    CTTelephonyNetworkInfo *networkInfo;
}
@end
