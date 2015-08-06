//
//  PlayerControllerInterfaceController.m
//  WacthVideoPlayer
//
//  Created by Nissim Pardo on 8/6/15.
//  Copyright © 2015 kaltura. All rights reserved.
//

#import "PlayerControllerInterfaceController.h"

@interface PlayerControllerInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceMovie *player;

@end

@implementation PlayerControllerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mvcarchitecture" withExtension:@"mp4"];
    [self presentMediaPlayerControllerWithURL:url options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        
    }];
    // Configure interface objects here.
}
- (IBAction)moveToDevice {
    
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



