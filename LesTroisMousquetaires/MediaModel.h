//
//  MediaModel.h
//  LesTroisMousquetaires
//
//  Created by lanou on 16/6/29.
//  Copyright © 2016年 -------. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaModel : NSObject

@property (nonatomic, strong)NSString *title;

@property (nonatomic, strong)NSString *author;

@property (nonatomic, strong)NSString *musicURLString;

@property (nonatomic, strong)NSString *LrcURLString;

@property (nonatomic, strong)NSString *ImageURLString;

@end
