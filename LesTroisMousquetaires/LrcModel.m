//
//  LrcModel.m
//  LesTroisMousquetaires
//
//  Created by lanou on 16/6/29.
//  Copyright © 2016年 -------. All rights reserved.
//

#import "LrcModel.h"

@implementation LrcModel

+ (instancetype)lrcWithURL:(NSString *)urlString{
    
    LrcModel *lrc = [[self alloc] init];
    
    if (lrc) {
        
        NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
        
        NSArray *totalArray = [string componentsSeparatedByString:@"\n"];
        
        NSLog(@"%@",totalArray);
        lrc.lrcDic = [NSMutableDictionary dictionary];
        lrc.timeArray = [NSMutableArray array];
        for (NSString *lrcString in totalArray) {
            
            NSString *time = [[lrcString substringToIndex:10] substringWithRange:NSMakeRange(1, 8)];
            
            
            NSString *lrcNoTime = [lrcString substringFromIndex:10];
            [lrc.lrcDic setObject:lrcNoTime forKey:time];
            [lrc.timeArray addObject:time];
        }
        lrc.title = lrc.lrcDic[lrc.timeArray[0]];
        
    }
    return lrc;
}

@end
