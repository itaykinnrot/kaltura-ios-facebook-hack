//
//  InterfaceController.m
//  WacthVideoPlayer WatchKit Extension
//
//  Created by Nissim Pardo on 8/5/15.
//  Copyright © 2015 kaltura. All rights reserved.
//

@import WatchConnectivity;
#import "InterfaceController.h"


@interface InterfaceController() <WCSessionDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceMovie *player;

@end
//5050246

@implementation InterfaceController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [WCSession defaultSession].delegate = self;
        [[WCSession defaultSession] activateSession];
    }
    
    return self;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
//    [self.player setMovieURL:[self url]];
//    [self presentMediaPlayerControllerWithURL:[self url] options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
//        [self teleport:nil];
//    }];
    // Configure interface objects here.
}

- (NSURL *)url
{
    return [[NSBundle mainBundle] URLForResource:@"mvcarchitecture" withExtension:@"mp4"];
}

- (IBAction)teleport:(id)sender
{
    WCSession *session = [WCSession defaultSession];
    
    if ([session isReachable])
    {
        NSDictionary *dictionary = @{ @"URL": [self url] };
        [session sendMessage:dictionary
                replyHandler:^(NSDictionary<NSString *, id> *replyMessage){
                    NSLog(@"reply");
                }
                errorHandler:^(NSError *error){
                    NSLog(@"error");
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



