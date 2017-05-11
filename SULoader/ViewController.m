//
//  ViewController.m
//  SULoader
//
//  Created by 万众科技 on 16/6/24.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import "ViewController.h"
#import "SUPlayer.h"

//    NSURL * url = [[NSBundle mainBundle]URLForResource:@"Take a back" withExtension:@"mp3"];
//    NSURL *url = [NSURL URLWithString:@"http://zyvideo1.oss-cn-qingdao.aliyuncs.com/zyvd/7c/de/04ec95f4fd42d9d01f63b9683ad0"];

@interface ViewController ()

@property (nonatomic, strong) SUPlayer * player;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIImageView *coverIv;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UIImageView *bgIv;
@property (nonatomic, assign) NSInteger songIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
    effe.alpha = 0.97;
    effe.frame = self.view.bounds;
    [self.view insertSubview:effe aboveSubview:self.bgIv];
    
    NSURL * url = [NSURL URLWithString:[self songURLList][self.songIndex]];
    self.player = [[SUPlayer alloc]initWithURL:url];
    [self.player addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
    [self.player addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:nil];
    [self.player addObserver:self forKeyPath:@"cacheProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.player play];
    [self updateSongInfoShow];
    
    [self.progressSlider addTarget:self action:@selector(changeProgress:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeProgress:(UISlider *)slider {
    float seekTime = self.player.duration * slider.value;
    [self.player seekToTime:seekTime];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"progress"]) {
        if (self.progressSlider.state != UIControlStateHighlighted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressSlider.value = self.player.progress;
                self.currentTime.text = [self convertStringWithTime:self.player.duration * self.player.progress];
            });
        }
    }
    if ([keyPath isEqualToString:@"duration"]) {
        if (self.player.duration > 0) {
            self.duration.text = [self convertStringWithTime:self.player.duration];
            self.duration.hidden = NO;
            self.currentTime.hidden = NO;
        }else {
            self.duration.hidden = YES;
            self.currentTime.hidden = YES;
        }
    }
    if ([keyPath isEqualToString:@"cacheProgress"]) {
//        NSLog(@"缓存进度：%f", self.player.cacheProgress);
    }
}

- (IBAction)play:(UIButton *)sender {
    if (sender.selected) {
        [self.player pause];
    }else {
        [self.player play];
    }
    sender.selected = !sender.selected;
}

- (IBAction)skipSong:(UIButton *)sender {
    self.songIndex ++;
    if (self.songIndex >= 4) self.songIndex = 0;
    
    [self.player stop];
    NSURL * url = [NSURL URLWithString:[self songURLList][self.songIndex]];
    [self.player replaceItemWithURL:url];
    [self.player play];
    [self updateSongInfoShow];
}

- (void)updateSongInfoShow {
    self.songName.text = [self songNameList][self.songIndex];
    
    [UIView transitionWithView:self.bgIv duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.bgIv.image = [UIImage imageNamed:[self songCoverList][self.songIndex]];
    } completion:nil];
    
    [UIView transitionWithView:self.coverIv duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.coverIv.image = [UIImage imageNamed:[self songCoverList][self.songIndex]];
    } completion:nil];
}

- (NSString *)convertStringWithTime:(float)time {
    if (isnan(time)) time = 0.f;
    int min = time / 60.0;
    int sec = time - min * 60;
    NSString * minStr = min > 9 ? [NSString stringWithFormat:@"%d",min] : [NSString stringWithFormat:@"0%d",min];
    NSString * secStr = sec > 9 ? [NSString stringWithFormat:@"%d",sec] : [NSString stringWithFormat:@"0%d",sec];
    NSString * timeStr = [NSString stringWithFormat:@"%@:%@",minStr, secStr];
    return timeStr;
}

- (NSArray *)songNameList {
    return @[@"夏天的味道", @"没那种命", @"不得不爱", @"海阔天空"];
}

- (NSArray *)songURLList {
    return @[@"http://download.lingyongqian.cn/music/AdagioSostenuto.mp3",
             @"http://download.lingyongqian.cn/music/ForElise.mp3",
             @"http://mr7.doubanio.com/39ec9c9b5bbac0af7b373d1c62c294a3/1/fm/song/p1393354_128k.mp4",
             @"http://mr7.doubanio.com/16c59061a6a82bbb92bdd21e626db152/0/fm/song/p966452_128k.mp4"];
}

- (NSArray *)songCoverList {
    return @[@"p190415_128k.jpg", @"p1458183_128k.jpg", @"p1393354_128k.jpg", @"p966452_128k.jpg"];
}

@end
