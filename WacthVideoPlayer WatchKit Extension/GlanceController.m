//
//  GlanceController.m
//  WacthVideoPlayer WatchKit Extension
//
//  Created by Nissim Pardo on 8/5/15.
//  Copyright © 2015 kaltura. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mvcarchitecture" withExtension:@"mp4"];
    //    [self.player setMovieURL:url];
    [self presentMediaPlayerControllerWithURL:url options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        
    }];
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



