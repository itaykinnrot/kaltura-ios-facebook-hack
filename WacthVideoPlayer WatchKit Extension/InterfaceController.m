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
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *trailerButton;

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
    _moviesDict = @{@0:@"cloudy",
                    @1:@"frozen",
                    @2:@"inside"};
    WKPickerItem *item1 = [self createPickerItemWithImageName:@"cloudy" andExtension:@"jpg" andCaption:@"Movie1"];
    //    [item1 setTitle:@"hello"];
    WKPickerItem *item2 = [self createPickerItemWithImageName:@"frozen" andExtension:@"jpg" andCaption:@"Movie2"];
    WKPickerItem *item3 = [self createPickerItemWithImageName:@"inside" andExtension:@"jpg" andCaption:@"Movie3"];
    [self setButtonTitleWithIndex:0];
    [_picker setItems:@[item1, item2, item3]];
    [_picker setEnabled:YES];

}

- (IBAction)TapButton {
    [self setupMovieTrailerForItem:_selectedItem];
}

- (void)setButtonTitleWithIndex:(NSInteger) value
{
    [_trailerButton setTitle:[_moviesDict objectForKey:[NSNumber numberWithInt:value]]];
}


- (WKPickerItem *) createPickerItemWithImageName:(NSString *)imgname andExtension:(NSString *)imgExtension andCaption:(NSString *)caption
{
    WKPickerItem *item = [[WKPickerItem alloc] init];
    //        [item setTitle:@"hello"];
    //    [item setCaption:caption];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imgname withExtension:imgExtension];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [item setContentImage:[WKImage imageWithImageData:data]];
    return item;
}

- (void) setupMovieTrailerForItem:(NSInteger)value {
    [self presentControllerWithName:@"player" context:nil];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mvcarchitecture" withExtension:@"mp4"];
//    [self.player setMovieURL:url];
//    [self presentMediaPlayerControllerWithURL:url options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
//        
//    }];
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



