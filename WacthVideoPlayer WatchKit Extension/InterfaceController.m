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


@implementation InterfaceController

NSInteger _selectedItem;
NSDictionary *_moviesDict;

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
    _moviesDict = @{@0:@"Social Network",
                    @1:@"Disney",
                    @2:@"Planes"};
    WKPickerItem *item1 = [self createPickerItemWithImageName:@"movie1" andExtension:@"png" andCaption:@"Movie1"];
    //    [item1 setTitle:@"hello"];
    WKPickerItem *item2 = [self createPickerItemWithImageName:@"movie2" andExtension:@"gif" andCaption:@"Movie2"];
    WKPickerItem *item3 = [self createPickerItemWithImageName:@"movie3" andExtension:@"png" andCaption:@"Movie3"];
    [self setButtonTitleWithIndex:0];
    [_picker setItems:@[item1, item2, item3]];
    [_picker setEnabled:YES];

}

- (IBAction)teleport:(id)sender
{
    WCSession *session = [WCSession defaultSession];
    
    if ([session isReachable])
    {
        NSDictionary *dictionary = @{ @"TextInput": @"1"};

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



