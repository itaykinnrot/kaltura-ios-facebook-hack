//
//  InterfaceController.m
//  WacthVideoPlayer WatchKit Extension
//
//  Created by Nissim Pardo on 8/5/15.
//  Copyright © 2015 kaltura. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceMovie *player;

@end
//5050246

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mvcarchitecture" withExtension:@"mp4"];
    url = [NSURL URLWithString:@"http://cfvod.kaltura.com/pd/p/1281471/sp/128147100/serveFlavor/entryId/1_3ts1ms9c/v/1/flavorId/1_6o55whsj/name/a.mp4"];
//    [self.player setMovieURL:url];
    [self presentMediaPlayerControllerWithURL:url options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        
    }];
    // Configure interface objects here.
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



