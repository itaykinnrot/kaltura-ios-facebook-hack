//
//  ViewController.m
//  WacthVideoPlayer
//
//  Created by Nissim Pardo on 8/5/15.
//  Copyright © 2015 kaltura. All rights reserved.
//

#import "ViewController.h"
// AVPlayerViewController
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "OsxProxy.h"
#import "RNFrostedSidebar.h"

@interface ViewController () <OsxProxyDelegate, RNFrostedSidebarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *avPlayerLabel;
@property (weak, nonatomic) IBOutlet UIView *avPlayerView;
@property (nonatomic, retain) AVPlayerViewController *avPlayerViewcontroller;
@property OsxProxy *proxy;
@property (weak, nonatomic) IBOutlet UIButton *osxBtn;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation ViewController {
    BOOL itemSelected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    
    self.proxy = [OsxProxy new];
    self.proxy.delegate = self;
    
    self.mediaUrl = @"http://cfvod.kaltura.com/pd/p/811441/sp/81144100/serveFlavor/entryId/1_mhyj12pj/v/1/flavorId/1_2rs07zkf/name/a.mp4";
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.mediaUrl]];
    
    self.avPlayerViewcontroller.player = [AVPlayer playerWithPlayerItem:playerItem];
    [self.avPlayerViewcontroller.player play];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    if ([[segue identifier] isEqualToString:@"showMovie"]) {
        self.avPlayerViewcontroller = segue.destinationViewController;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendContentToOSX {
    if (itemSelected) {
        [self.proxy disconnectLocalPeer];
    } else {
        [self.proxy start];
    }
}

- (void)peerConnected {
    NSLog(@"Peer connected");
    [self.avPlayerViewcontroller.player pause];
    self.osxBtn.titleLabel.backgroundColor = [UIColor greenColor];
    [self.proxy sendDictionary:@{@"urlString" : self.mediaUrl,
                                 @"offset" : @(CMTimeGetSeconds(self.avPlayerViewcontroller.player.currentTime))}];
}

- (void)peerDisconnected {
    NSLog(@"Peer disconnected");
    self.osxBtn.titleLabel.backgroundColor = [UIColor blueColor];
}

- (IBAction)onBurger:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"globe"]
                        
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1]
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %lu",(unsigned long)index);
    if (index == 0) {
        [sidebar dismissAnimated:YES completion:nil];
        [self sendContentToOSX];
    }
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    itemSelected = itemEnabled;
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}

@end
