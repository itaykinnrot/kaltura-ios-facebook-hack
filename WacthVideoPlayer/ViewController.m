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

@interface ViewController () <OsxProxyDelegate>

@property (weak, nonatomic) IBOutlet UILabel *avPlayerLabel;
@property (weak, nonatomic) IBOutlet UIView *avPlayerView;
@property (nonatomic, retain) AVPlayerViewController *avPlayerViewcontroller;
@property OsxProxy *proxy;

@end

@implementation ViewController

- (IBAction)sendContentToOSX:(id)sender {
    [self.proxy start];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)peerConnected {
    NSLog(@"Peer connected");
    [self.proxy sendString:self.mediaUrl];
}

@end
