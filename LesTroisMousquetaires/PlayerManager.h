//
//  PlayerManager.h
//  LesTroisMousquetaires
//
//  Created by lanou on 16/6/29.
//  Copyright © 2016年 -------. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "MediaModel.h"

// 播放模式
typedef NS_ENUM(NSInteger, RepeatMode){
    
    SingleRepeat, // 单曲循环
    RandomPlay, // 随机播放
    RepeatAll, // 全部循环
    NoRepeat // 顺序播放
    
};

typedef NS_ENUM(NSInteger, PlayerMode){
    
    MusicAndLrc, // 音乐带歌词
    VideoMode, // 视频
    RadioMode // 电台
    
};



@protocol PlayerManagerDelegate <NSObject>


@optional
- (void)currentItemImage:(UIImage *)image andCurrentTime:(CGFloat)currentTime andTotalTime:(CGFloat)totalTime;

- (UIView *)setPlayerView;

@end


@interface PlayerManager : NSObject

@property (nonatomic, strong)AVPlayer *player;
// 播放列表
@property (nonatomic, strong)NSMutableArray <MediaModel *>*mediaURLList;
// 播放模式
@property (nonatomic, assign)RepeatMode repeatMode;

@property (nonatomic, assign)id<PlayerManagerDelegate> delegate;

@property (nonatomic, assign)PlayerMode playerMode;

@property (nonatomic, assign)BOOL isPlaying;

@property (nonatomic, assign)NSInteger index;

+ (instancetype)shareInstance;

- (void)setPlayerList:(NSMutableArray <MediaModel *>*)array andPlayerMode:(PlayerMode)PlayerMode andRepeatMode:(RepeatMode)repeatMode;

- (void)play;

- (void)pause;

- (void)next:(void(^)(NSString *title))block;

- (void)last:(void(^)(NSString *title))block;

@end
