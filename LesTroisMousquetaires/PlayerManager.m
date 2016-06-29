//
//  PlayerManager.m
//  LesTroisMousquetaires
//
//  Created by lanou on 16/6/29.
//  Copyright © 2016年 -------. All rights reserved.
//

#import "PlayerManager.h"
#import "LrcModel.h"
@interface PlayerManager()

// 下一首
@property (nonatomic, strong)AVPlayerItem *nextItem;
// 正在播放的media
@property (nonatomic, strong)AVPlayerItem *currentItem;

@property (nonatomic, strong)LrcModel *currentLrc;

@property (nonatomic, strong)LrcModel *nextLrc;
// 播放器界面
@property (nonatomic, strong)UIView *playerView;

@end

@implementation PlayerManager

+ (instancetype)shareInstance{
    
    static PlayerManager *Manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Manager = [[PlayerManager alloc] init];
        
        Manager.player = [[AVPlayer alloc] init];
#warning stopAtThere
//        Manager.playerView = []
    });
    
    return Manager;
}

- (void)setIndex:(NSInteger)index{
    
    _index = index;
    [self indexLinkage];
    
}


#pragma mark ---------设置播放列表、播放器模式、循环模式----------
- (void)setPlayerList:(NSMutableArray <MediaModel *>*)array andPlayerMode:(PlayerMode)PlayerMode andRepeatMode:(RepeatMode)repeatMode{
    
    self.mediaURLList = array;
    self.playerMode = PlayerMode;
    self.repeatMode = repeatMode;
    self.index = 0;
}

- (void)play {
    
    [self.player play];
    
    self.isPlaying = YES;
    
}

- (void)pause {
    
    [self.player pause];
    
    self.isPlaying = NO;
}

- (void)next:(void(^)(NSString *title))block{
    
    self.index = [self nextIndex];
    
    block(_mediaURLList[_index].title);
    
    [self play];
    
}

- (void)last:(void(^)(NSString *title))block {
    
    self.index = [self lastIndex];
    
    block(_mediaURLList[_index].title);

    [self play];
}

#pragma mark ------坐标联动-------
- (void)indexLinkage{
    
    MediaModel *currentModel = _mediaURLList[_index];
    MediaModel *nextModel = _mediaURLList[[self nextIndex]];
    
    // 设置当前item和提前缓存下一首item
    if (_nextItem == nil) {
        self.currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[currentModel musicURLString]]];
    } else {
        self.currentItem = self.nextItem;
    }
    self.nextItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[nextModel musicURLString]]];
    
    [self.player replaceCurrentItemWithPlayerItem:_currentItem];
    
    // 带歌词的模式下
    if (_playerMode == MusicAndLrc) {
        if (_nextLrc == nil) {
            self.currentLrc = [LrcModel lrcWithURL:currentModel.LrcURLString];
        } else {
            self.currentLrc = self.nextLrc;
        }
        self.nextLrc = [LrcModel lrcWithURL:nextModel.LrcURLString];
    }
}

#pragma mark -------上一个坐标，下一个坐标-------
- (NSInteger)nextIndex{
    switch (_repeatMode) {
        case SingleRepeat:
            return _index;
        case RandomPlay:
            return arc4random()%_mediaURLList.count;
        default:
            if (_index >= _mediaURLList.count-1) {
                return 0;
            } else {
                return _index+1;
            }
    }
}

- (NSInteger)lastIndex{
    switch (_repeatMode) {
        case SingleRepeat:
            return _index;
        case RandomPlay:
            return arc4random()%_mediaURLList.count;
        default:
            if (_index <= 0) {
                return _mediaURLList.count-1;
            } else {
                return _index-1;
            }

    }
}

@end
