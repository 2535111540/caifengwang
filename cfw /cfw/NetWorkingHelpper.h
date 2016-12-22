//
//  NetWorkingHelpper.h
//  class17_netWorking
//
//  Created by xalo on 15/12/15.
//  Copyright © 2015年 范强伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkingHelpperDelegate <NSObject>
//  参数为所需要传出去的值（解析好的）
- (void)passValueWithData:(id)value;

@end

//  A向B传值 代理声明在A里面


@interface NetWorkingHelpper : NSObject


- (void)getAndSynchronousMethodWithUrl:(NSString *)string;
- (void)postAndAsynchronousMethodWithUrl:(NSString *)string;


@property (nonatomic, assign)id<NetWorkingHelpperDelegate>delegate;










@end
