//
//  PlayerControllerInterfaceController.m
//  WacthVideoPlayer
//
//  Created by Nissim Pardo on 8/6/15.
//  Copyright © 2015 kaltura. All rights reserved.
//
@import WatchConnectivity;
#import "PlayerControllerInterfaceController.h"

@interface PlayerControllerInterfaceController () <WCSessionDelegate>{
    NSDictionary *params;
}


@end

@implementation PlayerControllerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    params = ((NSDictionary *)context).copy;
    NSURL *url = [[NSBundle mainBundle] URLForResource:context[@"name"] withExtension:@"mp4"];
    [self presentMediaPlayerControllerWithURL:url options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        
    }];
    // Configure interface objects here.
}

- (IBAction)macPressed {
    
}

- (IBAction)iphonePressed {
    WCSession *session = [WCSession defaultSession];
    
    if ([session isReachable])
    {
        NSDictionary *dictionary = @{ @"url": params[@"url"]};
        
        [[WCSession defaultSession] sendMessage:dictionary replyHandler:^(NSDictionary<NSString *,id> * __nonnull replyMessage) {
            NSLog(@"Reply Info: %@", replyMessage);
            
        } errorHandler:^(NSError * __nonnull error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }];
    }
    else
    {
        NSLog(@"session not reachable");
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



