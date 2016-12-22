//
//  NetWorkingHelpper.m
//  class17_netWorking
//
//  Created by xalo on 15/12/15.
//  Copyright © 2015年 范强伟. All rights reserved.
//

#import "NetWorkingHelpper.h"

@implementation NetWorkingHelpper


- (void)getAndSynchronousMethodWithUrl:(NSString *)string{
    //    定义url网址
    NSString *urlString =  string;
    NSURL *url = [NSURL URLWithString:urlString];
    //初始化请求方式 默认为get方式
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //  创建同步连接
    NSError *error;
    NSData *receiverData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSLog(@"%@",error);
    [self jsonParserWithData: receiverData];
}


- (void)postAndAsynchronousMethodWithUrl:(NSString *)string{
    NSRange substr = [string rangeOfString:@"?"];
    NSString *str = [string substringToIndex: substr.location];
    NSString *str1 = [string substringFromIndex: substr.location + 1];
    
    
    NSString *urlString =  str;
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *postString =  str1;
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *mutableReq = [NSMutableURLRequest requestWithURL:url];
    mutableReq.HTTPBody = data;
    mutableReq.HTTPMethod = @"POST";
    [NSURLConnection sendAsynchronousRequest:mutableReq queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        [self jsonParserWithData: data];
        
        NSLog(@"%@",connectionError);
    }];
    
}


- (void)jsonParserWithData:(NSData *)data{
    if (data) {
        id receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        通过代理将解析好的数据传递出去
        [self.delegate passValueWithData: receiveDic];
        // NSLog(@"jsonDic --- %@",receiveDic);
    }
    
}












@end
