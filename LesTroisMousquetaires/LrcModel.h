//
//  LrcModel.h
//  LesTroisMousquetaires
//
//  Created by lanou on 16/6/29.
//  Copyright © 2016年 -------. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcModel : NSObject

@property (nonatomic, strong)NSString *title;

@property (nonatomic, strong)NSMutableArray *timeArray;

@property (nonatomic, strong)NSMutableDictionary *lrcDic;

+ (instancetype)lrcWithURL:(NSString *)urlString;

@end
